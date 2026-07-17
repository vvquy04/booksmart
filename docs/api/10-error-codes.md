# Application Error Codes

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document catalogs the domain-specific error codes returned by the global exception handler in the `errorCode` field of the standard error envelope.

---

# 2. Error Codes Registry

| Error Code | HTTP Status | Description |
| :--- | :--- | :--- |
| **System & Validation** | | |
| `SYS_001` | 500 Internal Server Error | Unhandled runtime exception on the server |
| `VAL_001` | 400 Bad Request | Payload validation failure (invalid format, sizes, etc.) |
| `VAL_002` | 400 Bad Request | Malformed JSON request body |
| **Authentication & Authorization** | | |
| `AUTH_001` | 401 Unauthorized | Bad credentials (incorrect email or password) |
| `AUTH_002` | 401 Unauthorized | Access token expired or invalid |
| `AUTH_003` | 401 Unauthorized | Refresh token expired, revoked, or invalid |
| `AUTH_004` | 403 Forbidden | User does not have the required role to access resource |
| `AUTH_005` | 409 Conflict | Email address is already registered |
| **Business Module** | | |
| `BUS_001` | 404 Not Found | Business not found |
| `BUS_002` | 404 Not Found | Branch not found |
| `BUS_003` | 404 Not Found | Employee not found |
| `BUS_004` | 404 Not Found | Service not found |
| `BUS_005` | 400 Bad Request | Business is suspended or not verified yet |
| `BUS_006` | 400 Bad Request | Employee does not perform the selected service |
| **Booking Module** | | |
| `BOOK_001` | 404 Not Found | Booking not found |
| `BOOK_002` | 409 Conflict | The selected employee is already booked for this slot |
| `BOOK_003` | 400 Bad Request | Time slot is outside branch working hours |
| `BOOK_004` | 400 Bad Request | Cannot cancel booking (completion/cancellation window passed) |
| `BOOK_005` | 400 Bad Request | Customer already checked in or check-in window is invalid |
| **Payment Module** | | |
| `PAY_001` | 404 Not Found | Payment not found |
| `PAY_002` | 409 Conflict | Booking has already been paid for |
| `PAY_003` | 400 Bad Request | Payment transaction signature signature verification failed |
| `PAY_004` | 422 Unprocessable Entity | Payment gateway communication error |
| `PAY_005` | 400 Bad Request | Refund amount exceeds total paid amount |
| `PAY_006` | 422 Unprocessable Entity | Refund transaction rejected by gateway |
| **Review Module** | | |
| `REV_001` | 400 Bad Request | Cannot review booking (must be in COMPLETED status) |
| `REV_002` | 409 Conflict | Booking has already been reviewed |
| `REV_003` | 403 Forbidden | Only the customer who booked the service can write the review |
