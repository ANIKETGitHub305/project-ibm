package com.ibm.employmentsystem.service;

import com.ibm.employmentsystem.model.Compensation;
import com.ibm.employmentsystem.model.Employee;
import com.ibm.employmentsystem.repository.CompensationRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class CompensationServiceTest {

    @InjectMocks
    private CompensationService compensationService;

    @Mock
    private CompensationRepository compensationRepository;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testAddSalary_Duplicate() {
        Employee emp = new Employee();
        emp.setUid(1L);

        Compensation comp = new Compensation();
        comp.setEmployee(emp);
        comp.setType("SALARY");
        comp.setDate(LocalDate.of(2025, 5, 10));

        when(compensationRepository.existsByEmployeeUidAndTypeAndDateBetween(
                eq(1L), eq("SALARY"),
                any(LocalDate.class), any(LocalDate.class)
        )).thenReturn(true);

        String result = compensationService.addCompensation(comp);
        assertEquals("DUPLICATE_SALARY", result);
    }

    @Test
    void testAddBonusWithZeroAmount() {
        Compensation comp = new Compensation();
        comp.setType("BONUS");
        comp.setAmount(0.0);
        comp.setDescription("Performance");
        comp.setDate(LocalDate.of(2025, 5, 15)); // ✅ Fix

        String result = compensationService.addCompensation(comp);
        assertEquals("INVALID_AMOUNT", result);
    }

    @Test
    void testAddValidBonus() {
        Employee emp = new Employee(); // Required to avoid null in repository.save
        emp.setUid(1L);

        Compensation comp = new Compensation();
        comp.setEmployee(emp); // ✅ Set employee
        comp.setType("BONUS");
        comp.setAmount(2000.0);
        comp.setDescription("Performance");
        comp.setDate(LocalDate.of(2025, 6, 10)); // ✅ Fix

        when(compensationRepository.save(any(Compensation.class))).thenReturn(comp); // Optional for mock

        String result = compensationService.addCompensation(comp);
        assertEquals("SUCCESS", result);
    }

}
