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
public class Assignments {
    private String AssignmentID;
    private Date AssignmentDate;
    private Date AssignmentEnd;
    private String ReAssign;
    private String StudentID;
    private String RoomID;
    private String StaffID;

    public Assignments() {
    }

    public Assignments(String AssignmentID, Date AssignmentDate, Date AssignmentEnd, String ReAssign, String StudentID, String RoomID, String StaffID) {
        this.AssignmentID = AssignmentID;
        this.AssignmentDate = AssignmentDate;
        this.AssignmentEnd = AssignmentEnd;
        this.ReAssign = ReAssign;
        this.StudentID = StudentID;
        this.RoomID = RoomID;
        this.StaffID = StaffID;
    }

    public String getAssignmentID() {
        return AssignmentID;
    }

    public void setAssignmentID(String AssignmentID) {
        this.AssignmentID = AssignmentID;
    }

    public Date getAssignmentDate() {
        return AssignmentDate;
    }

    public void setAssignmentDate(Date AssignmentDate) {
        this.AssignmentDate = AssignmentDate;
    }

    public Date getAssignmentEnd() {
        return AssignmentEnd;
    }

    public void setAssignmentEnd(Date AssignmentEnd) {
        this.AssignmentEnd = AssignmentEnd;
    }

    public String getReAssign() {
        return ReAssign;
    }

    public void setReAssign(String ReAssign) {
        this.ReAssign = ReAssign;
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
    
    
}
