---
name: spec-writing
description: >
  OpenAPI 3.1 and AsyncAPI 3.0 specification writing conventions.
  Auto-invoke when creating or editing YAML spec files, discussing API design,
  or when the spec agent is active.
---

# Spec Writing Conventions

## OpenAPI 3.1 Template

```yaml
openapi: "3.1.0"
info:
  title: <Service Name> API
  version: "1.0.0"
  description: <Brief description>

servers:
  - url: http://localhost:3000/api/v1
    description: Local development

paths:
  /resource:
    get:
      operationId: listResources
      summary: List resources
      tags: [resources]
      parameters:
        - $ref: "#/components/parameters/CursorParam"
        - $ref: "#/components/parameters/LimitParam"
      responses:
        "200":
          description: Success
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/ResourceList"
              example:
                items: [{ id: "abc123", name: "Example" }]
                cursor: "next_abc124"

components:
  parameters:
    CursorParam:
      name: cursor
      in: query
      schema: { type: string }
    LimitParam:
      name: limit
      in: query
      schema: { type: integer, minimum: 1, maximum: 100, default: 20 }

  schemas:
    # Every entity includes these base fields
    BaseEntity:
      type: object
      required: [id, createdAt, updatedAt]
      properties:
        id:
          type: string
          format: uuid
        createdAt:
          type: string
          format: date-time
        updatedAt:
          type: string
          format: date-time

    # Error response per RFC 7807
    ProblemDetail:
      type: object
      required: [type, title, status]
      properties:
        type: { type: string, format: uri }
        title: { type: string }
        status: { type: integer }
        detail: { type: string }
        instance: { type: string, format: uri }
```

## AsyncAPI 3.0 Template

```yaml
asyncapi: "3.0.0"
info:
  title: <Service Name> Events
  version: "1.0.0"

channels:
  userCreated:
    address: events.user.created
    messages:
      UserCreatedMessage:
        $ref: "#/components/messages/UserCreated"

operations:
  publishUserCreated:
    action: send
    channel:
      $ref: "#/channels/userCreated"

components:
  messages:
    UserCreated:
      payload:
        $ref: "#/components/schemas/UserCreatedEvent"

  schemas:
    UserCreatedEvent:
      type: object
      required: [eventId, timestamp, data]
      properties:
        eventId: { type: string, format: uuid }
        timestamp: { type: string, format: date-time }
        data:
          type: object
          required: [userId, email]
          properties:
            userId: { type: string, format: uuid }
            email: { type: string, format: email }
```

## Naming Rules

- Paths: kebab-case `/user-profiles`
- Properties: camelCase `firstName`
- Schema names: PascalCase `UserProfile`
- Operation IDs: camelCase `listUserProfiles`
- Event channels: dot-notation `events.user.created`
