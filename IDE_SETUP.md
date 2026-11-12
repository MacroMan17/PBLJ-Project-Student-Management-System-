# IDE Setup Guide

## IntelliJ IDEA Setup

### 1. Open Project

1. Launch IntelliJ IDEA
2. Click **File → Open**
3. Navigate to: `c:\Users\sumit\OneDrive\Desktop\Java Project`
4. Click **OK**

IntelliJ will automatically detect it as a Maven project.

### 2. Configure JDK

1. Go to **File → Project Structure → Project**
2. Set **SDK**: Select JDK 17 (or download if needed)
3. Set **Language level**: 17 or higher
4. Click **OK**

### 3. Index and Build

1. Wait for project indexing to complete
2. Go to **View → Tool Windows → Maven**
3. Right-click on project → **Reimport**
4. Once complete, build project: **Build → Build Project** (Ctrl+F9)

### 4. Configure Run Configuration

1. Click **Run → Edit Configurations**
2. Click **+** to add new configuration
3. Select **Maven**
4. Name: `Student API`
5. Command line: `spring-boot:run`
6. Click **OK**

### 5. Run Application

1. Click **Run → Run 'Student API'** (or press Shift+F10)
2. Wait for: `Started StudentManagementSystemApplication`
3. Access: http://localhost:8080

---

## Eclipse Setup

### 1. Import Project

1. Launch Eclipse
2. Click **File → Import**
3. Select **Maven → Existing Maven Projects**
4. Click **Next**
5. Browse to: `c:\Users\sumit\OneDrive\Desktop\Java Project`
6. Select **pom.xml**
7. Click **Finish**

### 2. Configure JDK

1. Right-click project → **Properties**
2. Go to **Java Build Path**
3. Set **Execution Environment**: JavaSE-17
4. Click **Apply and Close**

### 3. Update Project

1. Right-click project → **Maven → Update Project**
2. Check **Force Update of Snapshots/Releases**
3. Click **OK**

### 4. Run Application

1. Right-click project → **Run As → Maven build**
2. Goals: `spring-boot:run`
3. Click **Run**

---

## Visual Studio Code Setup

### 1. Install Extensions

1. Open VS Code
2. Go to **Extensions** (Ctrl+Shift+X)
3. Install these extensions:
   - **Extension Pack for Java** (by Microsoft)
   - **Maven for Java** (by Microsoft)
   - **Spring Boot Extension Pack** (by Pivotal)
   - **REST Client** (by Huachao Mao)

### 2. Open Project

1. Click **File → Open Folder**
2. Select: `c:\Users\sumit\OneDrive\Desktop\Java Project`
3. Click **Select Folder**

### 3. Configure JDK

1. Press **Ctrl+Shift+P**
2. Type: **Java: Configure JDK**
3. Select or download **JDK 17+**
4. Restart VS Code

### 4. Run Application

Option 1 - Maven:
1. Open integrated terminal: **Ctrl+`**
2. Run: `mvn spring-boot:run`

Option 2 - Spring Boot Dashboard:
1. In Explorer, find **Spring Boot Dashboard**
2. Click **Start** on project
3. View logs in output panel

### 5. Create REST Client file

Create `requests.rest` in project root:

```http
### Variables
@base_url = http://localhost:8080

### Get all students
GET {{base_url}}/api/students

### Get student by ID
GET {{base_url}}/api/students/1

### Add student
POST {{base_url}}/api/students
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "course": "Computer Science",
  "age": 20
}

### Update student
PUT {{base_url}}/api/students/1
Content-Type: application/json

{
  "age": 21,
  "course": "Data Science"
}

### Delete student
DELETE {{base_url}}/api/students/1

### Get students by course
GET {{base_url}}/api/students/course/Computer%20Science
```

Click **Send Request** above each endpoint to test.

---

## NetBeans Setup

### 1. Open Project

1. Launch NetBeans
2. Click **File → Open Project**
3. Navigate to: `c:\Users\sumit\OneDrive\Desktop\Java Project`
4. Click **Open Project**

### 2. Configure JDK

1. Right-click project → **Properties**
2. Go to **Sources**
3. Set **Source Level**: 17
4. Click **OK**

### 3. Run Application

1. Right-click project → **Run Maven → Goals**
2. Type: `spring-boot:run`
3. Click **Run**

---

## Command Line Setup

### Using Maven Directly

```bash
# Navigate to project
cd "c:\Users\sumit\OneDrive\Desktop\Java Project"

# Build
mvn clean install

# Run
mvn spring-boot:run

# In another terminal, test
curl http://localhost:8080/api/students
```

### Using Maven Wrapper (Optional)

Create `mvnw` and `mvnw.bat` files for consistent Maven version:

```bash
# Initialize wrapper
mvn -N io.takari:maven:wrapper

