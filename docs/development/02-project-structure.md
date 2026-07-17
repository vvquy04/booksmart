# Project Structure

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Monolith Project Layout

BookSmart adopts a Modular Monolith structure. Each domain is organized as an independent component module within a single Maven project, promoting code boundaries and facilitating future microservices refactoring.

```
booksmart/
├── .github/                  # CI/CD Workflows
├── database/                 # ERD drawings and local assets
├── docker/                   # Dockerfiles and docker-compose configurations
├── docs/                     # Markdown system documentation
├── postman/                  # Postman collection exports for testing
├── scripts/                  # Helper automation scripts
├── src/
│   ├── main/
│   │   ├── java/com/booksmart/
│   │   │   ├── auth/         # Authentication & Authorization Module
│   │   │   ├── user/         # User profile manager
│   │   │   ├── business/     # Business, branch, services & employees
│   │   │   ├── booking/      # Booking schedules & execution check-in
│   │   │   ├── payment/      # VNPay & MoMo integrations
│   │   │   ├── review/       # Ratings & comments feedback
│   │   │   ├── notification/ # Push & system notifications dispatcher
│   │   │   ├── ai/           # Recommender algorithm core
│   │   │   ├── common/       # Cross-cutting concerns (base entities, DTOs)
│   │   │   └── config/       # Spring configurations (security, spatial indexes)
│   │   └── resources/
│   │       ├── db/migration/ # Flyway database migration scripts
│   │       ├── application.yml
│   │       ├── application-dev.yml
│   │       └── application-prod.yml
│   └── test/                 # JUnit & Mockito tests suite
└── pom.xml                   # Maven dependencies config
```

---

# 2. Module Internal Architecture Layers

To maintain loose coupling, each package module (e.g., `booking`) is structured internally into distinct layers:

```
  com.booksmart.booking
  ├── controller/      # REST API endpoints & payload mappings
  ├── dto/             # Request & Response wrappers
  ├── entity/          # JPA entities mapping to MySQL database rows
  ├── repository/      # Spring Data JPA Repository interfaces
  ├── service/         # Business interfaces
  │   └── impl/        # Implementation services containing core logic
  ├── mapper/          # MapStruct converters between Entity and DTO
  └── exception/       # Domain-specific exceptions
```

### Responsibility of Each Layer
*   **Controller**: Converts HTTP requests into Java inputs, calls validation, delegates to Services, and formats outputs into standardized envelope wrappers.
*   **DTO (Data Transfer Object)**: Defines communication contracts. Free of business logic or JPA annotations.
*   **Service**: Coordinates domain transactions. This is where business rules are evaluated.
*   **Repository**: Inherits `JpaRepository` or custom JPA criteria builders to execute database operations.
*   **Entity**: Standard Java persistence files decorated with JPA tags, Audit columns, and Soft Delete listeners.
*   **Mapper**: Interfaces defined using **MapStruct** that generate type-safe mappings between entities and DTOs at compile time.
