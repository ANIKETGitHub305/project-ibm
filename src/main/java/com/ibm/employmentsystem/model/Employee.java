package com.ibm.employmentsystem.model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.*;

@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long uid;

    @NotBlank(message = "First name is required")
    @Column(nullable = false)
    private String firstName;

    private String middleName;

    @NotBlank(message = "Last name is required")
    @Column(nullable = false)
    private String lastName;

    @NotNull(message = "Birth date is required")
    @Past(message = "Birth date should not be later than current date.")
    @Column(nullable = false)
    private LocalDate birthDate;

    @NotBlank(message = "Position is required")
    @Column(nullable = false)
    private String position;

    // ✅ No constructor needed – JPA requires a default constructor
    public Employee() {
        // default constructor
    }

    // Getters and Setters
    public Long getUid() { return uid; }
    public void setUid(Long uid) { this.uid = uid; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getMiddleName() { return middleName; }
    public void setMiddleName(String middleName) { this.middleName = middleName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public LocalDate getBirthDate() { return birthDate; }
    public void setBirthDate(LocalDate birthDate) { this.birthDate = birthDate; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
}
