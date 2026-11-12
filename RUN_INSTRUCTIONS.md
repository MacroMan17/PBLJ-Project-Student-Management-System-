# How to Run the Student Management System

## Prerequisites Status

✅ Java 17 installed  
❌ Maven not installed (network restrictions)  
❌ MySQL not running  

---

## Step 1: Install Maven (if not already installed)

### Option A: Using Chocolatey (Recommended for Windows)
```powershell
choco install maven
```

### Option B: Manual Installation
1. Download from: https://maven.apache.org/download.cgi
2. Extract to: `C:\tools\maven`
3. Add to PATH: `C:\tools\maven\bin`
4. Verify: `mvn -version`

### Option C: Using SDKMAN (Windows subsystem)
```bash
sdk install maven
```

---

## Step 2: Setup MySQL Database

### Option A: Using MySQL Command Line
```bash
# Start MySQL service
net start MySQL80

# Or open MySQL Command Line Client and run:
CREATE DATABASE student_db;
USE student_db;
```

### Option B: Run the Schema Script
```bash
# Execute the SQL file
mysql -u root -p < database/schema.sql
```

**Update credentials in** `src/main/resources/application.yml`:
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/student_db
    username: root        # Your MySQL username
    password: root        # Your MySQL password
```

---

## Step 3: Build the Project

```bash
# Navigate to project directory
cd "c:\Users\sumit\OneDrive\Desktop\Java Project"

# Build with Maven
mvn clean install

# Or build without tests (faster)
mvn clean install -DskipTests
```

---

## Step 4: Run the Application

### Option A: Using Maven
```bash
mvn spring-boot:run
```

### Option B: Using Java (Run JAR)
```bash
# First build JAR
mvn clean package -DskipTests

# Then run
java -jar target/student-management-system-1.0.0.jar
```

### Option C: From IDE
- **IntelliJ:** Right-click `StudentManagementSystemApplication.java` → Run
- **Eclipse:** Right-click project → Run As → Spring Boot App
- **VS Code:** Use Spring Boot Extension Pack

---

## Step 5: Verify Application is Running

Open in browser or use curl:
```bash
curl http://localhost:8080/api/students
```

Expected response: `[]` (empty array) or list of students

---

## Quick Start Script

Create `run.bat` file:
```batch
@echo off
echo Starting Student Management System...
echo.

echo Step 1: Building project...
mvn clean install -DskipTests

if %ERRORLEVEL% NEQ 0 (
    echo Build failed!
    exit /b 1
)

echo.
echo Step 2: Starting application...
mvn spring-boot:run

pause
```

Then run:
```bash
.\run.bat
```

---

## Testing the API

Once application is running on `http://localhost:8080`:

### Add Student
```bash
curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com","course":"CS","age":20}'
```

### Get All Students
```bash
curl http://localhost:8080/api/students
```

### Get Student by ID
```bash
curl http://localhost:8080/api/students/1
```

### Update Student
```bash
curl -X PUT http://localhost:8080/api/students/1 \
  -H "Content-Type: application/json" \
  -d '{"age":21}'
```

### Delete Student
```bash
curl -X DELETE http://localhost:8080/api/students/1
```

### Get by Course
```bash
curl "http://localhost:8080/api/students/course/Computer%20Science"
```

---

## Using Postman

1. Import: `postman/Student-Management-API.postman_collection.json`
2. Set variable `base_url` = `http://localhost:8080`
3. Test all endpoints

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `mvn not found` | Install Maven (see Step 1) |
| `MySQL connection error` | Start MySQL service and create database |
| `Port 8080 in use` | Change port in `application.yml`: `server.port: 8081` |
| `Build fails` | Ensure Java 17+ installed: `java -version` |
| `Cannot find database` | Execute: `CREATE DATABASE student_db;` |

---

## Environment Setup

### Windows PowerShell Setup
```powershell
# Add Maven to PATH permanently (requires admin)
$mavenPath = "C:\tools\maven\bin"
[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$mavenPath", "Machine")

# Verify
mvn -version
```

### Check Java
```bash
java -version
javac -version
```

### Check Maven
```bash
mvn -version
mvn help:describe -Dplugin=org.springframework.boot:spring-boot-maven-plugin
```

---

## Running in Different Environments

### Development (H2 Database)
```bash
mvn spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=h2"
```

### Production
```bash
mvn clean package -DskipTests
java -Xmx1024m -jar target/student-management-system-1.0.0.jar
```

### Docker
```bash
mvn clean package -DskipTests
docker build -t student-api .
docker run -d -p 8080:8080 student-api
```

---

## Expected Output When Running

```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_|\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v3.2.0)

2026-11-12 10:30:00.000  INFO 12345 --- [  main] c.s.StudentManagementSystemApplication  : Starting...
...
2026-11-12 10:30:05.000  INFO 12345 --- [  main] c.s.StudentManagementSystemApplication  : Started in 5.123 seconds
2026-11-12 10:30:05.000  INFO 12345 --- [  main] o.springframework.boot.web.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http)
```

---

## API is Ready!

Once you see `Tomcat started on port(s): 8080`, the API is ready:

**Base URL:** `http://localhost:8080`

**Available Endpoints:**
- POST   `/api/students` - Add student
- GET    `/api/students` - Get all
- GET    `/api/students/{id}` - Get by ID
- PUT    `/api/students/{id}` - Update
- DELETE `/api/students/{id}` - Delete
- GET    `/api/students/course/{course}` - Filter by course

---

## Keep Application Running

The application will run until you:
- Press `Ctrl+C` in the terminal
- Close the terminal window
- Stop the Maven/Java process

---

For more details, see:
- `README.md` - Full documentation
- `QUICK_START.md` - 5-minute setup
- `TESTING_GUIDE.md` - Testing procedures
