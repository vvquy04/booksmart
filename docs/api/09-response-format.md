# API Response Format Standard

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document outlines the standard envelope schema for all REST responses dispatched by the BookSmart backend. Enforcing this consistency allows client applications (Flutter mobile clients and web portals) to reuse deserialization classes.

---

# 2. Response Wrapper Schema

Every API response must be wrapped in the following JSON structure:

```json
{
  "success": true,
  "message": "Operation completed successfully",
  "data": {},
  "errors": {},
  "timestamp": "2026-07-17T11:29:42Z"
}
```

### Fields Specification

| Key | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `success` | BOOLEAN | Always Present | `true` for HTTP 2xx statuses; `false` otherwise. |
| `message` | VARCHAR(255) | Always Present | Localized human-readable summary of the response. |
| `data` | OBJECT / ARRAY | Nullable | Payload payload matching success requests. Must be `null` in case of errors. |
| `errors` | MAP<String, String> | Nullable | Validation errors (Field Name vs Error Message). Always `null` on success. |
| `timestamp` | DATETIME | Always Present | ISO-8601 UTC timestamp of execution. |

---

# 3. Success Payload Examples

### Object Payload (HTTP 200 OK)
```json
{
  "success": true,
  "message": "Resource fetched",
  "data": {
    "id": 1,
    "name": "Luxury Haircut"
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:42Z"
}
```

### List/Collection Payload (HTTP 200 OK)
Note: Collections use a standard Spring Data Page wrapper structure under `data`.
```json
{
  "success": true,
  "message": "Collection fetched",
  "data": {
    "content": [
      { "id": 1, "name": "Item A" }
    ],
    "pageNumber": 0,
    "pageSize": 10,
    "totalElements": 1,
    "totalPages": 1
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:42Z"
}
```
