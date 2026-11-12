package com.studentmgmt.service;

import com.studentmgmt.entity.Student;
import com.studentmgmt.exception.StudentNotFoundException;
import com.studentmgmt.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    /**
     * Add a new student
     */
    public Student addStudent(Student student) {
        if (student.getName() == null || student.getName().isEmpty()) {
            throw new IllegalArgumentException("Student name cannot be empty");
        }
        if (student.getEmail() == null || student.getEmail().isEmpty()) {
            throw new IllegalArgumentException("Student email cannot be empty");
        }
        if (student.getCourse() == null || student.getCourse().isEmpty()) {
            throw new IllegalArgumentException("Student course cannot be empty");
        }
        if (student.getAge() == null || student.getAge() <= 0) {
            throw new IllegalArgumentException("Student age must be greater than 0");
        }

        return studentRepository.save(student);
    }

    /**
     * Retrieve all students
     */
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    /**
     * Retrieve student by ID
     */
    public Student getStudentById(Long id) {
        return studentRepository.findById(id)
                .orElseThrow(() -> new StudentNotFoundException("Student with ID " + id + " not found"));
    }

    /**
     * Update student details
     */
    public Student updateStudent(Long id, Student studentDetails) {
        Student student = getStudentById(id);

        if (studentDetails.getName() != null && !studentDetails.getName().isEmpty()) {
            student.setName(studentDetails.getName());
        }
        if (studentDetails.getEmail() != null && !studentDetails.getEmail().isEmpty()) {
            student.setEmail(studentDetails.getEmail());
        }
        if (studentDetails.getCourse() != null && !studentDetails.getCourse().isEmpty()) {
            student.setCourse(studentDetails.getCourse());
        }
        if (studentDetails.getAge() != null && studentDetails.getAge() > 0) {
            student.setAge(studentDetails.getAge());
        }

        return studentRepository.save(student);
    }

    /**
     * Delete a student
     */
    public void deleteStudent(Long id) {
        Student student = getStudentById(id);
        studentRepository.deleteById(id);
    }

    /**
     * Retrieve students by course
     */
    public List<Student> getStudentsByCourse(String course) {
        if (course == null || course.isEmpty()) {
            throw new IllegalArgumentException("Course name cannot be empty");
        }

        List<Student> students = studentRepository.findByCourse(course);
        if (students.isEmpty()) {
            throw new StudentNotFoundException("No students found for course: " + course);
        }

        return students;
    }
}
