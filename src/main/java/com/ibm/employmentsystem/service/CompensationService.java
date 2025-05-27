package com.ibm.employmentsystem.service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ibm.employmentsystem.model.Compensation;
import com.ibm.employmentsystem.repository.CompensationRepository;

@Service
public class CompensationService {

    @Autowired
    private CompensationRepository compensationRepository;

    // ✅ FIXED: Removed static and used injected repository
    public String addCompensation(Compensation comp) {
        YearMonth month = YearMonth.from(comp.getDate());
        String type = comp.getType().toUpperCase();
        Double amount = comp.getAmount();
        String description = comp.getDescription() != null ? comp.getDescription().trim() : "";

        if ("SALARY".equals(type)) {
            boolean exists = compensationRepository.existsByEmployeeUidAndTypeAndDateBetween(
                    comp.getEmployee().getUid(), "SALARY",
                    month.atDay(1), month.atEndOfMonth()
            );
            if (exists) return "DUPLICATE_SALARY";
        }

        if (("BONUS".equals(type) || "COMMISSION".equals(type) || "ALLOWANCE".equals(type))
                && (amount == null || amount <= 0)) {
            return "INVALID_AMOUNT";
        }

        if ("ADJUSTMENT".equals(type) && (amount == null || amount == 0)) {
            return "INVALID_ADJUSTMENT";
        }

        if (("BONUS".equals(type) || "COMMISSION".equals(type) || "ALLOWANCE".equals(type) || "ADJUSTMENT".equals(type))
                && description.isEmpty()) {
            return "DESCRIPTION_REQUIRED";
        }

        compensationRepository.save(comp);
        return "SUCCESS";
    }

    public List<Compensation> getCompensationHistory(String uidStr, LocalDate startDate, LocalDate endDate) {
        Long uid = Long.parseLong(uidStr);
        return compensationRepository.findByEmployeeUidAndDateBetween(uid, startDate, endDate);
    }

    public List<Compensation> getCompensationsByMonth(Long uid, String yearMonth) {
        YearMonth ym = YearMonth.parse(yearMonth);
        LocalDate start = ym.atDay(1);
        LocalDate end = ym.atEndOfMonth();
        return compensationRepository.findByEmployeeUidAndDateBetween(uid, start, end);
    }

    public Compensation getCompensationById(Long id) {
        return compensationRepository.findById(id).orElse(null);
    }

    public String validateAndUpdate(Compensation comp, Double amount, String description) {
        String type = comp.getType().toUpperCase();

        if (("BONUS".equals(type) || "COMMISSION".equals(type) || "ALLOWANCE".equals(type)) && (amount == null || amount <= 0)) {
            return "❌ Amount must be greater than 0 for type: " + type;
        }

        if ("ADJUSTMENT".equals(type) && (amount == null || amount == 0)) {
            return "❌ Adjustment amount cannot be zero.";
        }

        if (("BONUS".equals(type) || "COMMISSION".equals(type) || "ALLOWANCE".equals(type) || "ADJUSTMENT".equals(type))
                && (description == null || description.trim().isEmpty())) {
            return "❌ Description is required for this type.";
        }

        comp.setAmount(amount);
        comp.setDescription(description.trim());
        compensationRepository.save(comp);
        return "SUCCESS";
    }
}
