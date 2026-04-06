#!/usr/bin/env node

/**
 * PreToolUse Hook
 *
 * Checks:
 * 1. Block Edit/Write on main branch
 * 2. Block Edit/Write operations that contain credentials/secrets
 */

import { execSync } from 'child_process';
import { readFileSync } from 'fs';

const CREDENTIAL_PATTERNS = [
  // API Keys and Tokens
  /(?:api[_-]?key|token|secret|password|credential)[\s=:["']+[A-Za-z0-9_\-]{20,}/gi,

  // AWS
  /AKIA[A-Z0-9]{16}/g,
  /aws.*session.*token[\s=:]["'][A-Za-z0-9/+=]{16,}/gi,

  // DigitalOcean
  /dop_v1_[a-f0-9]{64}/g,

  // Tana
  /tana[\s\w]{0,20}(?:api)?[_-]?token[\s=:]["'][A-Za-z0-9_\-]{20,}/gi,

  // Generic base64-like strings (potential secrets)
  /["'][A-Za-z0-9/+]{40,}={0,2}["']/g,

  // URLs with credentials
  /https?:\/\/[^\s"']+:[^\s"@']+@/gi,
];

const SAFE_PATTERNS = [
  // Comments and docs
  /^\s*\/\/.*$/,
  /^\s*#.*$/,
  /^\s*\*.*$/,

  // Example/placeholder values
  /example/i,
  /placeholder/i,
  /your_[\w_]+_here/i,
  /<[^>]+>/,

  // Environment variable references (safe)
  /process\.env\.[A-Z_]+/,
  /\${[A-Z_]+}/,

  // Test files
  /\.test\./,
  /\.spec\./,
  /__tests__/,
];

function isSafeContext(content, match) {
  const lines = content.split('\n');
  for (const line of lines) {
    if (line.includes(match)) {
      // Check if line matches any safe pattern
      for (const safePattern of SAFE_PATTERNS) {
        if (safePattern.test(line)) {
          return true;
        }
      }
    }
  }
  return false;
}

function checkForCredentials(content) {
  const matches = [];

  for (const pattern of CREDENTIAL_PATTERNS) {
    const found = content.match(pattern);
    if (found) {
      for (const match of found) {
        if (!isSafeContext(content, match)) {
          matches.push({
            pattern: pattern.toString(),
            match: match.substring(0, 50) + (match.length > 50 ? '...' : ''),
          });
        }
      }
    }
  }

  return matches;
}

function getGitBranch() {
  try {
    return execSync('git branch --show-current 2>/dev/null', {
      encoding: 'utf-8',
      stdio: ['pipe', 'pipe', 'pipe'],
    }).trim();
  } catch {
    return null;
  }
}

function main() {
  const tool = process.env.CLADE_TOOL_NAME || '';
  const filePath = process.env.CLADE_FILE_PATH || '';

  // Only check Edit and Write operations
  if (!['Edit', 'Write'].includes(tool)) {
    process.exit(0);
  }

  // Check 1: Block edits on main branch
  const branch = getGitBranch();
  if (branch === 'main') {
    const errorMsg = {
      block: true,
      reason: 'Cannot edit files on main branch. Create a feature branch first: git checkout -b feat/<name>',
    };
    console.error(JSON.stringify(errorMsg));
    process.exit(2);
  }

  // Check 2: Block operations that contain credentials
  // Read file content if it exists
  try {
    const content = readFileSync(filePath, 'utf-8');
    const credentials = checkForCredentials(content);

    if (credentials.length > 0) {
      const errorMsg = {
        block: true,
        reason: `File contains potential credentials or secrets:\n${credentials.map(c => `  - Pattern: ${c.pattern}\n    Match: ${c.match}`).join('\n')}\n\nUse environment variables instead. See CLAUDE.md Security Rules.`,
      };
      console.error(JSON.stringify(errorMsg));
      process.exit(3);
    }
  } catch (error) {
    // File doesn't exist yet (Write operation), allow it
    if (error.code !== 'ENOENT') {
      // Other error, log but don't block
      console.error(`Warning: Could not read file: ${error.message}`);
    }
  }

  process.exit(0);
}

main();
