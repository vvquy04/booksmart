# Notification Database Design

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document defines the database design for the Notification module. The Notification module tracks push or system notifications dispatched to customers, business owners, employees, and admins.

---

# 2. Tables

*   `notifications`

---

# 3. Table: notifications

## Description

Stores the history of notifications dispatched to users.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `user_id` | BIGINT | FK → `users.id` | Target recipient user |
| `title` | VARCHAR(255) | NOT NULL | Notification header |
| `content` | TEXT | NOT NULL | Notification body message |
| `type` | VARCHAR(50) | NOT NULL | Type identifier (see types below) |
| `status` | VARCHAR(20) | NOT NULL | `UNREAD`, `READ` |
| `created_at` | DATETIME | NOT NULL | Time the notification was dispatched |
| `updated_at` | DATETIME | NOT NULL | Audit timestamp |

---

# 4. Notification Types

The `type` column supports the following standard domain values:

*   **`BOOKING_CONFIRMED`**: Sent to customers and branch managers when a booking is confirmed.
*   **`BOOKING_CANCELLED`**: Sent to customers, employees, or business owners when a booking is cancelled.
*   **`BOOKING_REMINDER`**: Automated reminder sent ahead of the appointment (e.g., 2 hours before).
*   **`PAYMENT_SUCCESS`**: Sent upon successful gateway transaction checkout.
*   **`PAYMENT_FAILED`**: Sent if a gateway transaction checkout fails.
*   **`SYSTEM_NOTIFICATION`**: Generic platform-wide notices sent by administrators.

---

# 5. Relationships

```
users (Recipient)
  1 ───────────< notifications
```

---

# 6. Indexes

### Performance Indexes
*   `IDX_notifications_user`: `IDX(user_id)` - Used to fetch a user's notification list.
*   `IDX_notifications_unread`: `IDX(user_id, status)` - Composite index optimized to retrieve unread notifications quickly.
