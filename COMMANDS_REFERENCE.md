# Commands Reference Guide

## Maven Commands

### Build Commands

```bash
# Clean build (remove previous build artifacts)
mvn clean

# Compile project
mvn compile

# Build project (compile + package)
mvn build

# Build with tests
mvn clean install

# Build without tests
mvn clean install -DskipTests

# Create JAR file
mvn clean package

# Create JAR without tests
mvn clean package -DskipTests
```

### Run Commands

```bash
# Run Spring Boot application
mvn spring-boot:run

# Run with specific profile
mvn spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=prod"

# Run with custom properties
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=9000"
```

### Test Commands

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=StudentRepositoryTest

# Run specific test method
mvn test -Dtest=StudentRepositoryTest#testFindByCourse

# Skip tests during build
mvn clean install -DskipTests

# Show test output
mvn test -X
```

### Dependency Commands

```bash
# View dependency tree
mvn dependency:tree

# Check for updates
mvn versions:display-dependency-updates

# Update dependencies
mvn versions:update-properties

# Display all dependencies
mvn dependency:resolve
```

### Code Quality

```bash
# Check code style (requires plugin)
mvn spotless:check

# Format code (requires plugin)
mvn spotless:apply

# Run static analysis (requires plugin)
mvn pmd:check
```

### Advanced

```bash
# Build in offline mode (no internet)
mvn clean install -o

# Build with debug output
mvn clean install -X

# Parallel build (faster)
mvn clean install -T 1C

# Skip all checks
mvn clean install -DskipTests -DskipChecks

# Force update of snapshots
mvn clean install -U
```

---

## Git Commands

### Setup

```bash
# Configure git (first time only)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Initialize git repository
git init

# Add remote repository
git remote add origin https://github.com/MacroMan17/PBLJ-Project-Student-Management-System-.git
```

### Basic Commands

```bash
# Check status
git status

# View changes
git diff

# Add specific files to staging
git add src/main/java/...
git add pom.xml

# Add all files
git add .

# Commit changes
git commit -m "Add Student REST API endpoints"

# View commit history
git log

# View specific commit
git show <commit-id>
```

### Branches

```bash
# Create new branch
git branch feature/new-feature

# Switch to branch
git checkout feature/new-feature

# Create and switch to branch
git checkout -b feature/new-feature

# List branches
git branch -a

# Delete branch
git branch -d feature/new-feature

# Rename branch
git branch -m old-name new-name
```

### Remote Operations

```bash
# Push to main branch
git push -u origin main

# Push to specific branch
git push origin feature/new-feature

# Pull latest changes
git pull origin main

# Fetch without merging
git fetch origin

# View remote branches
git branch -r
```

### Undo Changes

```bash
# Discard changes in working directory
git checkout -- src/main/java/...

# Unstage file
git reset HEAD src/main/java/...

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Revert commit (create new commit)
git revert <commit-id>
```

---

## Windows PowerShell Commands

### Directory Commands

```powershell
# List files
Get-ChildItem

# List with details
Get-ChildItem -Force

# Navigate directory
Set-Location "path\to\directory"

# Create directory
New-Item -ItemType Directory -Path "dirname"

# Remove file
Remove-Item filename.txt

# Remove directory (recursive)
Remove-Item -Path "dirname" -Recurse -Force

# Copy file
Copy-Item source.txt destination.txt

# Copy directory
Copy-Item -Path "source" -Destination "dest" -Recurse

# Current directory
Get-Location

# Go to home directory
Set-Location $HOME
```

### File Commands

```powershell
# View file content
Get-Content filename.txt

# Get file info
Get-Item filename.txt

# Search in files
Select-String -Path *.txt -Pattern "searchterm"

# View file size
Get-ChildItem | Select-Object Name, Length

# Get line count
(Get-Content filename.txt).Length
```

### System Commands

```powershell
# View environment variables
$env:PATH

# Set environment variable
$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"

# Check if port is in use
netstat -ano | findstr :8080

# Kill process by port
Get-Process | Where-Object {$_.Port -eq 8080} | Stop-Process

# CPU info
Get-ComputerInfo -Property WindowsProductName, OsVersion

# Memory info
Get-ComputerInfo | Select-Object CsPhyicallyInstalledSystemMemory
```

---

## MySQL Commands

### Database Commands

```sql
-- Create database
CREATE DATABASE student_db;

-- Use database
USE student_db;

-- Delete database
DROP DATABASE student_db;

-- View all databases
SHOW DATABASES;

-- View database size
SELECT table_schema, 
       ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS size_mb
