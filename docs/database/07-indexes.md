# Database Indexes Catalog

Version: 1.1

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document catalogs all unique constraints and non-unique performance indexes defined across the BookSmart schema.

---

# 2. Unique Constraints & Indexes

Unique indexes enforce data integrity at the database engine level:

| Table | Index Name | Columns | Purpose |
| :--- | :--- | :--- | :--- |
| `roles` | `UK_roles_name` | `name` | Prevent duplicate role names |
| `users` | `UK_users_email` | `email` | Ensure user email is unique |
| `refresh_tokens` | `UK_refresh_tokens` | `token` | Prevent token hijacking and reuse |
| `business_categories` | `UK_categories_slug` | `slug` | Ensure category URL slug is unique |
| `business_categories` | `UK_categories_name` | `name` | Prevent duplicate category names |
| `bookings` | `UK_bookings_number` | `booking_number` | Unique alphanumeric booking reference |
| `employee_services` | `PK_employee_services` | `employee_id`, `service_id` | Compound PK preventing duplicate associations |
| `reviews` | `UK_reviews_booking` | `booking_id` | Enforce one review per booking |
| `payment_transactions` | `UK_transactions_no` | `transaction_no` | Ensure gateway transaction references are unique |
| `payment_refunds` | `UK_refunds_transaction_no` | `refund_transaction_no` | Ensure gateway refund references are unique |

---

# 3. Performance Indexes

These indexes are optimized to accelerate standard query access paths:

### Authentication Module
*   `IDX_users_role`: `users(role_id)` - Accelerates user role lookups.
*   `IDX_tokens_user`: `refresh_tokens(user_id)` - Speeds up token deletion during logout.

### Business Module
*   `IDX_businesses_status`: `businesses(status)` - Used by admins and customers browsing verified business accounts.
*   `IDX_businesses_category`: `businesses(category_id)` - Speeds up filtering businesses by category.
*   `IDX_branches_coords`: `SPATIAL INDEX` or `branches(latitude, longitude)` - Crucial for geospatial search queries ("nearest Spas within 5km").
*   `IDX_employees_branch`: `employees(branch_id)` - Speeds up listing staff for a branch.
*   `IDX_services_business`: `services(business_id, category_id)` - Speeds up category-filtered menus.
*   `IDX_emp_schedules_lookup`: `employee_schedules(employee_id, day_of_week)` - Accelerates checking staff shifts on a specific day.
*   `IDX_emp_leaves_range`: `employee_leaves(employee_id, start_date, end_date, status)` - Speeds up retrieving leave dates for scheduling checks.

### Booking Module
*   `IDX_bookings_customer`: `bookings(customer_id, booking_date)` - Speeds up fetching user booking histories.
*   `IDX_bookings_branch`: `bookings(branch_id, status)` - Speeds up business owner operations dashboard.
*   `IDX_booking_items_range`: `booking_items(employee_id, start_time, end_time)` - Critical for schedule conflict validation.

### Payment Module
*   `IDX_payments_booking`: `payments(booking_id)` - Speeds up checking booking payment status.
*   `IDX_transactions_payment`: `payment_transactions(payment_id)` - Speeds up checking payment history logs.
*   `IDX_refunds_payment`: `payment_refunds(payment_id)` - Speeds up retrieving refunds for a payment.

---

# 4. Indexing Guidelines

1.  **Foreign Key Fields**: Every foreign key column must have a corresponding index to optimize relational joins.
2.  **Soft Delete Coverage**: When querying active records (e.g. `WHERE deleted_at IS NULL`), index structures should ideally support soft-delete exclusions. For instance, partial/filtered indexes are used if supported by the engine, or composite indexes should include `deleted_at` at the tail end if queries frequently filter on it.
3.  **Low-Cardinality Warnings**: Avoid indexing columns with low cardinality (e.g. `gender` or binary flags) unless they are part of a composite index.
