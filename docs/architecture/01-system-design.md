# System Design

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document describes the overall architecture of the BookSmart system.

It defines how different modules collaborate while maintaining low coupling and high cohesion.

---

# 2. Architecture Style

BookSmart follows the **Modular Monolith** architecture.

Each business domain is separated into an independent module while sharing the same deployment unit and database.

---

# 3. Why Modular Monolith?

Reasons for choosing this architecture:

- Easier to develop and maintain.
- Faster deployment.
- Simpler debugging.
- Lower infrastructure cost.
- Suitable for startup and medium-scale systems.
- Can be migrated to Microservices in the future.

---

# 4. System Modules

The backend consists of the following modules.

Authentication

- User
- Role
- Refresh Token

Business

- Business
- Branch
- Employee
- Service
- Service Category

Booking

- Booking
- Booking Item
- Check-in

Payment

- Payment
- Payment Transaction

Review

- Review

Notification

- Notification

AI Recommendation

- Recommendation Engine
- Recommendation Log

---

# 5. Layered Architecture

Controller Layer

↓

Service Layer

↓

Repository Layer

↓

Database

Each module follows the same architecture.

---

# 6. Package Structure

com.booksmart

- auth
- user
- business
- booking
- payment
- review
- notification
- ai
- common
- config
- security

---

# 7. Authentication Flow

Client

↓

JWT Authentication

↓

Spring Security

↓

Authorization

↓

Business Module

---

# 8. Database

Database Engine

MySQL

Migration Tool

Flyway

ORM

Spring Data JPA

---

# 9. External Services

Google Maps API

Purpose

- Geocoding
- Distance Calculation
- Nearby Search

Future

- VNPay
- MoMo
- Firebase Cloud Messaging
- Email Service

---

# 10. Logging

Application Log

Spring Boot Logging

Future

Centralized Logging

- ELK Stack

---

# 11. Exception Handling

Global Exception Handler

Custom Exception

Business Exception

Validation Exception

Authentication Exception

---

# 12. Security

Authentication

JWT

Authorization

Role Based Access Control

Password Encryption

BCrypt

---

# 13. Caching

Version 1.0

No Cache

Future

Redis Cache

---

# 14. Search

Version 1.0

MySQL Full Text Search

Future

Elasticsearch

---

# 15. Deployment

Docker

↓

Spring Boot

↓

MySQL

Future

Docker Compose

↓

Nginx

↓

Spring Boot

↓

MySQL

---

# 16. Design Principles

- Single Responsibility Principle
- Open Closed Principle
- Dependency Injection
- Clean Architecture
- Modular Design
- Low Coupling
- High Cohesion

---

# 17. Scalability

Future improvements

- Redis
- Message Queue
- Microservices
- Kubernetes
- Object Storage
- CDN

---

# 18. Summary

BookSmart adopts a Modular Monolith architecture because it balances development speed, maintainability and future scalability.

The architecture is designed to support production-ready backend development while remaining simple enough for a single development team.