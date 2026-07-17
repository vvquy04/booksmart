# Functional Requirements

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. User Roles

The system supports three primary roles:

- Customer
- Business Owner
- System Administrator

---

# 2. Customer Functional Requirements

## Authentication

- Register
- Login
- Logout
- Forgot Password
- Reset Password

## Profile

- View Profile
- Update Profile
- Change Password
- Upload Avatar

## Business Discovery

- Search Businesses
- Filter Businesses
- View Business Details
- View Branches
- View Services
- View Reviews

## AI Recommendation

- Get Recommended Businesses
- Get Recommended Services
- Get Recommended Employees

## Booking

- Create Booking
- View Booking Details
- Cancel Booking
- Reschedule Booking
- Check-in

## Payment

- Pay Online
- View Payment History

## Favorite

- Add Favorite Business
- Remove Favorite Business

## Review

- Review Business
- Review Service
- Review Employee

## Notification

- Receive Notifications
- View Notification History

---

# 3. Business Owner Functional Requirements

## Business Management

- Create Business
- Update Business
- Manage Branches
- Upload Business Images

## Service Management

- Create Service
- Update Service
- Delete Service
- Configure Price
- Configure Duration

## Employee Management

- Add Employee
- Update Employee
- Assign Services
- Manage Working Hours

## Booking Management

- View Bookings
- Confirm Booking
- Reject Booking
- Manage Booking Status

## Payment Management

- Configure Payment Policy
- View Transactions

## Business Configuration

- Configure Auto Confirmation
- Configure Cancellation Policy
- Configure Refund Policy

## Dashboard

- Revenue Statistics
- Booking Statistics
- Customer Statistics

---

# 4. System Administrator Functional Requirements

- Manage Users
- Manage Businesses
- Verify Businesses
- Handle Reports
- Monitor Platform

---

# 5. Business Rules

BR-001
A Business Owner can own multiple Businesses.

BR-002
A Business can have multiple Branches.

BR-003
Customers book Services and may optionally choose an Employee.

BR-004
Each Business defines its own Payment Policy.

BR-005
Each Business manages its own Services.

BR-006
Employees and Services have a many-to-many relationship.

BR-007
Each Branch defines its own Working Hours.

BR-008
Each Employee belongs to one Branch.

BR-009
Each Business defines the price and duration of its Services.

BR-010
Each Business can enable or disable automatic Booking confirmation.

BR-011
Each Business defines its own Cancellation and Refund Policy.

BR-012
Customers can review Businesses, Services, and Employees after completing a Booking.

BR-013
The system supports the "No Show" Booking status.

BR-014
The system uses a unified User table with Role-based authorization.

BR-015
Roles are managed in a separate Role table.

BR-016
Bookings are created based on predefined Time Slots.