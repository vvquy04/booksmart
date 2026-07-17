# Environment Setup Guide

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Prerequisites

Before setting up the project, ensure you have the following software installed:

*   **Java Development Kit (JDK)**: Version 21 (Amazon Corretto, Eclipse Temurin, or Oracle OpenJDK).
*   **Build Tool**: Apache Maven 3.9+.
*   **Containerization**: Docker and Docker Compose (v2+).
*   **Database Client**: DBeaver, MySQL Workbench, or DataGrip.
*   **Integrated Development Environment (IDE)**: IntelliJ IDEA (Recommended) or VS Code.

---

# 2. Local Environment Configuration

Clone the repository and copy the environment template:

```bash
git clone https://github.com/vvquy04/booksmart.git
cd booksmart
cp .env.example .env
```

### Database Environment Variables (`.env`)
Configure database parameters to match your local Docker Compose instance:
```properties
DB_HOST=localhost
DB_PORT=3306
DB_NAME=booksmart_db
DB_USERNAME=booksmart_user
DB_PASSWORD=SecureDbPassword123!
JWT_SECRET=9a8b7c6d5e4f3g2h1i0j9k8l7m6n5o4p3q2r1s0t9u8v7w6x5y4z3210
```

---

# 3. Bootstrapping Database & Infrastructure

Use Docker Compose to launch a local MySQL 8 database service in the background:

```bash
docker compose up -d booksmart-db
```

Verify that the database is running:

```bash
docker compose ps
```

---

# 4. Running Migrations & Seeding Data

When you compile and launch the Spring Boot application for the first time, Flyway will run schema migrations automatically.

To manually verify, reset, or check migration status using Maven plugins:

```bash
mvn flyway:info -Dspring.profiles.active=dev
```

---

# 5. Building & Running the Application

### Compile and Package
Compile the codebase and generate the executable JAR file while skipping unit tests:

```bash
mvn clean package -DskipTests
```

### Running the Application
Launch the application with the `dev` Spring profile:

```bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

The application starts on `http://localhost:8080`. Swagger documentation is accessible at `http://localhost:8080/swagger-ui.html`.

---

# 6. Executing Tests

Execute the unit and integration test suite:

```bash
mvn clean test
```
