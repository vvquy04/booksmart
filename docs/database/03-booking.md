# Booking Database Design

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document describes the database design for the Booking module.

---

# 2. Tables

- bookings
- booking_items
- booking_status_histories
- check_ins

---

# 3. Table: bookings

## Description

Represents one appointment created by a customer.

### Columns

| Column | Type | Constraint |
|---------|------|------------|
| id | BIGINT | PK |
| customer_id | BIGINT | FK → users.id |
| branch_id | BIGINT | FK → branches.id |
| booking_number | VARCHAR(30) | UNIQUE |
| booking_date | DATE | NOT NULL |
| status | VARCHAR(20) | |
| note | TEXT | NULL |
| total_amount | DECIMAL(12,2) | |
| created_at | DATETIME | |
| updated_at | DATETIME | |
| deleted_at | DATETIME | |

---

# 4. Table: booking_items

## Description

Represents a single booked service.

### Columns

| Column | Type | Constraint |
|---------|------|------------|
| id | BIGINT | PK |
| booking_id | BIGINT | FK |
| service_id | BIGINT | FK |
| employee_id | BIGINT | FK |
| service_name | VARCHAR(255) | Snapshot |
| service_price | DECIMAL(12,2) | Snapshot |
| duration_minutes | INT | Snapshot |
| start_time | DATETIME | |
| end_time | DATETIME | |
| status | VARCHAR(20) | |

---

# 5. Table: booking_status_histories

## Description

Stores booking status changes.

### Columns

| Column | Type | Constraint |
|---------|------|------------|
| id | BIGINT | PK |
| booking_id | BIGINT | FK |
| old_status | VARCHAR(20) | |
| new_status | VARCHAR(20) | |
| changed_by | BIGINT | FK → users.id |
| changed_at | DATETIME | |

---

# 6. Table: check_ins

## Description

Stores customer check-in information.

### Columns

| Column | Type | Constraint |
|---------|------|------------|
| id | BIGINT | PK |
| booking_id | BIGINT | FK |
| employee_id | BIGINT | FK |
| image_url | VARCHAR(500) | NULL |
| check_in_time | DATETIME | |
| status | VARCHAR(20) | |
| created_at | DATETIME | |

---

# 7. Relationships

users (Customer)

1 ------ N bookings

branches

1 ------ N bookings

bookings

1 ------ N booking_items

bookings

1 ------ N booking_status_histories

bookings

1 ------ 1 check_ins

employees

1 ------ N booking_items

services

1 ------ N booking_items

---

# 8. Booking Status

- PENDING
- CONFIRMED
- CHECKED_IN
- COMPLETED
- CANCELLED
- NO_SHOW

---

# 9. Constraints

- Booking must contain at least one Booking Item.
- Customer cannot review incomplete bookings.
- Booking cannot be cancelled after completion.
- Employee schedule must not overlap.
- Time Slot must be available before booking.

---

# 10. Indexes

bookings

- IDX(customer_id)
- IDX(branch_id)
- IDX(status)
- IDX(booking_date)

booking_items

- IDX(booking_id)
- IDX(employee_id)
- IDX(service_id)

booking_status_histories

- IDX(booking_id)

check_ins

- IDX(booking_id)