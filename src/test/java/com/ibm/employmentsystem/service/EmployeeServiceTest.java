package com.ibm.employmentsystem.service;

import com.ibm.employmentsystem.model.Employee;
import com.ibm.employmentsystem.repository.EmployeeRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class EmployeeServiceTest {

    @InjectMocks
    private EmployeeService employeeService;

    @Mock
    private EmployeeRepository employeeRepository;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    private Employee sampleEmp() {
        Employee emp = new Employee();
        emp.setUid(1L);
        emp.setFirstName("John");
        emp.setMiddleName("K");
        emp.setLastName("Doe");
        emp.setBirthDate(LocalDate.of(1995, 5, 15));
        emp.setPosition("Developer");
        return emp;
    }

    @Test
    void testAddEmployee_Success() {
        Employee emp = sampleEmp();

        when(employeeRepository.findByFirstNameAndMiddleNameAndLastNameAndBirthDate(
                eq(emp.getFirstName()), eq(emp.getMiddleName()), eq(emp.getLastName()), eq(emp.getBirthDate())
        )).thenReturn(Optional.empty());

        String result = employeeService.addEmployee(emp);

        assertEquals("SUCCESS", result);
        verify(employeeRepository, times(1)).save(emp);
    }

    @Test
    void testAddEmployee_Duplicate() {
        Employee emp = sampleEmp();

        when(employeeRepository.findByFirstNameAndMiddleNameAndLastNameAndBirthDate(
                eq(emp.getFirstName()), eq(emp.getMiddleName()), eq(emp.getLastName()), eq(emp.getBirthDate())
        )).thenReturn(Optional.of(emp));

        String result = employeeService.addEmployee(emp);

        assertEquals("DUPLICATE", result);
        verify(employeeRepository, never()).save(any());
    }

    @Test
    void testAddEmployee_InvalidDOB() {
        Employee emp = sampleEmp();
        emp.setBirthDate(LocalDate.now().plusDays(1)); // Future DOB

        String result = employeeService.addEmployee(emp);

        assertEquals("INVALID_DATE", result);
        verify(employeeRepository, never()).save(any());
    }

    @Test
    void testGetAllEmployees() {
        List<Employee> list = Arrays.asList(sampleEmp());
        when(employeeRepository.findAll()).thenReturn(list);

        List<Employee> result = employeeService.getAllEmployees();

        assertEquals(1, result.size());
        assertEquals("John", result.get(0).getFirstName());
    }

    @Test
    void testGetEmployeeById() {
        Employee emp = sampleEmp();
        when(employeeRepository.findById(1L)).thenReturn(Optional.of(emp));

        Employee result = employeeService.getEmployeeById(1L);

        assertNotNull(result);
        assertEquals("John", result.getFirstName());
    }

    @Test
    void testUpdateEmployee_Success() {
        Employee emp = sampleEmp();

        when(employeeRepository.findByFirstNameAndMiddleNameAndLastNameAndBirthDate(
                eq(emp.getFirstName()), eq(emp.getMiddleName()), eq(emp.getLastName()), eq(emp.getBirthDate())
        )).thenReturn(Optional.of(emp));

        String result = employeeService.updateEmployee(emp);

        assertEquals("SUCCESS", result);
        verify(employeeRepository, times(1)).save(emp);
    }

    @Test
    void testUpdateEmployee_Duplicate() {
        Employee emp = sampleEmp();
        Employee duplicate = sampleEmp();
        duplicate.setUid(2L); // Different UID but same name & DOB

        when(employeeRepository.findByFirstNameAndMiddleNameAndLastNameAndBirthDate(
                eq(emp.getFirstName()), eq(emp.getMiddleName()), eq(emp.getLastName()), eq(emp.getBirthDate())
        )).thenReturn(Optional.of(duplicate));

        String result = employeeService.updateEmployee(emp);

        assertEquals("DUPLICATE", result);
        verify(employeeRepository, never()).save(any());
    }

    @Test
    void testDeleteEmployee() {
        employeeService.deleteEmployee(1L);
        verify(employeeRepository, times(1)).deleteById(1L);
    }
}
