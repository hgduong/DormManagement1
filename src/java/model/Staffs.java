/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

public class Staffs {
    private String StaffID;
    private String StaffName;
    private Date DOB;
    private String Gender;
    private String Email;
    private String Phone;
    private String Position;
    private char BuildingID;

    public Staffs() {
    }

    public Staffs(String StaffID, String StaffName, Date DOB, String Gender, String Email, String Phone, String Position, char BuildingID) {
        this.StaffID = StaffID;
        this.StaffName = StaffName;
        this.DOB = DOB;
        this.Gender = Gender;
        this.Email = Email;
        this.Phone = Phone;
        this.Position = Position;
        this.BuildingID = BuildingID;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
    }

    public String getStaffName() {
        return StaffName;
    }

    public void setStaffName(String StaffName) {
        this.StaffName = StaffName;
    }

    public Date getDOB() {
        return DOB;
    }

    public void setDOB(Date DOB) {
        this.DOB = DOB;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getPosition() {
        return Position;
    }

    public void setPosition(String Position) {
        this.Position = Position;
    }

    public char getBuildingID() {
        return BuildingID;
    }

    public void setBuildingID(char BuildingID) {
        this.BuildingID = BuildingID;
    }
    
}
