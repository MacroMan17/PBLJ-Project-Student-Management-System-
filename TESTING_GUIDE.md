# Testing Guide - Student Management System

This guide provides comprehensive instructions for testing all API endpoints using Postman.

## Prerequisites

- Student Management System application is running on `http://localhost:8080`
- MySQL database is set up and running
- Postman is installed

## Postman Setup

### 1. Import the Collection

1. Open Postman
2. Click on **Import** button
3. Select the file: `postman/Student-Management-API.postman_collection.json`
4. The collection will be imported with all endpoints

### 2. Configure Environment Variables

1. In Postman, go to **Environments**
2. Create a new environment named "Student API Dev"
3. Add the following variable:
   - Key: `base_url`
   - Value: `http://localhost:8080`
4. Select this environment when running requests

## Test Cases

### Test 1: Add a New Student (POST)

**Endpoint:** `POST /api/students`

**Request Body:**
```json
{
    "name": "John Doe",
    "email": "john.doe@example.com",
    "course": "Computer Science",
    "age": 20
}
```

**Expected Response (201 Created):**
```json
{
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "course": "Computer Science",
    "age": 20
}
```

**Validation:**
- ✓ Status code is 201
- ✓ Response contains student ID
- ✓ All fields match the request

**Test Multiple Students:** Add these students for testing:

Student 1:
```json
{
    "name": "Jane Smith",
    "email": "jane.smith@example.com",
    "course": "Computer Science",
    "age": 21
}
```

Student 2:
```json
{
    "name": "Mike Johnson",
    "email": "mike.johnson@example.com",
    "course": "Information Technology",
    "age": 19
}
```

Student 3:
```json
{
    "name": "Sarah Williams",
    "email": "sarah.williams@example.com",
    "course": "Information Technology",
    "age": 22
}
```

---

### Test 2: Get All Students (GET)

**Endpoint:** `GET /api/students`

**Request Body:** None

**Expected Response (200 OK):**
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
    },
    ...
]
```

**Validation:**
- ✓ Status code is 200
- ✓ Response is an array
- ✓ Array contains all added students
- ✓ Each student object has all required fields

---

### Test 3: Get Student by ID (GET)

**Endpoint:** `GET /api/students/{id}`

**Example:** `GET /api/students/1`

**Expected Response (200 OK):**
```json
{
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "course": "Computer Science",
    "age": 20
}
```

**Validation:**
- ✓ Status code is 200
- ✓ Response contains correct student data
- ✓ ID matches requested ID

**Test Invalid ID (404 Not Found):**

**Endpoint:** `GET /api/students/999`

**Expected Response (404 Not Found):**
```json
{
    "timestamp": "2024-01-15T10:30:00",
    "status": 404,
    "error": "Student Not Found",
    "message": "Student with ID 999 not found"
}
```

**Validation:**
- ✓ Status code is 404
- ✓ Error message is descriptive

---

### Test 4: Update Student (PUT)

**Endpoint:** `PUT /api/students/{id}`

**Example:** `PUT /api/students/1`

**Request Body (Partial Update):**
```json
{
    "age": 21,
    "course": "Data Science"
}
```

**Expected Response (200 OK):**
```json
{
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "course": "Data Science",
    "age": 21
}
```

**Validation:**
- ✓ Status code is 200
- ✓ Updated fields are changed
- ✓ Unchanged fields remain the same
- ✓ ID is preserved

**Test Full Update:**

**Request Body:**
```json
{
    "name": "John Smith",
    "email": "john.smith@example.com",
    "course": "Machine Learning",
    "age": 22
}
```

**Validation:**
- ✓ All fields are updated
- ✓ Response reflects all changes

**Test Update Non-Existent Student (404):**

**Endpoint:** `PUT /api/students/999`

**Expected Response (404 Not Found)**

---

### Test 5: Delete Student (DELETE)

**Endpoint:** `DELETE /api/students/{id}`

**Example:** `DELETE /api/students/3`

**Expected Response (200 OK):**
```json
"Student with ID 3 deleted successfully"
```

**Validation:**
- ✓ Status code is 200
- ✓ Success message is returned
- ✓ Student is removed from database

**Verify Deletion:**
- Run `GET /api/students/{id}` with deleted ID
- Should return 404 Not Found

**Test Delete Non-Existent Student (404):**

**Endpoint:** `DELETE /api/students/999`

**Expected Response (404 Not Found)**

---

### Test 6: Get Students by Course (GET)

**Endpoint:** `GET /api/students/course/{course}`

**Example:** `GET /api/students/course/Computer%20Science`

**Expected Response (200 OK):**
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

**Validation:**
- ✓ Status code is 200
- ✓ Response contains only students from specified course
- ✓ All students have matching course name

**Test Different Courses:**

1. **Information Technology:** `GET /api/students/course/Information%20Technology`
2. **Data Science:** `GET /api/students/course/Data%20Science`

**Test Non-Existent Course (404):**

**Endpoint:** `GET /api/students/course/NonExistent`

**Expected Response (404 Not Found)**

---

## Postman Test Script Examples

Add these to the **Tests** tab in Postman for automated validation:

### For POST /api/students
```javascript
pm.test("Status code is 201", function() {
    pm.response.to.have.status(201);
});

