# Quick Start Guide

## 5-Minute Setup

### Step 1: Prerequisites Check
```bash
# Check Java version (should be 17+)
java -version

# Check Maven version (should be 3.6+)
mvn -version
```

### Step 2: Set Up Database

**Option 1: Using MySQL Command Line**
```bash
# Connect to MySQL
mysql -u root -p

# Execute commands
CREATE DATABASE student_db;
USE student_db;
```

**Option 2: Execute SQL Script**
```bash
# Copy and paste the contents of database/schema.sql in MySQL
```

### Step 3: Update Configuration

Edit `src/main/resources/application.yml`:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/student_db
    username: root
    password: root
```

### Step 4: Build and Run

```bash
# Navigate to project directory
cd "c:\Users\sumit\OneDrive\Desktop\Java Project"

# Build project
mvn clean install

# Run application
mvn spring-boot:run
```

**Success!** Application runs on `http://localhost:8080`

---

## Testing the API

### Option 1: Using Postman
1. Import collection: `postman/Student-Management-API.postman_collection.json`
2. Set `base_url` environment variable to `http://localhost:8080`
3. Run requests from the collection

### Option 2: Using cURL

**Add a Student:**
```bash
curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"John Doe\",\"email\":\"john.doe@example.com\",\"course\":\"Computer Science\",\"age\":20}"
```

**Get All Students:**
```bash
curl http://localhost:8080/api/students
```

**Get Student by ID:**
```bash
curl http://localhost:8080/api/students/1
```

**Update Student:**
```bash
curl -X PUT http://localhost:8080/api/students/1 \
  -H "Content-Type: application/json" \
  -d "{\"age\":21,\"course\":\"Data Science\"}"
```

**Delete Student:**
```bash
curl -X DELETE http://localhost:8080/api/students/1
```

**Get Students by Course:**
```bash
curl "http://localhost:8080/api/students/course/Computer%20Science"
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `Connection refused` | Check MySQL is running: `services.msc` on Windows |
| `Database does not exist` | Create database: `CREATE DATABASE student_db;` |
| `Cannot find symbol` | Ensure Java 17+ is installed |
| `Port 8080 in use` | Change port in `application.yml`: `server.port: 8081` |
| `No qualifying bean` | Ensure all classes are in correct package: `com.studentmgmt.*` |

---

## Project Structure

```
c:\Users\sumit\OneDrive\Desktop\Java Project\
├── src/main/java/com/studentmgmt/
│   ├── controller/StudentController.java      # REST endpoints
│   ├── entity/Student.java                    # JPA entity
│   ├── repository/StudentRepository.java      # Database access
│   ├── service/StudentService.java            # Business logic
│   ├── exception/                             # Exception handling
│   └── StudentManagementSystemApplication.java # Main class
├── src/main/resources/
│   └── application.yml                        # Database config
├── database/schema.sql                        # Database setup
├── postman/                                   # API testing
├── pom.xml                                    # Maven config
└── README.md                                  # Full documentation
```

---

## Next Steps

1. ✅ Setup database
2. ✅ Configure application.yml
3. ✅ Run `mvn clean install`
4. ✅ Start application with `mvn spring-boot:run`
5. ✅ Test endpoints with Postman or cURL
6. ✅ Read full documentation in README.md
7. ✅ Push to GitHub repository

---

## Useful Commands

```bash
# Build without running tests
mvn clean install -DskipTests

# Run with specific profile
mvn spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"

# View dependencies
mvn dependency:tree

# Clean build artifacts
mvn clean

# Check for dependency updates
mvn versions:display-dependency-updates

# Format code
mvn spotless:apply
```

---

For detailed documentation, see README.md and TESTING_GUIDE.md
