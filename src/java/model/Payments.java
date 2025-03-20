/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author admin
 */
public class Payments {
    private String PaymentID;
    private int Amount;
    private String PaymentMethod;
    private Date PaymentDeadLine;
    private String Status;
    private String StudentID;
    private String RoomID;
    private String StaffID;
    private String AssignmentID;
    private String UsageID;

    public Payments() {
    }

    public Payments(String PaymentID, int Amount, String PaymentMethod, Date PaymentDeadLine, String Status, String StudentID, String RoomID, String StaffID, String AssignmentID, String UsageID) {
        this.PaymentID = PaymentID;
        this.Amount = Amount;
        this.PaymentMethod = PaymentMethod;
        this.PaymentDeadLine = PaymentDeadLine;
        this.Status = Status;
        this.StudentID = StudentID;
        this.RoomID = RoomID;
        this.StaffID = StaffID;
        this.AssignmentID = AssignmentID;
        this.UsageID = UsageID;
    }

    public String getPaymentID() {
        return PaymentID;
    }

    public void setPaymentID(String PaymentID) {
        this.PaymentID = PaymentID;
    }

    public int getAmount() {
        return Amount;
    }

    public void setAmount(int Amount) {
        this.Amount = Amount;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public Date getPaymentDeadLine() {
        return PaymentDeadLine;
    }

    public void setPaymentDeadLine(Date PaymentDeadLine) {
        this.PaymentDeadLine = PaymentDeadLine;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getStudentID() {
        return StudentID;
    }

    public void setStudentID(String StudentID) {
        this.StudentID = StudentID;
    }

    public String getRoomID() {
        return RoomID;
    }

    public void setRoomID(String RoomID) {
        this.RoomID = RoomID;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
    }

    public String getAssignmentID() {
        return AssignmentID;
    }

    public void setAssignmentID(String AssignmentID) {
        this.AssignmentID = AssignmentID;
    }

    public String getUsageID() {
        return UsageID;
    }

    public void setUsageID(String UsageID) {
        this.UsageID = UsageID;
    }
    
    
}
