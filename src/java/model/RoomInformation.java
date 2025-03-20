
package model;

import java.sql.Date;

public class RoomInformation {
    private String StudentID;
    private String StudentName;
    private String RoomID;
    private Date AssignmentEnd;

    public RoomInformation() {
    }

    public RoomInformation(String StudentID, String StudentName, String RoomID, Date AssignmentEnd) {
        this.StudentID = StudentID;
        this.StudentName = StudentName;
        this.RoomID = RoomID;
        this.AssignmentEnd = AssignmentEnd;
    }

    public String getStudentID() {
        return StudentID;
    }

    public void setStudentID(String StudentID) {
        this.StudentID = StudentID;
    }

    public String getStudentName() {
        return StudentName;
    }

    public void setStudentName(String StudentName) {
        this.StudentName = StudentName;
    }

    public String getRoomID() {
        return RoomID;
    }

    public void setRoomID(String RoomID) {
        this.RoomID = RoomID;
    }

    public Date getAssignmentEnd() {
        return AssignmentEnd;
    }

    public void setAssignmentEnd(Date AssignmentEnd) {
        this.AssignmentEnd = AssignmentEnd;
    }
    
    
}
