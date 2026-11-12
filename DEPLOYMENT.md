# Deployment Guide

## Building for Production

### 1. Clean Build

```bash
mvn clean install -DskipTests
```

This creates a JAR file at: `target/student-management-system-1.0.0.jar`

### 2. Run the JAR

```bash
java -jar target/student-management-system-1.0.0.jar
```

### 3. Configure for Production

Create `src/main/resources/application-prod.yml`:

```yaml
spring:
  application:
    name: Student Management System

  datasource:
    url: jdbc:mysql://production-db-host:3306/student_db
    username: prod_user
    password: secure_password
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5

  jpa:
    hibernate:
      ddl-auto: validate
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MySQLDialect
        format_sql: false
    show-sql: false

server:
  port: 8080
  servlet:
    context-path: /
  compression:
    enabled: true
    min-response-size: 1024

logging:
  level:
    root: INFO
    com.studentmgmt: INFO
  file:
    name: logs/application.log
    max-size: 10MB
    max-history: 10

management:
  endpoints:
    web:
      exposure:
        include: health,metrics
  endpoint:
    health:
      show-details: when-authorized
```

### 4. Run with Production Profile

```bash
java -jar target/student-management-system-1.0.0.jar \
  --spring.profiles.active=prod \
  --spring.datasource.url=jdbc:mysql://production-host:3306/student_db \
  --spring.datasource.username=prod_user \
  --spring.datasource.password=secure_password
```

---

## Docker Deployment

### 1. Create Dockerfile

```dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/student-management-system-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### 2. Build Docker Image

```bash
mvn clean package -DskipTests
docker build -t student-mgmt-api:1.0.0 .
```

### 3. Run Docker Container

```bash
docker run -d \
  --name student-api \
  -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql-container:3306/student_db \
  -e SPRING_DATASOURCE_USERNAME=root \
  -e SPRING_DATASOURCE_PASSWORD=password \
  student-mgmt-api:1.0.0
```

### 4. Docker Compose Setup

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    container_name: student-db
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: student_db
    ports:
      - "3306:3306"
    volumes:
      - ./database/schema.sql:/docker-entrypoint-initdb.d/schema.sql
      - mysql-data:/var/lib/mysql

  api:
    build: .
    container_name: student-api
    ports:
      - "8080:8080"
    environment:
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/student_db
      SPRING_DATASOURCE_USERNAME: root
      SPRING_DATASOURCE_PASSWORD: root
      SPRING_JPA_HIBERNATE_DDL_AUTO: update
    depends_on:
      - mysql

volumes:
  mysql-data:
```

Run with: `docker-compose up -d`

---

## Cloud Deployment

### AWS EC2

1. Build JAR on local machine
2. Upload to EC2 instance
3. Install Java 17
4. Configure MySQL on RDS
5. Run JAR with environment variables

```bash
java -jar student-management-system-1.0.0.jar \
  --spring.datasource.url=jdbc:mysql://rds-endpoint:3306/student_db \
  --spring.datasource.username=admin \
  --spring.datasource.password=$DB_PASSWORD
```

### Heroku

```bash
# Create Procfile
echo "web: java -Dserver.port=\$PORT \$JAVA_OPTS -jar target/student-management-system-1.0.0.jar" > Procfile

# Deploy
heroku login
heroku create student-management-api
git push heroku main
```

### Azure App Service

```bash
# Create resource group
az group create --name myResourceGroup --location eastus

# Create App Service plan
az appservice plan create --name myAppServicePlan --resource-group myResourceGroup --sku B1 --is-linux

# Create web app
az webapp create --resource-group myResourceGroup \
  --plan myAppServicePlan \
  --name student-mgmt-api \
  --runtime "JAVA|17"

# Deploy JAR
az webapp deployment source config-zip -r group myResourceGroup -n student-mgmt-api -s student-management-system-1.0.0.jar
```

---

## Performance Tuning

### Database Connection Pool

Update `application.yml`:

```yaml
spring:
  datasource:
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
      connection-timeout: 20000
      idle-timeout: 300000
      max-lifetime: 1200000
```

### JPA/Hibernate Configuration

```yaml
spring:
  jpa:
    properties:
      hibernate:
        jdbc:
          batch_size: 20
          fetch_size: 50
        order_inserts: true
        order_updates: true
```

### JVM Tuning

```bash
java -Xms512m -Xmx1024m \
  -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=200 \
  -jar student-management-system-1.0.0.jar
```

---

## Monitoring

### Health Check Endpoint

Enable in `application.yml`:

```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,metrics,info
  endpoint:
    health:
      show-details: always
```

Access: `http://localhost:8080/actuator/health`

### Logging

```yaml
logging:
  level:
    com.studentmgmt: DEBUG
  file:
    name: logs/application.log
```

---

## Backup and Recovery

### Database Backup

```bash
# Backup
mysqldump -u root -p student_db > backup_student_db.sql

# Restore
mysql -u root -p student_db < backup_student_db.sql
```

### Application Backup

```bash
# Backup configuration
cp -r src/main/resources backup_config_$(date +%Y%m%d)

# Backup database
mysqldump -u root -p student_db > backup_db_$(date +%Y%m%d).sql
```

---

## CI/CD Pipeline (GitHub Actions)

Create `.github/workflows/deploy.yml`:

```yaml
name: Build and Deploy

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up JDK 17
      uses: actions/setup-java@v2
      with:
        java-version: '17'
    
    - name: Build with Maven
      run: mvn clean package -DskipTests
    
    - name: Run tests
      run: mvn test
    
    - name: Upload to artifacts
      uses: actions/upload-artifact@v2
      with:
        name: student-mgmt-jar
        path: target/*.jar
```

---

## Security Checklist

- [ ] Change default database password
- [ ] Enable HTTPS/SSL
- [ ] Configure firewall rules
- [ ] Implement API rate limiting
- [ ] Enable CORS appropriately
- [ ] Use environment variables for secrets
- [ ] Regular database backups
- [ ] Monitor error logs
- [ ] Update dependencies regularly
- [ ] Implement request validation

---

## Troubleshooting Deployment

| Issue | Solution |
|-------|----------|
| Port already in use | Change `server.port` in application.yml |
| Database connection timeout | Check network connectivity and database service |
| Out of memory | Increase JVM heap: `java -Xmx2048m` |
| Slow startup | Check database connection and schema initialization |
| High CPU usage | Review query performance and implement caching |

---

For questions or issues, refer to README.md and TESTING_GUIDE.md
