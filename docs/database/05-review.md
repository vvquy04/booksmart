# Review Database Design

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document defines the database design for the Review module. The Review module allows customers to write ratings and text feedback for businesses, service providers (employees), and specific services.

---

# 2. Tables

*   `reviews`

---

# 3. Table: reviews

## Description

Stores customer ratings and text reviews.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `customer_id` | BIGINT | FK → `users.id` | Customer who wrote the review |
| `booking_id` | BIGINT | FK → `bookings.id` | The booking triggering this review |
| `business_id` | BIGINT | FK → `businesses.id` | Business being reviewed |
| `employee_id` | BIGINT | FK → `employees.id` (Null) | Optional: employee being reviewed |
| `service_id` | BIGINT | FK → `services.id` (Null) | Optional: service being reviewed |
| `rating` | TINYINT | NOT NULL | Numeric rating (1 to 5 stars) |
| `comment` | TEXT | NULL | Written feedback |
| `created_at` | DATETIME | NOT NULL | Audit field |
| `updated_at` | DATETIME | NOT NULL | Audit field |
| `deleted_at` | DATETIME | NULL | Soft delete field |

---

# 4. Relationships

```
users (Customer)
  1 ───────────< reviews
  
bookings
  1 ───────────< reviews
  
businesses
  1 ───────────< reviews
  
employees
  1 ───────────< reviews (Optional)
  
services
  1 ───────────< reviews (Optional)
```

---

# 5. Constraints

1.  **Rating Range**: The rating column must satisfy: `rating >= 1 AND rating <= 5`.
2.  **Completeness Rule**: A review can only be created if the corresponding `booking_id` status is `COMPLETED`.
3.  **Uniqueness Constraint**: A customer can only write one review per `booking_id` (enforced via a unique index on `booking_id`).

---

# 6. Indexes

### Unique Indexes
*   `UK_reviews_booking`: `UNIQUE(booking_id)` - Prevents double-reviews on the same booking.

### Performance Indexes
*   `IDX_reviews_customer`: `IDX(customer_id)` - Speeds up retrieving reviews written by a customer.
*   `IDX_reviews_business`: `IDX(business_id)` - Speeds up fetching reviews for a business branch.
*   `IDX_reviews_employee`: `IDX(employee_id)` - For querying ratings of specific employees.
*   `IDX_reviews_service`: `IDX(service_id)` - For querying ratings of specific services.