FROM information_schema.tables
GROUP BY table_schema;
```

### Table Commands

```sql
-- View all tables
SHOW TABLES;

-- View table structure
DESCRIBE students;
SHOW CREATE TABLE students;

-- View table size
SELECT 
    table_name,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS size_mb
FROM information_schema.TABLES
WHERE table_schema = 'student_db';

-- Truncate table (delete all rows)
TRUNCATE TABLE students;

-- Delete specific rows
DELETE FROM students WHERE id > 10;

-- Add column
ALTER TABLE students ADD COLUMN created_at TIMESTAMP;

-- Drop column
ALTER TABLE students DROP COLUMN created_at;

-- Rename column
ALTER TABLE students CHANGE COLUMN old_name new_name VARCHAR(100);
```

### Data Commands

```sql
-- View all records
SELECT * FROM students;

-- View with conditions
SELECT * FROM students WHERE age > 20;

-- Count records
SELECT COUNT(*) FROM students;

-- Group by
SELECT course, COUNT(*) FROM students GROUP BY course;

-- Order by
SELECT * FROM students ORDER BY name ASC;

-- Limit results
SELECT * FROM students LIMIT 10;

-- Distinct values
SELECT DISTINCT course FROM students;

-- Update record
UPDATE students SET age = 21 WHERE id = 1;

-- Delete record
DELETE FROM students WHERE id = 1;

-- Insert multiple records
INSERT INTO students (name, email, course, age) VALUES
('John', 'john@example.com', 'CS', 20),
('Jane', 'jane@example.com', 'IT', 21);
```

### Backup and Restore

```bash
# Backup database
mysqldump -u root -p student_db > backup.sql

# Backup specific table
mysqldump -u root -p student_db students > backup_students.sql

# Backup all databases
mysqldump -u root -p --all-databases > all_backup.sql

# Restore from backup
mysql -u root -p student_db < backup.sql

# Restore all databases
mysql -u root -p < all_backup.sql
```

---

## cURL Commands for API Testing

### Add Student

```bash
curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d "{
    \"name\": \"John Doe\",
    \"email\": \"john.doe@example.com\",
    \"course\": \"Computer Science\",
    \"age\": 20
  }"
```

### Get All Students

```bash
curl http://localhost:8080/api/students
```

### Get Student by ID

```bash
curl http://localhost:8080/api/students/1
```

### Get Students by Course

```bash
curl "http://localhost:8080/api/students/course/Computer%20Science"
```

### Update Student

```bash
curl -X PUT http://localhost:8080/api/students/1 \
  -H "Content-Type: application/json" \
  -d "{
    \"name\": \"Jane Doe\",
    \"age\": 21,
    \"course\": \"Data Science\"
  }"
```

### Delete Student

```bash
curl -X DELETE http://localhost:8080/api/students/1
```

### With Response Headers

```bash
curl -i http://localhost:8080/api/students
```

### With Verbose Output

```bash
curl -v http://localhost:8080/api/students
```

### Pretty Print JSON Response

```bash
curl http://localhost:8080/api/students | python -m json.tool
```

---

## Docker Commands

### Build Image

```bash
# Build image
docker build -t student-mgmt-api:1.0.0 .

# Build with tag
docker build -t student-mgmt-api:latest .

# View build process
docker build -t student-mgmt-api:1.0.0 --progress=plain .
```

### Run Container

```bash
# Run container
docker run -d -p 8080:8080 student-mgmt-api:1.0.0

# Run with environment variables
docker run -d -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/student_db \
  -e SPRING_DATASOURCE_USERNAME=root \
  student-mgmt-api:1.0.0

# Run with volume mount
docker run -d -p 8080:8080 \
  -v /path/to/logs:/app/logs \
  student-mgmt-api:1.0.0
```

### Container Management

```bash
# List running containers
docker ps

# List all containers
docker ps -a

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>

# View logs
docker logs <container-id>

# Follow logs
docker logs -f <container-id>

# Execute command in container
docker exec -it <container-id> bash

# View container stats
docker stats <container-id>
```

### Image Management

```bash
# List images
docker images

# Remove image
docker rmi student-mgmt-api:1.0.0

# Tag image
docker tag student-mgmt-api:1.0.0 student-mgmt-api:latest

# Push to registry
docker push myregistry/student-mgmt-api:1.0.0

# Pull from registry
docker pull myregistry/student-mgmt-api:1.0.0
```

### Docker Compose

```bash
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild images
docker-compose build --no-cache

# Run specific service
docker-compose up mysql
```

---

## Java Commands

### Compilation

```bash
# Compile Java file
javac StudentManagementSystemApplication.java

