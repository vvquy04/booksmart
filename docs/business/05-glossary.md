# Glossary

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document defines the common terminology and abbreviations used across the BookSmart project. It ensures a shared understanding of business and technical terms for developers, business owners, and other stakeholders.

---

# 2. Business Terms

### Business
An enterprise registered on the platform providing appointment-based services (e.g., Luxury Spa, Smile Dental, Hair Salon).

### Business Owner
The user role responsible for business operations, managing branches, configuring services, registering staff, and reviewing revenue dashboards.

### Branch
A physical location of a business where services are rendered. A single business can own multiple branches.

### Customer
An end-user who registers on the platform to discover services, receive AI recommendations, schedule bookings, and complete online payments.

### Employee
A service provider account created and managed by the Business Owner, assigned to a specific branch. Employees perform services and update booking execution status.

### Booking
An agreement where a customer reserves service slots at a branch. A booking can contain multiple booking items.

### Booking Item
A single service reservation within a booking, referencing a specific service, a chosen employee, a price snapshot, and a scheduled time range.

### Service Category
A logical grouping of services (e.g., "Haircuts", "Facial Care", "Massages") configured by a business to organize their catalog.

### Service
A specific task or treatment provided by a branch, with a designated duration, price, and required staff expertise.

### Working Hour
The scheduled open/close operating hours configured weekly for a branch.

### Time Slot
A bookable segment of time representing available appointments for service delivery at a branch.

---

# 3. Technical Terms

### Modular Monolith
An architectural style where all modules are compiled and deployed together, but structured cleanly into independent packages with loose coupling and high cohesion.

### JWT (JSON Web Token)
An open standard (RFC 7519) used to securely transmit information between client and server as a JSON object, used in BookSmart for stateless authentication.

### Refresh Token
A long-lived token used to obtain a new short-lived JWT access token when the current JWT expires, preventing the user from needing to log in repeatedly.

### BCrypt
A password-hashing function based on the Blowfish cipher, incorporating a salt to protect passwords against rainbow table and brute-force attacks.

### Flyway
An open-source database migration tool used to manage and version SQL schema evolutions across environments.

### Soft Delete
A technique where rows in the database are not physically deleted but marked as inactive using a timestamp column (`deleted_at`), preserving data integrity.

### Audit Columns
Standard metadata columns (`created_at`, `updated_at`) automatically updated by the system to track when records are created or modified.

### VNPay / MoMo
Common electronic payment gateways used in Vietnam, integrated via REST APIs and secure webhooks to process online transactions.

### spatial index
An index type used in databases to optimize spatial queries (e.g. searching for branches based on geographic latitude and longitude coordinates).
