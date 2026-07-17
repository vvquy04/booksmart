# Business Database Design

Version: 1.1

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document defines the database design for the Business module.

The Business module is responsible for managing businesses, branches, employees, services, categories, schedules, and leaves.

---

# 2. Tables

- `business_categories`
- `businesses`
- `branches`
- `employees`
- `service_categories`
- `services`
- `employee_services`
- `business_images`
- `service_images`
- `working_hours`
- `time_slots`
- `employee_schedules`
- `employee_leaves`

---

# 3. Table: business_categories

## Description

Stores top-level business classification types (e.g., Hair Salon, Spa & Wellness, Dental Clinic) to support customer browsing and discoverability.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `name` | VARCHAR(100) | NOT NULL, UNIQUE | Name of category |
| `slug` | VARCHAR(100) | NOT NULL, UNIQUE | URL-friendly name |
| `icon_url` | VARCHAR(500) | NULL | URL to category icon resource |
| `created_at` | DATETIME | NOT NULL | Audit column |
| `updated_at` | DATETIME | NOT NULL | Audit column |

---

# 4. Table: businesses

## Description

Stores all registered businesses.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `owner_id` | BIGINT | FK → `users.id` | The business owner |
| `category_id` | BIGINT | FK → `business_categories.id` | Category of business |
| `name` | VARCHAR(255) | NOT NULL | Name of the business |
| `description` | TEXT | NULL | Profile biography |
| `phone_number` | VARCHAR(20) | NULL | Main contact number |
| `email` | VARCHAR(255) | NULL | General email |
| `website` | VARCHAR(255) | NULL | URL reference |
| `logo_url` | VARCHAR(500) | NULL | Logo image location |
| `status` | VARCHAR(20) | PENDING, VERIFIED, REJECTED, SUSPENDED | System verification status |
| `auto_confirm_booking` | BOOLEAN | DEFAULT FALSE | Automatically accept bookings |
| `created_at` | DATETIME | NOT NULL | Audit column |
| `updated_at` | DATETIME | NOT NULL | Audit column |
| `deleted_at` | DATETIME | NULL | Soft delete field |

---

# 5. Table: branches

## Description

Stores physical business locations.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `business_id` | BIGINT | FK → `businesses.id` | Owner business reference |
| `name` | VARCHAR(255) | NOT NULL | Branch location name |
| `phone_number` | VARCHAR(20) | NULL | Branch contact |
| `email` | VARCHAR(255) | NULL | Branch support email |
| `address` | VARCHAR(500) | NOT NULL | Physical location text |
| `latitude` | DECIMAL(10,8) | NOT NULL | Geolocation coordinate |
| `longitude` | DECIMAL(11,8) | NOT NULL | Geolocation coordinate |
| `status` | VARCHAR(20) | ACTIVE, INACTIVE | Branch operating status |
| `created_at` | DATETIME | NOT NULL | Audit column |
| `updated_at` | DATETIME | NOT NULL | Audit column |
| `deleted_at` | DATETIME | NULL | Soft delete field |

---

# 6. Table: employees

## Description

Stores employee profiles. Authentication information is stored in the `users` table.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `user_id` | BIGINT | FK → `users.id` | Reference to credentials profile |
| `branch_id` | BIGINT | FK → `branches.id` | Work branch location |
| `description` | TEXT | NULL | Staff bio and skills |
| `years_of_experience` | INT | DEFAULT 0 | Years in service |
| `average_rating` | DECIMAL(2,1) | DEFAULT 0 | Computed rating stars |
| `status` | VARCHAR(20) | ACTIVE, INACTIVE | Staff status |
| `created_at` | DATETIME | NOT NULL | Audit column |
| `updated_at` | DATETIME | NOT NULL | Audit column |
| `deleted_at` | DATETIME | NULL | Soft delete field |

---

# 7. Table: service_categories

## Description

Stores service categories grouped per business.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `business_id` | BIGINT | FK → `businesses.id` | Owner business |
| `name` | VARCHAR(255) | NOT NULL | Category name (e.g. "Nails") |
| `description` | TEXT | NULL | Category description |
| `created_at` | DATETIME | NOT NULL | Audit column |
| `updated_at` | DATETIME | NOT NULL | Audit column |

---

# 8. Table: services

## Description

