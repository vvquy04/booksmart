# Payment Database Design

Version: 1.1

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document defines the database design for the Payment module. It manages payment records, gateway transactions, and refund auditing for online bookings.

---

# 2. Tables

*   `payments`
*   `payment_transactions`
*   `payment_refunds`

---

# 3. Table: payments

## Description

Stores the primary payment record associated with a booking.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `booking_id` | BIGINT | FK → `bookings.id` | The booking reference |
| `amount` | DECIMAL(12,2) | NOT NULL | The total paid amount |
| `payment_method` | VARCHAR(50) | NOT NULL | `CASH`, `VNPAY`, `MOMO`, `STRIPE` |
| `status` | VARCHAR(20) | NOT NULL | `PENDING`, `PAID`, `FAILED`, `REFUNDED` |
| `created_at` | DATETIME | NOT NULL | Audit timestamp |
| `updated_at` | DATETIME | NOT NULL | Audit timestamp |

---

# 4. Table: payment_transactions

## Description

Stores the detailed transaction records returned by the payment gateways for verification and auditing.

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `payment_id` | BIGINT | FK → `payments.id` | Reference to payment |
| `transaction_no` | VARCHAR(100) | UNIQUE | Unique identifier from the payment gateway |
| `amount` | DECIMAL(12,2) | NOT NULL | Transaction amount |
| `status` | VARCHAR(20) | NOT NULL | `PENDING`, `SUCCESS`, `FAILED` |
| `gateway_response` | TEXT | NULL | Raw JSON dump from the payment gateway for auditing |
| `created_at` | DATETIME | NOT NULL | Creation timestamp |

---

# 5. Table: payment_refunds

## Description

Stores data related to refund payouts processed when a customer cancels their booking (within the cancellation window).

### Columns

| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PK | Unique identifier |
| `payment_id` | BIGINT | FK → `payments.id` | Reference to parent payment |
| `refund_transaction_no` | VARCHAR(100) | UNIQUE | Reference identifier from the payment gateway |
| `amount` | DECIMAL(12,2) | NOT NULL | Refund amount |
| `reason` | VARCHAR(255) | NULL | Reason for refund |
| `status` | VARCHAR(20) | NOT NULL | `PENDING`, `SUCCESS`, `FAILED` |
| `created_at` | DATETIME | NOT NULL | Time the refund was requested |
| `updated_at` | DATETIME | NOT NULL | Update timestamp |

---

# 6. Relationships

```
bookings
  1 ─────────── 1 payments
  
payments
  1 ───────────< payment_transactions
  1 ───────────< payment_refunds
```

---

# 7. Constraints

1.  **Unique Payment**: A booking must have at most one payment record (`booking_id` is unique in the `payments` table).
2.  **Valid Method**: `payment_method` must be one of the supported gateway constants.
3.  **Positive Amount**: `amount` must be greater than zero.
4.  **Refund Bound**: The total amount of all successful records in `payment_refunds` for a payment must not exceed the `amount` of the parent `payments` record.

---

# 8. Indexes

### Unique Indexes
*   `UK_payments_booking`: `UNIQUE(booking_id)`
*   `UK_transactions_no`: `UNIQUE(transaction_no)`
*   `UK_refunds_transaction_no`: `UNIQUE(refund_transaction_no)`

### Performance Indexes
*   `IDX_transactions_payment`: `IDX(payment_id)`
*   `IDX_refunds_payment`: `IDX(payment_id)`