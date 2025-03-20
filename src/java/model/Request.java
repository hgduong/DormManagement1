/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Request {
    private String StudentID;
    private String RoomID;
    private String Description;
    private String Position;
    private String Status;
    private char BuildingID;
    private String ServiceID;

    public Request() {
    }

    public Request(String StudentID, String RoomID, String Description, String Position, String Status, char BuildingID, String ServiceID) {
        this.StudentID = StudentID;
        this.RoomID = RoomID;
        this.Description = Description;
        this.Position = Position;
        this.Status = Status;
        this.BuildingID = BuildingID;
        this.ServiceID = ServiceID;
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

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getPosition() {
        return Position;
    }

    public void setPosition(String Position) {
        this.Position = Position;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public char getBuildingID() {
        return BuildingID;
    }

    public void setBuildingID(char BuildingID) {
        this.BuildingID = BuildingID;
    }

    public String getServiceID() {
        return ServiceID;
    }

    public void setServiceID(String ServiceID) {
        this.ServiceID = ServiceID;
    }

    
}
