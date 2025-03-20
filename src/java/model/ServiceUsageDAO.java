/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class ServiceUsageDAO extends MyDAO{
    
    public void insert(ServiceUsage x) {
        xSql = "exec InsertIntoServiceUsage ?,?,?,?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setDate(1, x.getUsageDate());
            ps.setString(2, x.getRoomID());
            ps.setString(3, x.getServiceID());
            ps.setString(4, x.getStaffID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<ServiceUsage> getServices(char xBuildingID) {
        ServiceUsage x;
        xSql = "select UsageID, UsageDate, UsageEnd, ServiceID, ServiceUsage.RoomID, StaffID from ServiceUsage join Rooms on ServiceUsage.RoomID=Rooms.RoomID where BuildingID=?";
        List<ServiceUsage> t = new ArrayList<>();
        String xUsageID;
        Date xUsageDate;
        Date xUsageEnd;
        String xRoomID;
        String xServiceID;
        String xStaffID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            while (rs.next()) {
                xUsageID = rs.getString("UsageID");
                xUsageDate = rs.getDate("UsageDate");
                xUsageEnd = rs.getDate("UsageEnd");
                xServiceID = rs.getString("ServiceID");
                xRoomID = rs.getString("RoomID");
                xStaffID = rs.getString("StaffID");
                x = new ServiceUsage(xUsageID, xUsageDate, xUsageEnd, xRoomID, xServiceID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }   
    
    //Lấy thông tin dịch vụ theo StaffID
    public List<ServiceUsage> getServiceUsageByStaffs(String xStaffID) {
        ServiceUsage x;
        xSql = "select * from ServiceUsage where StaffID=?";
        List<ServiceUsage> t = new ArrayList<>();
        String xUsageID;
        Date xUsageDate;
        Date xUsageEnd;
        String xRoomID;
        String xServiceID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xUsageID = rs.getString("UsageID");
                xUsageDate = rs.getDate("UsageDate");
                xUsageEnd = rs.getDate("UsageEnd");
                xServiceID = rs.getString("ServiceID");
                xRoomID = rs.getString("RoomID");
                x = new ServiceUsage(xUsageID, xUsageDate, xUsageEnd, xRoomID, xServiceID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    //Lấy thông tin dịch vụ theo RoomID
    public List<ServiceUsage> getServiceUsageByRooms(String xRoomID) {
        ServiceUsage x;
        xSql = "select * from ServiceUsage where RoomID=?";
        List<ServiceUsage> t = new ArrayList<>();
        String xUsageID;
        Date xUsageDate;
        Date xUsageEnd;
        String xStaffID;
        String xServiceID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xRoomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xUsageID = rs.getString("UsageID");
                xUsageDate = rs.getDate("UsageDate");
                xUsageEnd = rs.getDate("UsageEnd");
                xServiceID = rs.getString("ServiceID");
                xStaffID = rs.getString("StaffID");
                x = new ServiceUsage(xUsageID, xUsageDate, xUsageEnd, xRoomID, xServiceID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public String[] getColNames(String xTable) {
        String[] a = new String[30];
        int i = 0;
        int n;
        xSql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xTable);
            rs = ps.executeQuery();
            String xColName;
            i = 0;
            while (rs.next()) {
                xColName = rs.getString("COLUMN_NAME");
                a[i++] = xColName;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        n = i;
        String[] b = new String[n];
        for (i = 0; i < n; i++) {
            b[i] = a[i];
        }
        return (b);
    }
}
