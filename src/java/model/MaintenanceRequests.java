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
public class MaintenanceRequests {
    private String RequestID;
    private Date RequestDate;
    private String ProblemDescription;
    private String Status;
    private Date CompletionDate;
    private String RoomID;
    private String StaffID;

    public MaintenanceRequests() {
    }

    public MaintenanceRequests(String RequestID, Date RequestDate, String ProblemDescription, String Status, Date CompletionDate, String RoomID, String StaffID) {
        this.RequestID = RequestID;
        this.RequestDate = RequestDate;
        this.ProblemDescription = ProblemDescription;
        this.Status = Status;
        this.CompletionDate = CompletionDate;
        this.RoomID = RoomID;
        this.StaffID = StaffID;
    }

    public String getRequestID() {
        return RequestID;
    }

    public void setRequestID(String RequestID) {
        this.RequestID = RequestID;
    }

    public Date getRequestDate() {
        return RequestDate;
    }

    public void setRequestDate(Date RequestDate) {
        this.RequestDate = RequestDate;
    }

    public String getProblemDescription() {
        return ProblemDescription;
    }

    public void setProblemDescription(String ProblemDescription) {
        this.ProblemDescription = ProblemDescription;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public Date getCompletionDate() {
        return CompletionDate;
    }

    public void setCompletionDate(Date CompletionDate) {
        this.CompletionDate = CompletionDate;
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
    
    
}
