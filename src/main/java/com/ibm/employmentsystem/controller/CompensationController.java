package com.ibm.employmentsystem.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.function.ToDoubleFunction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

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
                model.addAttribute("message", "Unknown error occurred.");
        }

        return "add_compensation";
    }

    @GetMapping("/history")
    public String showCompensationHistoryForm(@RequestParam("uid") String uid, Model model) {
        model.addAttribute("uid", uid);
        return "comp_history_form";
    }

    @PostMapping("/history")
    public String processCompHistory(@RequestParam("uid") String uid,
                                     @RequestParam("startDate") String startDate,
                                     @RequestParam("endDate") String endDate,
                                     Model model) {
        List<Compensation> history = compensationService.getCompensationHistory(uid,
                LocalDate.parse(startDate),
                LocalDate.parse(endDate));

        double total = history.stream()
                .filter(c -> c.getAmount() != null)
                .mapToDouble(Compensation::getAmount)
                .sum();

        model.addAttribute("compensations", history);
        model.addAttribute("totalAmount", total);
        model.addAttribute("uid", uid);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        return "comp_history";
    }

    @GetMapping("/breakdown")
    public String showCompBreakdownForm(@RequestParam("uid") Long uid, Model model) {
        model.addAttribute("uid", uid);
        return "comp_breakdown_form";
    }

    @PostMapping("/breakdown")
    public String processCompBreakdown(@RequestParam("uid") Long uid,
                                       @RequestParam("yearMonth") String yearMonth,
                                       Model model) {
        List<Compensation> comps = compensationService.getCompensationsByMonth(uid, yearMonth);

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

        model.addAttribute("uid", uid);
        model.addAttribute("yearMonth", yearMonth);
        model.addAttribute("salary", salary);
        model.addAttribute("bonus", bonus);
        model.addAttribute("other", other);
        return "comp_breakdown";
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
