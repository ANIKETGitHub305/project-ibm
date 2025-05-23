package com.ibm.employmentsystem.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ibm.employmentsystem.model.Compensation;

public interface CompensationRepository extends JpaRepository<Compensation, Long> {
	boolean existsByEmployeeUidAndTypeAndDateBetween(Long uid, String type, LocalDate start, LocalDate end);
	List<Compensation> findByEmployeeUidAndDateBetween(Long uid, LocalDate start, LocalDate end);

}
