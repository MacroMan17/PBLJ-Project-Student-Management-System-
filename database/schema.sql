-- Create the database
CREATE DATABASE IF NOT EXISTS student_db;

-- Use the database
USE student_db;

-- Create the students table
CREATE TABLE IF NOT EXISTS students (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    course VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_email ON students(email);
CREATE INDEX idx_course ON students(course);

-- Insert sample data (optional)
INSERT INTO students (name, email, course, age) VALUES
('John Doe', 'john.doe@example.com', 'Computer Science', 20),
('Jane Smith', 'jane.smith@example.com', 'Computer Science', 21),
('Mike Johnson', 'mike.johnson@example.com', 'Information Technology', 19),
('Sarah Williams', 'sarah.williams@example.com', 'Information Technology', 22),
('Tom Brown', 'tom.brown@example.com', 'Business Administration', 20);
