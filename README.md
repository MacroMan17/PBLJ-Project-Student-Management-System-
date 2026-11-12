# Student Management System - REST API

A comprehensive REST API for managing student records built with Spring Boot, Spring Data JPA, and MySQL.

## Project Structure

```
student-management-system/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/studentmgmt/
│   │   │       ├── controller/
│   │   │       │   └── StudentController.java
│   │   │       ├── entity/
│   │   │       │   └── Student.java
│   │   │       ├── exception/
│   │   │       │   ├── StudentNotFoundException.java
│   │   │       │   └── GlobalExceptionHandler.java
│   │   │       ├── repository/
│   │   │       │   └── StudentRepository.java
│   │   │       ├── service/
│   │   │       │   └── StudentService.java
│   │   │       └── StudentManagementSystemApplication.java
│   │   └── resources/
│   │       └── application.yml
│   └── test/
├── database/
│   └── schema.sql
└── pom.xml
```

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- MySQL 8.0 or higher

## Setup Instructions

### 1. Database Setup

1. Open MySQL and run the following commands:

```sql
CREATE DATABASE student_db;
USE student_db;
```

2. Execute the schema file:
```sql
SOURCE database/schema.sql;
```

Or manually create the table:
```sql
CREATE TABLE students (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    course VARCHAR(100) NOT NULL,
    age INT NOT NULL
);
```

### 2. Configure Database Connection

Update `src/main/resources/application.yml` with your MySQL credentials:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/student_db
    username: your_mysql_username
    password: your_mysql_password
```

### 3. Build and Run the Application

```bash
# Build the project
mvn clean build

# Run the application
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

## API Endpoints

### 1. Add a New Student
**POST** `/api/students`

Request Body:
```json
{
    "name": "John Doe",
    "email": "john.doe@example.com",
    "course": "Computer Science",
    "age": 20
}
```

Response (201 Created):
```json
{
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "course": "Computer Science",
    "age": 20
}
```

### 2. Retrieve All Students
**GET** `/api/students`

Response (200 OK):
```json
[
    {
        "id": 1,
        "name": "John Doe",
        "email": "john.doe@example.com",
        "course": "Computer Science",
        "age": 20
    },
    {
        "id": 2,
        "name": "Jane Smith",
        "email": "jane.smith@example.com",
        "course": "Computer Science",
        "age": 21
    }
]
```

### 3. Retrieve Student by ID
**GET** `/api/students/{id}`

Response (200 OK):
```json
{
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "course": "Computer Science",
    "age": 20
}
```

Error Response (404 Not Found):
```json
{
    "timestamp": "2024-01-15T10:30:00",
    "status": 404,
    "error": "Student Not Found",
    "message": "Student with ID 999 not found"
}
```

### 4. Update Student Details
**PUT** `/api/students/{id}`

Request Body (all fields optional):
```json
{
    "name": "John Smith",
    "email": "john.smith@example.com",
    "course": "Information Technology",
    "age": 21
}
```

Response (200 OK):
```json
{
    "id": 1,
    "name": "John Smith",
    "email": "john.smith@example.com",
    "course": "Information Technology",
    "age": 21
}
```

### 5. Delete a Student
**DELETE** `/api/students/{id}`

Response (200 OK):
```json
"Student with ID 1 deleted successfully"
```

### 6. Retrieve Students by Course
**GET** `/api/students/course/{course}`

Example: `/api/students/course/Computer%20Science`

Response (200 OK):
```json
[
    {
        "id": 1,
        "name": "John Doe",
        "email": "john.doe@example.com",
        "course": "Computer Science",
        "age": 20
    },
    {
        "id": 2,
        "name": "Jane Smith",
        "email": "jane.smith@example.com",
        "course": "Computer Science",
        "age": 21
    }
]
```

## HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| 200 | OK - Request successful |
| 201 | Created - New resource created |
| 400 | Bad Request - Invalid input |
| 404 | Not Found - Resource not found |
| 500 | Internal Server Error |

## Exception Handling

The API implements global exception handling with appropriate HTTP status codes and error messages:

- **StudentNotFoundException**: Thrown when a student with given ID/course is not found (404)
- **IllegalArgumentException**: Thrown for invalid input like empty fields (400)
- **General Exception**: Any other errors return 500 with error details

## Technologies Used

- **Spring Boot 3.2.0**: Framework for building REST APIs
- **Spring Data JPA**: ORM and database abstraction layer
- **MySQL 8**: Relational database
- **Lombok**: Reduces boilerplate code
- **Maven**: Build and dependency management

## Testing with Postman

See the `postman-screenshots/` directory for example Postman test cases and screenshots demonstrating all endpoints.

### Postman Collection Setup

1. Import the collection from `postman/Student-Management-API.postman_collection.json`
2. Set the base URL variable: `{{base_url}} = http://localhost:8080`
3. Run requests from the collection

## Key Features

✅ Full CRUD operations for students
✅ Course-based filtering
✅ Proper exception handling with meaningful error messages
✅ Input validation
✅ RESTful API design
✅ CORS enabled for cross-origin requests
✅ Database persistence with MySQL
✅ Automatic database schema creation (DDL-auto: update)

## Troubleshooting

**Issue**: Connection refused error
- Ensure MySQL is running
- Verify database name, username, and password in application.yml
- Check if the student_db database exists

**Issue**: Table not found error
- Run the schema.sql file to create the table
- Or set `spring.jpa.hibernate.ddl-auto: create-drop` temporarily to auto-create on startup

**Issue**: Duplicate email error
- Email is unique, ensure you're using different email addresses for new students

## GitHub Repository

[GitHub Repository Link](https://github.com/MacroMan17/PBLJ-Project-Student-Management-System-)

## Author

Student Management System - REST API Project