# Use wrapper
.\mvnw spring-boot:run
```

---

## Configuration Files to Know

### application.yml
**Location:** `src/main/resources/application.yml`

Main configuration file - update database credentials here:
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/student_db
    username: root
    password: root
```

### pom.xml
**Location:** `pom.xml`

Maven configuration - lists all dependencies.

### .gitignore
**Location:** `.gitignore`

Specifies files to exclude from Git.

---

## Debugging

### IntelliJ IDEA
```
1. Set breakpoint (click line number)
2. Right-click project → Debug
3. Use Debug panel to step through code
4. Press Ctrl+Shift+F9 to continue
```

### Eclipse
```
1. Set breakpoint (double-click line number)
2. Right-click project → Debug As → Maven build
3. Goals: spring-boot:run
4. Use Debug panel
```

### VS Code
```
1. Click line number to set breakpoint
2. Press F5 or click Run → Start Debugging
3. Select Java environment
4. Use Debug Console to inspect variables
```

---

## Common IDE Tasks

### Reformat Code
**IntelliJ:** Ctrl+Alt+L  
**Eclipse:** Ctrl+Shift+F  
**VS Code:** Shift+Alt+F

### Organize Imports
**IntelliJ:** Ctrl+Alt+O  
**Eclipse:** Ctrl+Shift+O  
**VS Code:** Shift+Alt+O

### Find in Files
**All IDEs:** Ctrl+H or Ctrl+Shift+F

### Terminal
**IntelliJ/Eclipse/VS Code:** Ctrl+` (backtick)

---

## Package Explorer Structure (IntelliJ)

```
StudentManagementSystem
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com.studentmgmt
│   │   │       ├── controller
│   │   │       ├── entity
│   │   │       ├── exception
│   │   │       ├── repository
│   │   │       ├── service
│   │   │       └── StudentManagementSystemApplication.java
│   │   └── resources
│   │       └── application.yml
│   └── test
├── target (generated)
├── pom.xml
└── README.md
```

---

## Troubleshooting IDE Issues

### IntelliJ Won't Recognize Spring Boot
1. Go to **File → Invalidate Caches**
2. Restart IntelliJ
3. Right-click project → **Run → Edit Configurations**
4. Add Spring Boot configuration

### Eclipse Won't Find Dependencies
1. Right-click project → **Maven → Update Project**
2. Check **Force Update of Snapshots/Releases**
3. Right-click project → **Maven → Reimport**

### VS Code Can't Find JDK
1. Press **Ctrl+Shift+P**
2. Type **Java: Configure Runtime**
3. Download or select JDK 17+

### Dependencies Not Loading
```bash
# Clear Maven cache
mvn clean
mvn install -DskipTests

# If still failing
rm -r ~/.m2/repository
mvn clean install
```

---

## Performance Tips

1. **Disable unnecessary plugins** in IDE
2. **Increase IDE memory:**
   - IntelliJ: Edit `idea.vmoptions`
   - Eclipse: Edit `eclipse.ini` (add `-Xmx2048m`)
   - VS Code: Already optimized

3. **Use Maven daemon** for faster builds:
   ```bash
   mvn install -DskipTests -T 1C
   ```

4. **Enable parallel builds** in IDE settings

---

## Version Control in IDE

### IntelliJ
- View → Tool Windows → Git
- Use built-in Git integration
- Commit, push, and manage branches

### Eclipse
- Window → Show View → Git Staging
- Stage files and commit directly

### VS Code
- Click Git icon (Ctrl+Shift+G)
- Stage files and commit
- Use Source Control panel

---

## Useful IDE Shortcuts

| Action | IntelliJ | Eclipse | VS Code |
|--------|----------|---------|---------|
| Run | Shift+F10 | Ctrl+F11 | F5 |
| Debug | Shift+F9 | F11 | F5 |
| Format | Ctrl+Alt+L | Ctrl+Shift+F | Shift+Alt+F |
| Find | Ctrl+F | Ctrl+F | Ctrl+F |
| Replace | Ctrl+H | Ctrl+H | Ctrl+H |
| Go to Line | Ctrl+G | Ctrl+G | Ctrl+G |
| Auto-complete | Ctrl+Space | Ctrl+Space | Ctrl+Space |
| Refactor | Ctrl+Alt+Shift+T | Alt+Shift+R | Ctrl+Shift+R |

---

## Next Steps

1. Choose your preferred IDE
2. Follow setup instructions above
3. Open the project
4. Run `mvn clean install`
5. Start the application
6. Test endpoints with Postman or REST Client

**Happy Coding! 🚀**

---

For more help, see:
- **QUICK_START.md** - 5-minute setup
- **README.md** - Full documentation
- **TESTING_GUIDE.md** - Testing procedures
