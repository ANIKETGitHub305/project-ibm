package com.ibm.employmentsystem.controller;

import com.ibm.employmentsystem.model.Compensation;
import com.ibm.employmentsystem.model.Employee;
import com.ibm.employmentsystem.service.CompensationService;
import com.ibm.employmentsystem.service.EmployeeService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

class CompensationControllerTest {

    @Mock
    private CompensationService compensationService;

    @Mock
    private EmployeeService employeeService;

    @InjectMocks
    private CompensationController compensationController;

    private MockMvc mockMvc;

    private Employee employee;
    private Compensation compensation;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(compensationController).build();

        employee = new Employee();
        employee.setUid(1L);
        employee.setFirstName("John");
        employee.setLastName("Doe");

        compensation = new Compensation();
        compensation.setId(1L);
        compensation.setEmployee(employee);
        compensation.setAmount(1000.0);
        compensation.setDescription("Test");
        compensation.setType("BONUS");
        compensation.setDate(LocalDate.of(2025, 5, 10));
    }

    @Test
    void testShowAddForm() throws Exception {
        when(employeeService.getAllEmployees()).thenReturn(List.of(employee));

        mockMvc.perform(get("/compensation/add"))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("compensation"))
                .andExpect(model().attributeExists("employees"))
                .andExpect(view().name("add_compensation"));
    }

    @Test
    void testSaveComp_Success() throws Exception {
        when(compensationService.addCompensation(any())).thenReturn("SUCCESS");
        when(employeeService.getAllEmployees()).thenReturn(List.of(employee));

        mockMvc.perform(post("/compensation/save")
                .param("uid", "1")
                .param("type", "BONUS")
                .param("amount", "5000")
                .param("description", "Reward")
                .param("date", "2025-05-10"))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("msg"))
                .andExpect(view().name("add_compensation"));
    }

    @Test
    void testShowCompensationHistoryForm() throws Exception {
        when(employeeService.getAllEmployees()).thenReturn(List.of(employee));

        mockMvc.perform(get("/compensation/history"))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("employees"))
                .andExpect(view().name("comp_history_form"));
    }

    @Test
    void testProcessCompBreakdown_NoData() throws Exception {
        when(compensationService.getCompensationsByMonth(1L, "2025-05"))
                .thenReturn(Collections.emptyList());

        mockMvc.perform(post("/compensation/breakdown")
                .param("uid", "1")
                .param("yearMonth", "2025-05"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/compensation/monthly-entry"));
    }

    @Test
    void testShowEditForm_Exists() throws Exception {
        when(compensationService.getCompensationById(1L)).thenReturn(compensation);

        mockMvc.perform(get("/compensation/edit")
                .param("id", "1")
                .param("uid", "1")
                .param("yearMonth", "2025-05"))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("compensation"))
                .andExpect(model().attributeExists("uid"))
                .andExpect(model().attributeExists("yearMonth"))
                .andExpect(view().name("edit_comp"));
    }

    @Test
    void testUpdateCompensation_Success() throws Exception {
        when(compensationService.getCompensationById(1L)).thenReturn(compensation);
        when(compensationService.validateAndUpdate(any(), any(), any())).thenReturn("SUCCESS");

        mockMvc.perform(post("/compensation/update")
                .param("id", "1")
                .param("amount", "1200")
                .param("description", "Updated"))
                .andExpect(status().isOk())
                .andExpect(model().attributeExists("msg"))
                .andExpect(view().name("edit_comp"));
    }
}
