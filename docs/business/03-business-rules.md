# Business Rules

Version: 1.1

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document defines all business rules applied throughout the BookSmart platform.

These rules are mandatory and must be enforced by the backend.

---

# 2. User Rules

## BR-001
A user must have exactly one role.
Supported roles:
- CUSTOMER
- BUSINESS_OWNER
- EMPLOYEE
- ADMIN

## BR-002
A user email must be unique.

## BR-003
Passwords must be encrypted using BCrypt.

---

# 3. Business Rules

## BR-004
One Business Owner can own multiple Businesses.

## BR-005
A Business belongs to exactly one Business Owner.

## BR-006
A Business must be verified before accepting bookings.
Business Status:
- PENDING
- VERIFIED
- REJECTED
- SUSPENDED

## BR-041
A Business must belong to exactly one Business Category to support customer-side filtering.

---

# 4. Branch Rules

## BR-007
One Business can contain multiple Branches.

## BR-008
Each Branch belongs to exactly one Business.

## BR-009
Each Branch has its own:
- Working Hours
- Time Slots
- Employees

---

# 5. Employee Rules

## BR-010
Employees are created by Business Owners. Employees cannot self-register.

## BR-011
Every Employee has a User account.

## BR-012
One Employee belongs to exactly one Branch.

## BR-013
Employees can perform multiple Services.

## BR-042
Employees can only be booked during their active shifts defined in `employee_schedules`. If no schedule is configured, the default branch working hours apply.

## BR-043
Employees cannot receive bookings during approved leave periods recorded in `employee_leaves`.

---

# 6. Service Rules

## BR-014
Services belong to Businesses.

## BR-015
Services are grouped by Service Categories.

## BR-016
One Service can be performed by multiple Employees.

---

# 7. Booking Rules

## BR-017
Customers can book multiple Services in a single Booking.

## BR-018
A Booking belongs to one Customer.

## BR-019
A Booking belongs to one Branch.

## BR-020
A Booking contains one or more Booking Items.

## BR-021
Each Booking Item references exactly one Service.

## BR-022
Each Booking Item is assigned to one Employee.

## BR-023
Booking Status:
- PENDING
- CONFIRMED
- CHECKED_IN
- COMPLETED
- CANCELLED
- NO_SHOW

## BR-024
Only completed bookings can be reviewed.

## BR-025
Business Owners define:
- Auto Confirmation
- Cancellation Policy
- Refund Policy

---

# 8. Payment Rules

## BR-026
Every Booking has at most one Payment.

## BR-027
Every Payment may contain multiple Payment Transactions.

## BR-028
Payment status must always match the latest transaction status.

## BR-044
Bookings cancelled within the valid cancellation window are eligible for a refund tracked via `payment_refunds`. The total refund amount cannot exceed the original payment amount.

---

# 9. Review Rules

## BR-029
Customers can review:
- Business
- Employee
- Service

## BR-030
One Booking can be reviewed only once.

---

# 10. Favorite Rules

## BR-031
Customers can save multiple favorite Businesses.

## BR-032
The same Business cannot be added twice.

---

# 11. Notification Rules

## BR-033
Notifications are generated automatically for important events.
Examples:
- Booking Confirmed
- Booking Cancelled
- Payment Success
- Payment Failed

---

# 12. AI Recommendation Rules

## BR-034
AI recommendations are generated using business data.
Recommendation factors include:
- Distance
- Rating
- Booking popularity
- Employee rating
- Service popularity

## BR-035
Recommendation history must be stored in `ai_recommendation_logs` for analytics.

---

# 13. Security Rules

## BR-036
JWT is required for accessing protected APIs.

## BR-037
Role-Based Access Control (RBAC) is enforced.

## BR-038
Only Business Owners can manage their own Businesses.

## BR-039
Employees can only access resources assigned to their Branch.

## BR-040
Administrators have full platform permissions.

---

# 14. Future Rules

The following business rules are reserved for future versions.
- Voucher validation
- Membership levels
- Loyalty points
- Promotion campaigns
- Inventory management
- CRM integration

---

# 15. Summary

These business rules define the core behavior of the BookSmart platform.
All backend services, APIs and database constraints must comply with these rules.