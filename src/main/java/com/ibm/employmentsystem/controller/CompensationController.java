package com.ibm.employmentsystem.controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.ToDoubleFunction;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ibm.employmentsystem.model.Compensation;
import com.ibm.employmentsystem.model.Employee;
import com.ibm.employmentsystem.service.CompensationService;
import com.ibm.employmentsystem.service.EmployeeService;

@Controller
@RequestMapping("/compensation")
public class CompensationController {

    @Autowired
    private CompensationService compensationService;

    @Autowired
    private EmployeeService employeeService;

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("compensation", new Compensation());
        model.addAttribute("employees", employeeService.getAllEmployees());
        return "add_compensation";
    }

    @PostMapping("/save")
    public String saveComp(@ModelAttribute Compensation compensation, Model model) {
        String result = compensationService.addCompensation(compensation);

        // Always load employee dropdown
        model.addAttribute("employees", employeeService.getAllEmployees());

        switch (result) {
            case "DUPLICATE_SALARY":
                model.addAttribute("message", "Salary already exists for this month.");
                break;
            case "INVALID_AMOUNT":
                model.addAttribute("message", "Amount must be greater than 0 for selected type.");
                break;
            case "INVALID_ADJUSTMENT":
                model.addAttribute("message", "Adjustment amount cannot be zero.");
                break;
            case "MISSING_DESCRIPTION":
                model.addAttribute("message", "Description is required for this compensation type.");
                break;
            case "SUCCESS":
                model.addAttribute("msg", "Compensation added successfully!");
                model.addAttribute("compensation", new Compensation()); // Clear form for next entry
                break;
            default:
                model.addAttribute("message", "Description is required for this Adjustment type.");
        }

        return "add_compensation";
    }

    @GetMapping("/history")
    public String showCompensationHistoryForm(Model model) {
        model.addAttribute("employees", employeeService.getAllEmployees());
        return "comp_history_form";
    }
    @PostMapping("/history")
    public String processCompHistory(@RequestParam("uid") String uid,
                                     @RequestParam("startDate") String startDate,
                                     @RequestParam("endDate") String endDate,
                                     Model model) {
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);

        if (end.isBefore(start)) {
            model.addAttribute("error", "End date cannot be before start date.");
            model.addAttribute("employees", employeeService.getAllEmployees());
            return "comp_history_form";
        }

        List<Compensation> history = compensationService.getCompensationHistory(uid, start, end);

        // ✅ Group by YearMonth and sum
        Map<String, Double> monthlyTotals = history.stream()
                .collect(Collectors.groupingBy(
                    c -> YearMonth.from(c.getDate()).toString(), // e.g., "2025-05"
                    TreeMap::new, // maintain order
                    Collectors.summingDouble(c -> c.getAmount() != null ? c.getAmount() : 0.0)
                ));

        model.addAttribute("uid", uid);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("monthlyTotals", monthlyTotals); // ✅ Pass this to JSP

        return "comp_history";
    }




    @GetMapping("/breakdown")
    public String showCompBreakdownForm(@RequestParam("uid") Long uid, Model model) {
        model.addAttribute("uid", uid);
        return "comp_breakdown_form"; // for Monthly Breakdown from History page
    }

    @GetMapping("/monthly-entry")
    public String showMonthlyBreakdownEntryForm(Model model) {
        model.addAttribute("employees", employeeService.getAllEmployees());
        return "comp_breakdown_entry"; // for direct entry form
    }



    @PostMapping("/breakdown")
    public String processCompBreakdown(@RequestParam("uid") Long uid,
                                       @RequestParam("yearMonth") String yearMonth,
                                       Model model,
                                       RedirectAttributes redirectAttributes) {

        List<Compensation> comps = compensationService.getCompensationsByMonth(uid, yearMonth);

        if (comps == null || comps.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "❌ No compensation breakdown found for this employee and month.");
            return "redirect:/compensation/monthly-entry";
        }

        double salary = comps.stream()
                .filter(c -> "SALARY".equalsIgnoreCase(c.getType()))
                .mapToDouble(Compensation::getAmount)
                .sum();

        double bonus = comps.stream()
                .filter(c -> "BONUS".equalsIgnoreCase(c.getType()))
                .mapToDouble(Compensation::getAmount)
                .sum();

        double other = comps.stream()
                .filter(c -> !"SALARY".equalsIgnoreCase(c.getType()) &&
                             !"BONUS".equalsIgnoreCase(c.getType()))
                .mapToDouble(Compensation::getAmount)
                .sum();

        double total = salary + bonus + other;

        model.addAttribute("uid", uid);
        model.addAttribute("yearMonth", yearMonth);
        model.addAttribute("salary", salary);
        model.addAttribute("bonus", bonus);
        model.addAttribute("other", other);
        model.addAttribute("total", total);
        model.addAttribute("compensations", comps);

        return "comp_breakdown";
    }
    
    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") Long id,
                               @RequestParam("uid") Long uid,
                               @RequestParam("yearMonth") String yearMonth,
                               Model model) {
        Compensation comp = compensationService.getCompensationById(id);
        if (comp == null) {
            model.addAttribute("message", "Compensation not found.");
            return "redirect:/compensation/monthly-entry";
        }
        model.addAttribute("compensation", comp);
        model.addAttribute("uid", uid); // ✅ Needed to go back
        model.addAttribute("yearMonth", yearMonth);
        return "edit_comp";
    }

    
    @PostMapping("/update")
    public String updateCompensation(@RequestParam Long id,
                                     @RequestParam Double amount,
                                     @RequestParam String description,
                                     Model model) {

        Compensation comp = compensationService.getCompensationById(id);
        if (comp == null) {
            model.addAttribute("message", "Compensation not found.");
            return "edit_comp";
        }

        // Keep type and validation rules
        String result = compensationService.validateAndUpdate(comp, amount, description);

        if ("SUCCESS".equals(result)) {
            model.addAttribute("msg", "✅ Compensation updated successfully.");
        } else {
            model.addAttribute("message", result);
        }

        model.addAttribute("compensation", comp);
        return "edit_comp";
    }


    


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(LocalDate.class, new java.beans.PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                setValue(LocalDate.parse(text, DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            }
        });
    }
}
