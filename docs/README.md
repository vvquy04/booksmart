# BookSmart Documentation

Welcome to the official documentation of the **BookSmart** project.

BookSmart is a production-ready appointment booking platform designed for businesses such as salons, spas, clinics and other service providers.

This documentation describes the business requirements, system architecture, database design, API specifications and development guidelines.

---

# Documentation Structure

```
docs/
├── business/
├── architecture/
├── database/
├── api/
└── development/
```

---

# Business Documents

| Document | Description |
|----------|-------------|
| 01-product-vision.md | Product vision and project objectives |
| 02-functional-requirements.md | Functional requirements |
| 03-business-rules.md | Business rules |
| 04-use-cases.md | Detailed actor use cases and flows |
| 05-glossary.md | Definitions of business and technical terms |

---

# Architecture Documents

| Document | Description |
|----------|-------------|
| 01-system-design.md | Overall system architecture |
| 02-domain-model.md | Business domain model and aggregates |
| 03-security-design.md | Authentication and authorization details |
| 04-deployment-architecture.md | Deployment, containerization, and dependencies |
| 05-ai-recommendation.md | AI recommendation model and logic |
| 06-logging-strategy.md | Logging and monitoring guidelines |
| 07-exception-handling.md | Global exception hierarchy and formats |
| 08-validation-strategy.md | Validation constraints and annotations |

---

# Database Documents

| Document | Description |
|----------|-------------|
| erd.drawio | ERD source file |
| erd.png | ERD image export |
| 01-authentication.md | Authentication tables schema |
| 02-business.md | Business tables schema |
| 03-booking.md | Booking tables schema |
| 04-payment.md | Payment tables schema |
| 05-review.md | Review tables schema |
| 06-notification.md | Notification tables schema |
| 07-indexes.md | Optimized index definitions |
| 08-migration-plan.md | Schema migration versioning scheme |

---

# API Documents

| Document | Description |
|----------|-------------|
| 01-api-overview.md | API base specifications |
| 02-authentication.md | Authentication and registration endpoints |
| 03-business.md | Businesses, branches, employees, and services APIs |
| 04-booking.md | Booking creation, check-in, and tracking APIs |
| 05-payment.md | VNPay/MoMo integration endpoints |
| 06-review.md | Customer reviews and feedback APIs |
| 07-notification.md | Client notification management APIs |
| 08-ai.md | AI Recommendation discovery APIs |
| 09-response-format.md | Standardized API wrapper structure |
| 10-error-codes.md | Standardized error code codes list |
| 11-authentication-flow.md | Login and refresh token flows (Mermaid) |

---

# Development Documents

| Document | Description |
|----------|-------------|
| 01-environment-setup.md | Local system setup guide |
| 02-project-structure.md | Package hierarchy and folder mappings |
| 03-coding-standard.md | Coding style and conventions |
| 04-git-workflow.md | Git workflows and commit conventions |
| 05-branching-strategy.md | Git branching standards |

---

# Development Workflow

Business Analysis

↓

System Design

↓

Database Design

↓

API Design

↓

Backend Development

↓

Testing

↓

Deployment

---

# Technology Stack

Backend

- Java 21
- Spring Boot
- Spring Security
- Spring Data JPA
- Flyway

Database

- MySQL

Authentication

- JWT
- Refresh Token

Documentation

- OpenAPI
- Markdown

Container

- Docker

Frontend

- Flutter

---

# Project Status

Current Phase

Sprint 0 — System Design

Current Goal

Complete all technical documentation before implementation.