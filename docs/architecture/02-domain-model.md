# Domain Model

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document defines the business domain model of the BookSmart platform.

It focuses on business entities and relationships instead of database implementation.

---

# 2. Domain Overview

BookSmart consists of seven main domains.

- Authentication
- Business
- Booking
- Payment
- Review
- Notification
- AI Recommendation

Each domain is responsible for a specific business capability.

---

# 3. Authentication Domain

## User

Represents every authenticated person in the system.

### Responsibilities

- Authentication
- Authorization
- Profile Management

### Roles

- CUSTOMER
- BUSINESS_OWNER
- EMPLOYEE
- ADMIN

---

## Role

Represents system permissions.

### Relationships

One Role

↓

Many Users

---

## Refresh Token

Stores refresh tokens for JWT authentication.

### Relationships

One User

↓

Many Refresh Tokens

---

# 4. Business Domain

## Business

Represents a registered business.

Examples

- Luxury Spa
- Hair Studio
- Smile Clinic

### Responsibilities

- Manage branches
- Manage services
- Manage employees
- Configure booking policies

### Relationships

Business

↓

Branches

↓

Services

↓

Business Images

---

## Branch

Represents a physical location.

### Responsibilities

- Receive bookings
- Manage employees
- Configure working hours
- Configure time slots

### Relationships

Branch

↓

Employees

↓

Working Hours

↓

Time Slots

↓

Bookings

---

## Employee

Represents a business staff member.

### Responsibilities

- Perform services
- Receive bookings
- Check-in customers
- Update booking progress

### Relationships

Employee

↓

Booking Items

↓

Services

---

## Service Category

Groups services into categories.

Examples

- Hair
- Spa
- Facial
- Massage

### Relationships

Category

↓

Services

---

## Service

Represents a service provided by a business.

### Responsibilities

- Available for booking
- Assigned to employees

### Relationships

Service

↓

Booking Items

↓

Employees

---

## Working Hour

Defines weekly operating schedules.

Examples

Monday

08:00 - 20:00

Tuesday

08:00 - 20:00

---

## Time Slot

Represents bookable appointment slots.

Examples

09:00

09:30

10:00

10:30

---

# 5. Booking Domain

## Booking

Represents one appointment.

### Responsibilities

- Store booking information
- Manage booking lifecycle

### Relationships

Customer

↓

Booking

↓

Booking Items

↓

Payment

↓

Review

↓

Check-In

---

## Booking Item

Represents a single booked service.

Contains

- Service
- Employee
- Price Snapshot
- Duration Snapshot

Purpose

Allows one booking to contain multiple services.

---

## Check-In

Represents customer arrival.

Purpose

- Verify attendance
- Record arrival time
- Store evidence image

---

## Booking Status History

Stores every booking status transition.

Examples

PENDING

↓

CONFIRMED

↓

CHECKED_IN

↓

COMPLETED

---

# 6. Payment Domain

## Payment

Represents payment information.

### Responsibilities

- Store payment status
- Store payment amount

---

## Payment Transaction

Represents payment gateway transactions.

Examples

- VNPay
- MoMo
- Stripe

Purpose

Maintain transaction history.

---

# 7. Review Domain

## Review

Represents customer feedback.

Review Targets

- Business
- Employee
- Service

---

# 8. Notification Domain

## Notification

Represents in-app notifications.

Examples

Booking confirmed

Booking reminder

Payment success

Booking cancelled

---

# 9. AI Recommendation Domain

## AI Recommendation Log

Stores recommendation history.

Purpose

- Analytics
- Model improvement
- Recommendation tracking

---

# 10. Aggregate Roots

Authentication

- User

Business

- Business

Booking

- Booking

Payment

- Payment

Review

- Review

Notification

- Notification

---

# 11. Domain Relationships

User

↓

Business

↓

Branch

↓

Employee

↓

Booking

↓

Booking Item

↓

Service

↓

Payment

↓

Review

↓

Notification

---

# 12. Domain Principles

- One Business Owner can own multiple Businesses.
- One Business contains multiple Branches.
- One Branch contains multiple Employees.
- One Business provides multiple Services.
- Employees can perform multiple Services.
- Customers create Bookings.
- One Booking contains multiple Booking Items.
- Booking Items reference Services.
- Booking Items reference Employees.
- One Booking has one Payment.
- Customers can review completed Bookings only.

---

# 13. Future Extensions

The domain model is designed to support future modules.

- Voucher
- Promotion
- Membership
- Loyalty Point
- CRM
- Chat
- Inventory
- Marketing Automation

without major architecture changes.