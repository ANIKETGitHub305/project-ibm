package com.ibm.employmentsystem.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ibm.employmentsystem.model.Employee;
import com.ibm.employmentsystem.repository.EmployeeRepository;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    public String addEmployee(Employee employee) {
        if (employee.getBirthDate() == null || employee.getBirthDate().isAfter(LocalDate.now())) {
            return "INVALID_DATE";
        }

        Optional<Employee> existing = employeeRepository.findByFirstNameAndMiddleNameAndLastNameAndBirthDate(
                employee.getFirstName(),
                employee.getMiddleName(),
                employee.getLastName(),
                employee.getBirthDate());

        if (existing.isPresent()) {
            return "DUPLICATE";
        }

        employeeRepository.save(employee);
        return "SUCCESS";
    }

    public String updateEmployee(Employee employee) {
        if (employee.getBirthDate() == null || employee.getBirthDate().isAfter(LocalDate.now())) {
            return "INVALID_DATE";
        }

        Optional<Employee> duplicate = employeeRepository.findByFirstNameAndMiddleNameAndLastNameAndBirthDate(
                employee.getFirstName(),
                employee.getMiddleName(),
                employee.getLastName(),
                employee.getBirthDate());

        if (duplicate.isPresent() && !duplicate.get().getUid().equals(employee.getUid())) {
            return "DUPLICATE";
        }

        employeeRepository.save(employee);
        return "SUCCESS";
    }

    public List<Employee> searchEmployees(String firstName, String lastName, String position) {
        return employeeRepository.searchEmployees(
                firstName == null || firstName.trim().isEmpty() ? null : firstName,
                lastName == null || lastName.trim().isEmpty() ? null : lastName,
                position == null || position.trim().isEmpty() ? null : position
        );
    }

    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    public Employee getEmployeeById(Long uid) {
        return employeeRepository.findById(uid).orElse(null);
    }

    public void deleteEmployee(Long uid) {
        employeeRepository.deleteById(uid);
    }
}