Stores services provided by businesses.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `business_id` | BIGINT | FK → `businesses.id` | Owner business |
| `category_id` | BIGINT | FK → `service_categories.id` | Service group category |
| `name` | VARCHAR(255) | NOT NULL | Service name |
| `description` | TEXT | NULL | Details of what the service includes |
| `price` | DECIMAL(12,2) | NOT NULL | Base charge |
| `duration_minutes` | INT | NOT NULL | Duration in minutes |
| `status` | VARCHAR(20) | ACTIVE, INACTIVE | Active status |
| `created_at` | DATETIME | NOT NULL | Audit column |
| `updated_at` | DATETIME | NOT NULL | Audit column |
| `deleted_at` | DATETIME | NULL | Soft delete field |

---

# 9. Table: employee_services

## Description

Many-to-many relationship mapping which employees can perform which services.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `employee_id` | BIGINT | PK, FK → `employees.id` | The employee |
| `service_id` | BIGINT | PK, FK → `services.id` | The service |

---

# 10. Table: business_images / service_images

## Description

Gallery image files for business profiles and service descriptions.

### business_images Columns
*   `id` (BIGINT, PK)
*   `business_id` (BIGINT, FK -> `businesses.id`)
*   `image_url` (VARCHAR(500), NOT NULL)
*   `display_order` (INT, DEFAULT 0)
*   `created_at` (DATETIME, NOT NULL)

### service_images Columns
*   `id` (BIGINT, PK)
*   `service_id` (BIGINT, FK -> `services.id`)
*   `image_url` (VARCHAR(500), NOT NULL)
*   `display_order` (INT, DEFAULT 0)
*   `created_at` (DATETIME, NOT NULL)

---

# 11. Table: working_hours

## Description

Stores weekly operating hours for each branch location.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `branch_id` | BIGINT | FK → `branches.id` | Reference branch |
| `day_of_week` | TINYINT | 1-7 | 1 (Monday) to 7 (Sunday) |
| `open_time` | TIME | NOT NULL | Operating start time |
| `close_time` | TIME | NOT NULL | Operating close time |
| `is_closed` | BOOLEAN | DEFAULT FALSE | Mark closed on this day |

---

# 12. Table: time_slots

## Description

Pre-defined time slot templates available at a branch (e.g. 30-min intervals).

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `branch_id` | BIGINT | FK → `branches.id` | Reference branch |
| `start_time` | TIME | NOT NULL | Start time of slot |
| `end_time` | TIME | NOT NULL | End time of slot |
| `slot_duration` | INT | NOT NULL | Duration in minutes |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |

---

# 13. Table: employee_schedules

## Description

Configures custom working schedules/shifts for employees.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `employee_id` | BIGINT | FK → `employees.id` | Assigned staff member |
| `day_of_week` | TINYINT | 1-7 | Day of week |
| `start_time` | TIME | NOT NULL | Shift start time |
| `end_time` | TIME | NOT NULL | Shift end time |
| `is_active` | BOOLEAN | DEFAULT TRUE | Toggle active shift |

---

# 14. Table: employee_leaves

## Description

Tracks employee time off and leaves to prevent booking system overlaps.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `employee_id` | BIGINT | FK → `employees.id` | Reference employee |
| `start_date` | DATE | NOT NULL | Leave start date |
| `end_date` | DATE | NOT NULL | Leave end date (inclusive) |
| `reason` | VARCHAR(255) | NULL | Reason text |
| `status` | VARCHAR(20) | PENDING, APPROVED, REJECTED | Leave approval status |
| `created_at` | DATETIME | NOT NULL | Request timestamp |
| `updated_at` | DATETIME | NOT NULL | Update timestamp |

---

# 15. Relationships

```
business_categories (1)
  └──────< businesses (1)
             ├──────< branches (1)
             │          ├──────< employees (1)
             │          │          ├──────< employee_schedules
             │          │          └──────< employee_leaves
             │          ├──────< working_hours
             │          └──────< time_slots
             ├──────< services (1)
             │          ├──────< service_images
             │          └──────> employee_services (N)
             ├──────< service_categories (1)
             │          └──────< services
             └──────< business_images
```

---

# 16. Indexes

### business_categories
*   `UK_categories_slug`: `UNIQUE(slug)`

### businesses
*   `IDX_businesses_owner`: `IDX(owner_id)`
*   `IDX_businesses_category`: `IDX(category_id)`
*   `IDX_businesses_status`: `IDX(status)`

### employee_schedules
*   `IDX_emp_schedules_lookup`: `IDX(employee_id, day_of_week)`

### employee_leaves
*   `IDX_emp_leaves_range`: `IDX(employee_id, start_date, end_date, status)`

---

# 17. Business Constraints

- One Business is mapped to exactly one Business Category.
- Employees work shifts registered in `employee_schedules`. If no schedule is registered, they defaults to the branch's open hours.
- A customer cannot book an employee on dates they have an `APPROVED` record in `employee_leaves`.