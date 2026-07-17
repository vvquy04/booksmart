# Validation Strategy

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document outlines the validation strategy for the BookSmart platform. It describes validation layers, standard annotations, custom rules, and exception handling processes.

---

# 2. Validation Layers

BookSmart applies validation at three distinct layers:

```
  Client Payload
        │
        ▼
  Controller (DTO Validation) ───► Jakarta Bean Validation (@Valid)
        │
        ▼
  Service (Business Validation) ──► Custom Business Checks & Constraints
        │
        ▼
  Database (DB Constraints) ──────► Unique indexes, Not Null, Foreign Keys
```

1.  **Controller Layer (Syntactic Validation)**: Validates JSON format, check sizes, formatting, and mandatory fields using Jakarta Bean Validation.
2.  **Service Layer (Semantic/Business Validation)**: Validates state and business rules (e.g. employee works at branch, timeslot remains open, user has booking privilege).
3.  **Database Layer (Integrity Validation)**: Enforces schema limits (e.g., unique columns, index validations, column length constraints).

---

# 3. Standard Jakarta Validation Annotations

DTOs are decorated with Jakarta annotations:

*   `@NotNull`: Fields must not be null.
*   `@NotBlank`: Strings must not be blank or contain only whitespaces.
*   `@Size(min=X, max=Y)`: String length boundary.
*   `@Email`: Validate email address formats.
*   `@Pattern(regexp="...")`: Regex-based validation (e.g., phone numbers).
*   `@Min`, `@Max`, `@DecimalMin`: Numerical bounds.
*   `@FutureOrPresent`: Validates dates relative to the current timestamp.

---

# 4. Custom Validators

For domain-specific rules that cannot be validated using standard annotations, we implement custom Hibernate validators:

### A. Phone Number Validator (`@ValidPhoneNumber`)
*   Checks if the phone matches standard Vietnamese formats (starts with `0` or `+84`, has 10-11 digits).

### B. Time Slot Interval Validator (`@ValidTimeSlot`)
*   Ensures that a service start time is chronologically before its end time.

### C. Working Hour Boundaries
*   Checks if a requested booking slot starts and ends inside the branch's defined operating working hours.

---

# 5. Controller Layer Validation Implementation

Controllers validate incoming request bodies by declaring `@Valid` or `@Validated` in method parameters:

```java
@PostMapping("/auth/register")
public ResponseEntity<ApiResponse<UserDto>> register(
    @Valid @RequestBody RegisterRequest request
) {
    ...
}
```

If validation fails, Spring throws a `MethodArgumentNotValidException`. This is caught by the global exception handler, parsed, and converted to the standard validation error payload response.