pm.test("Response contains student ID", function() {
    var jsonData = pm.response.json();
    pm.expect(jsonData.id).to.exist;
});

pm.test("Response contains all fields", function() {
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property("name");
    pm.expect(jsonData).to.have.property("email");
    pm.expect(jsonData).to.have.property("course");
    pm.expect(jsonData).to.have.property("age");
});
```

### For GET /api/students
```javascript
pm.test("Status code is 200", function() {
    pm.response.to.have.status(200);
});

pm.test("Response is an array", function() {
    var jsonData = pm.response.json();
    pm.expect(Array.isArray(jsonData)).to.be.true;
});

pm.test("Each student has required fields", function() {
    var jsonData = pm.response.json();
    jsonData.forEach(function(student) {
        pm.expect(student).to.have.property("id");
        pm.expect(student).to.have.property("name");
        pm.expect(student).to.have.property("email");
        pm.expect(student).to.have.property("course");
        pm.expect(student).to.have.property("age");
    });
});
```

### For DELETE /api/students/{id}
```javascript
pm.test("Status code is 200", function() {
    pm.response.to.have.status(200);
});

pm.test("Response contains success message", function() {
    var jsonData = pm.response.text();
    pm.expect(jsonData).to.include("deleted successfully");
});
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Connection refused | Ensure Spring Boot application is running on port 8080 |
| 404 errors on valid IDs | Verify student ID exists in database |
| Duplicate email error | Use unique email addresses for each student |
| Database connection error | Check MySQL is running and credentials are correct |
| CORS error | Application has CORS enabled, should not occur |

---

## Test Execution Checklist

- [ ] Test 1: Add new students (multiple)
- [ ] Test 2: Retrieve all students
- [ ] Test 3: Get student by ID (valid and invalid)
- [ ] Test 4: Update student (full and partial)
- [ ] Test 5: Delete student and verify
- [ ] Test 6: Get students by course
- [ ] Verify proper HTTP status codes
- [ ] Verify error messages are descriptive
- [ ] Test edge cases (empty fields, invalid data types)

---

## Performance Testing

For basic load testing, use Postman's Collection Runner:

1. Select the collection
2. Click **Run** to open Collection Runner
3. Set number of iterations
4. Set delay between requests
5. Click **Run Student Management System API**

Monitor response times and ensure all tests pass under load.

---

## Notes

- All endpoints are accessible from the base URL: `http://localhost:8080`
- Valid HTTP status codes are returned for all scenarios
- Exception handling ensures meaningful error messages
- Database changes are persisted to MySQL
