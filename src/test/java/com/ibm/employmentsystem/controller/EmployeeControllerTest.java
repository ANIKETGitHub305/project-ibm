package com.ibm.employmentsystem.controller;

import com.ibm.employmentsystem.model.Employee;
import com.ibm.employmentsystem.service.EmployeeService;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.time.LocalDate;
import java.util.*;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

class EmployeeControllerTest {

    @InjectMocks
    private EmployeeController employeeController;

    @Mock
    private EmployeeService employeeService;

    private MockMvc mockMvc;

    private Employee sampleEmp;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(employeeController).build();

        sampleEmp = new Employee();
        sampleEmp.setUid(1L);
        sampleEmp.setFirstName("John");
        sampleEmp.setMiddleName("K");
        sampleEmp.setLastName("Doe");
        sampleEmp.setBirthDate(LocalDate.of(1990, 1, 1));
        sampleEmp.setPosition("Developer");
    }

    @Test
    void testShowAddForm() throws Exception {
        mockMvc.perform(get("/employee/add"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("employee"))
                .andExpect(view().name("addEmployee"));
    }

    @Test
    void testAddEmployee_Success() throws Exception {
        when(employeeService.addEmployee(any(Employee.class))).thenReturn("SUCCESS");

        mockMvc.perform(post("/employee/add")
                .param("firstName", "John")
                .param("middleName", "K")
                .param("lastName", "Doe")
                .param("birthDate", "1990-01-01")
                .param("position", "Developer"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("msg"))
                .andExpect(view().name("addEmployee"));
    }

    @Test
    void testAddEmployee_Duplicate() throws Exception {
        when(employeeService.addEmployee(any(Employee.class))).thenReturn("DUPLICATE");

        mockMvc.perform(post("/employee/add")
                .param("firstName", "John")
                .param("middleName", "K")
                .param("lastName", "Doe")
                .param("birthDate", "1990-01-01")
                .param("position", "Developer"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("error"))
                .andExpect(view().name("addEmployee"));
    }

    @Test
    void testListAllEmployees() throws Exception {
        when(employeeService.getAllEmployees()).thenReturn(List.of(sampleEmp));

        mockMvc.perform(get("/employee/list"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("employees"))
                .andExpect(view().name("list_employees"));
    }

    @Test
    void testSearchEmployees() throws Exception {
        when(employeeService.searchEmployees(any(), any(), any())).thenReturn(List.of(sampleEmp));

        mockMvc.perform(get("/employee/search")
                .param("firstName", "John")
                .param("lastName", "Doe")
                .param("position", "Developer"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("employees"))
                .andExpect(view().name("searchEmployee"));
    }

    @Test
    void testShowEditForm() throws Exception {
        when(employeeService.getEmployeeById(1L)).thenReturn(sampleEmp);

        mockMvc.perform(get("/employee/edit").param("uid", "1"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("employee"))
                .andExpect(view().name("edit_employee"));
    }

    @Test
    void testShowEditForm_NotFound() throws Exception {
        when(employeeService.getEmployeeById(99L)).thenReturn(null);

        mockMvc.perform(get("/employee/edit").param("uid", "99"))
                .andDo(print())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/employee/list"));
    }

    @Test
    void testUpdateEmployee_Success() throws Exception {
        when(employeeService.updateEmployee(any())).thenReturn("SUCCESS");

        mockMvc.perform(post("/employee/update")
                .param("uid", "1")
                .param("firstName", "John")
                .param("middleName", "K")
                .param("lastName", "Doe")
                .param("birthDate", "1990-01-01")
                .param("position", "Developer"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("successMessage"))
                .andExpect(view().name("edit_employee"));
    }

    @Test
    void testUpdateEmployee_Duplicate() throws Exception {
        when(employeeService.updateEmployee(any())).thenReturn("DUPLICATE");

        mockMvc.perform(post("/employee/update")
                .param("uid", "1")
                .param("firstName", "John")
                .param("middleName", "K")
                .param("lastName", "Doe")
                .param("birthDate", "1990-01-01")
                .param("position", "Developer"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("errorMessage"))
                .andExpect(view().name("edit_employee"));
    }

    @Test
    void testDeleteEmployee() throws Exception {
        doNothing().when(employeeService).deleteEmployee(1L);

        mockMvc.perform(get("/employee/delete").param("uid", "1"))
                .andDo(print())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/employee/list"));
    }
}
