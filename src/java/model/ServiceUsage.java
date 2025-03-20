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
public class ServiceUsage {
    private String UsageID;
    private Date UsageDate;
    private Date UsageEnd;
    private String RoomID;
    private String ServiceID;
    private String StaffID;

    public ServiceUsage() {
    }

    public ServiceUsage(String UsageID, Date UsageDate, Date UsageEnd, String RoomID, String ServiceID, String StaffID) {
        this.UsageID = UsageID;
        this.UsageDate = UsageDate;
        this.UsageEnd = UsageEnd;
        this.RoomID = RoomID;
        this.ServiceID = ServiceID;
        this.StaffID = StaffID;
    }

    public String getUsageID() {
        return UsageID;
    }

    public void setUsageID(String UsageID) {
        this.UsageID = UsageID;
    }

    public Date getUsageDate() {
        return UsageDate;
    }

    public void setUsageDate(Date UsageDate) {
        this.UsageDate = UsageDate;
    }

    public Date getUsageEnd() {
        return UsageEnd;
    }

    public void setUsageEnd(Date UsageEnd) {
        this.UsageEnd = UsageEnd;
    }

    public String getRoomID() {
        return RoomID;
    }

    public void setRoomID(String RoomID) {
        this.RoomID = RoomID;
    }

    public String getServiceID() {
        return ServiceID;
    }

    public void setServiceID(String ServiceID) {
        this.ServiceID = ServiceID;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
    }
    
    
}