# Compile with classpath
javac -cp ".;lib/*" src/Main.java

# Compile all Java files in directory
for /r %f in (*.java) do javac "%f"
```

### Execution

```bash
# Run JAR file
java -jar target/student-management-system-1.0.0.jar

# Run with JVM options
java -Xms512m -Xmx1024m -jar target/student-management-system-1.0.0.jar

# Run with properties
java -jar target/student-management-system-1.0.0.jar \
  --spring.datasource.url=jdbc:mysql://localhost:3306/student_db \
  --spring.datasource.username=root \
  --spring.datasource.password=root

# Run with profile
java -jar target/student-management-system-1.0.0.jar \
  --spring.profiles.active=prod
```

### Debugging

```bash
# Run with debug mode
java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
  -jar target/student-management-system-1.0.0.jar

# Run with GC logging
java -Xmx1024m -XX:+PrintGCDetails -XX:+PrintGCTimeStamps \
  -Xloggc:gc.log -jar target/student-management-system-1.0.0.jar
```

### Information

```bash
# Check Java version
java -version

# View system properties
java -XshowSettings:all -version

# List modules (Java 9+)
java --list-modules
```

---

## Useful Aliases (PowerShell)

Add to PowerShell profile (`$PROFILE`):

```powershell
# Maven aliases
Set-Alias -Name mvnc -Value "mvn clean"
Set-Alias -Name mvni -Value "mvn install"
Set-Alias -Name mvnb -Value "mvn spring-boot:run"
Set-Alias -Name mvnt -Value "mvn test"

# Git aliases
Set-Alias -Name gst -Value "git status"
Set-Alias -Name gco -Value "git checkout"
Set-Alias -Name gpl -Value "git pull"
Set-Alias -Name gps -Value "git push"

# Project navigation
function Go-Project { Set-Location "c:\Users\sumit\OneDrive\Desktop\Java Project" }
Set-Alias -Name cdp -Value Go-Project

# Quick commands
function Start-API { mvn spring-boot:run }
function Build-JAR { mvn clean package -DskipTests }
```

---

## Batch Scripts

### build.bat

```batch
@echo off
echo Building Student Management System...
mvn clean install -DskipTests
if %ERRORLEVEL% EQU 0 (
    echo Build successful!
    echo Starting application...
    mvn spring-boot:run
) else (
    echo Build failed!
    exit /b 1
)
```

### package.bat

```batch
@echo off
echo Packaging application...
mvn clean package -DskipTests
if %ERRORLEVEL% EQU 0 (
    echo Package created: target\student-management-system-1.0.0.jar
) else (
    echo Packaging failed!
    exit /b 1
)
```

### test.bat

```batch
@echo off
echo Running tests...
mvn test
if %ERRORLEVEL% EQU 0 (
    echo All tests passed!
) else (
    echo Tests failed!
    exit /b 1
)
```

---

## Command Chaining

### PowerShell

```powershell
# Run multiple commands
mvn clean install ; mvn spring-boot:run

# Conditional execution
mvn clean install && echo "Build success" || echo "Build failed"

# Pipeline
Get-ChildItem -Path src -Recurse -Include "*.java" | Measure-Object -Line
```

### Command Prompt

```batch
# Sequential execution
mvn clean && mvn install && mvn spring-boot:run

# Or operator
mvn clean || echo "Clean failed"
```

---

## Performance Commands

### View Running Processes

```powershell
# List Java processes
Get-Process | Where-Object {$_.ProcessName -like "*java*"}

# View process details
Get-Process java | Select-Object Name, Id, CPU, Memory
```

### Monitor Resources

```bash
# Maven parallel build
mvn clean install -T 1C

# Skip tests to save time
mvn clean install -DskipTests

# Skip all validation
mvn clean install -DskipTests -Dskip
```

---

## Command Summary Table

| Task | Command |
|------|---------|
| Build project | `mvn clean install` |
| Run application | `mvn spring-boot:run` |
| Run tests | `mvn test` |
| Create JAR | `mvn clean package -DskipTests` |
| Run JAR | `java -jar target/*.jar` |
| Check status | `git status` |
| Commit changes | `git add . && git commit -m "message"` |
| Push to GitHub | `git push origin main` |
| List databases | `SHOW DATABASES;` (MySQL) |
| View tables | `SHOW TABLES;` (MySQL) |

---

For more information, refer to:
- **README.md** - Project documentation
- **QUICK_START.md** - Quick setup guide
- **IDE_SETUP.md** - IDE configuration
