# Functional Requirements

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document describes all functional requirements of the BookSmart platform.

---

# 2. User Roles

The platform supports four roles.

- Customer
- Business Owner
- Employee
- Administrator

---

# 3. Customer Functional Requirements

## Authentication

- Register account
- Login
- Logout
- Reset password
- Refresh access token

---

## Profile

- View profile
- Update profile
- Change password
- Upload avatar

---

## Business Discovery

- Search businesses
- Search branches
- Search services
- Filter by category
- Filter by rating
- Filter by distance

---

## AI Recommendation

- Recommend businesses
- Recommend services
- Recommend employees

---

## Booking

- Create booking
- Select branch
- Select multiple services
- Select employee (optional)
- View booking
- Cancel booking
- Reschedule booking
- View booking history

---

## Check-in

- Online check-in
- Upload check-in image

---

## Payment

- Online payment
- View payment history

---

## Review

- Review business
- Review employee
- Review service

---

## Favorite

- Save favorite businesses
- Remove favorite businesses

---

## Notification

- Receive notifications
- View notification history

---

# 4. Business Owner Functional Requirements

## Business Management

- Create business
- Update business
- Delete business
- Upload business images

---

## Branch Management

- Create branch
- Update branch
- Delete branch

---

## Employee Management

- Create employee account
- Update employee
- Delete employee
- Assign services

---

## Service Management

- Create categories
- Create services
- Update services
- Delete services

---

## Working Hours

- Configure working hours
- Configure time slots

---

## Booking Management

- View bookings
- Confirm bookings
- Reject bookings
- Complete bookings
- Mark no-show

---

## Payment Management

- Configure payment policy
- Configure cancellation policy
- Configure refund policy

---

## Dashboard

- Revenue statistics
- Booking statistics
- Employee statistics
- Customer statistics

---

# 5. Employee Functional Requirements

## Authentication

- Login
- Logout

---

## Booking

- View assigned bookings
- Update booking progress
- Check in customers
- Complete services

---

## Schedule

- View work schedule
- View assigned services

---

# 6. Administrator Functional Requirements

- Verify businesses
- Manage users
- Suspend businesses
- View reports
- Monitor platform

---

# 7. Functional Modules

Authentication

- Register
- Login
- Refresh Token
- Authorization

---

Business

- Business
- Branch
- Employee
- Service
- Service Category

---

Booking

- Booking
- Booking Item
- Check-in

---

Payment

- Payment
- Transaction

---

Review

- Review

---

Notification

- Notification

---

AI

- Recommendation

---

# 8. Business Constraints

- One Business Owner can own multiple Businesses.
- One Business can have multiple Branches.
- One Branch manages multiple Employees.
- One Business provides multiple Services.
- Employees can perform multiple Services.
- Customers can book multiple Services in one Booking.
- Business Owners create Employee accounts.
- Businesses must be verified before accepting bookings.
- Customers can only review completed bookings.
- Every booking belongs to exactly one branch.
- Every payment belongs to exactly one booking.

---

# 9. Out of Scope (Version 1.0)

The following features are excluded from Version 1.0.

- Membership
- Voucher
- Promotion
- Loyalty Point
- Chat
- Inventory
- Multi-language
- Multi-tenant
- Email Marketing
- SMS Marketing

---

# 10. Summary

The functional requirements defined in this document serve as the foundation for database design, API specification, backend implementation and testing.