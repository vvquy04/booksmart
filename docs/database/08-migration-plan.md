# Database Migration Plan

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document outlines the database migration plan using Flyway. It describes migration scripts location, naming conventions, execution phases, and verification procedures.

---

# 2. Migration Tool & Setup

*   **Tool**: **Flyway**.
*   **Target Location**: `src/main/resources/db/migration/`
*   **Local Run Mode**: Automatically runs on Spring Boot application startup during developer deployment.

---

# 3. Naming Conventions

All migration files must strictly follow the Flyway default naming pattern:

```
V<Version_Number>__<Camel_Case_Description>.sql
```

### Examples
*   `V1__Initial_Authentication_Schema.sql`
*   `V2__Add_Business_And_Services_Tables.sql`
*   `V3__Seed_Roles_And_Admin.sql`

---

# 4. Migration Execution Phases

The schema deployment is broken down into sequential versions:

### Phase 1: Authentication (`V1`)
*   Creates `roles`, `users`, and `refresh_tokens` tables.
*   Sets up foreign keys and unique indexes on emails/tokens.

### Phase 2: Business & Scheduling Core (`V2`)
*   Creates `businesses`, `branches`, `employees`, `service_categories`, `services`, `employee_services`, `business_images`, `service_images`, `working_hours`, and `time_slots` tables.

### Phase 3: Booking & Execution Core (`V3`)
*   Creates `bookings`, `booking_items`, `booking_status_histories`, and `check_ins` tables.

### Phase 4: Payment Module (`V4`)
*   Creates `payments` and `payment_transactions` tables.

### Phase 5: Feedback & Review Module (`V5`)
*   Creates `reviews` tables.

### Phase 6: Notification & Auditing Module (`V6`)
*   Creates `notifications` and `ai_recommendation_logs` tables.

---

# 5. Rollback & Migration Verification

1.  **Immutability**: Once a migration file is committed to the version control system (Git), it must **never** be edited. Any subsequent changes require a new version file (e.g. `V2.1` or `V3`).
2.  **Verification**: After running migrations in local environments, the Flyway status check should be run:
    ```bash
    mvn flyway:info
    ```
3.  **Local Reset**: In developer environments, the database schema can be reset and rebuilt using:
    ```bash
    mvn flyway:clean flyway:migrate
    ```
    *(Note: `flyway:clean` must be disabled in production configurations for safety).*
