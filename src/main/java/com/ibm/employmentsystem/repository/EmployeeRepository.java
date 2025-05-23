package com.ibm.employmentsystem.repository;

import com.ibm.employmentsystem.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    @Query("SELECT e FROM Employee e " +
           "WHERE (:firstName IS NULL OR LOWER(e.firstName) LIKE LOWER(CONCAT('%', :firstName, '%'))) " +
           "AND (:lastName IS NULL OR LOWER(e.lastName) LIKE LOWER(CONCAT('%', :lastName, '%'))) " +
           "AND (:position IS NULL OR LOWER(e.position) LIKE LOWER(CONCAT('%', :position, '%')))")
    List<Employee> searchEmployees(
        @Param("firstName") String firstName,
        @Param("lastName") String lastName,
        @Param("position") String position
    );

    Optional<Employee> findByFirstNameAndMiddleNameAndLastNameAndBirthDate(
        String firstName,
        String middleName,
        String lastName,
        LocalDate birthDate
    );
    Optional<Employee> findByUid(Long uid);
}
