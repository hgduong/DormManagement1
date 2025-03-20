/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class MaintenanceRequestsDAO extends MyDAO{
    public void insert(MaintenanceRequests x) {
        xSql = "InsertIntoMaintenanceRequests ?,?,?,?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setDate(1, x.getRequestDate());
            ps.setString(2, x.getProblemDescription());
            ps.setString(3, x.getRoomID());
            ps.setString(4, x.getStaffID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<MaintenanceRequests> getRequests(char xBuildingID) {
        MaintenanceRequests x;
        xSql = "select RequestID, RequestDate, ProblemDescription, Status, MaintenanceRequests.RoomID, CompletionDate, StaffID from MaintenanceRequests join Rooms on MaintenanceRequests.RoomID=Rooms.RoomID where BuildingID=?";
        List<MaintenanceRequests> t = new ArrayList<>();
        String xRequestID;
        Date xRequestDate;
        String xProblemDescription;
        String xStatus;
        Date xCompletionDate;
        String xRoomID;
        String xStaffID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            while (rs.next()) {
                xRequestID = rs.getString("RequestID");
                xRequestDate = rs.getDate("RequestDate");
                xProblemDescription = rs.getString("ProblemDescription");
                xStatus = rs.getString("Status");
                xRoomID = rs.getString("RoomID");
                xCompletionDate = rs.getDate("CompletionDate");
                xStaffID = rs.getString("StaffID");
                x = new MaintenanceRequests(xRequestID, xRequestDate, xProblemDescription, xStatus, xCompletionDate, xRoomID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public List<MaintenanceRequests> getRequestsByStaffs(String xStaffID) {
        MaintenanceRequests x;
        xSql = "select * from MaintenanceRequests where StaffID=?";
        List<MaintenanceRequests> t = new ArrayList<>();
        String xRequestID;
        Date xRequestDate;
        String xProblemDescription;
        String xStatus;
        Date xCompletionDate;
        String xRoomID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xRequestID = rs.getString("RequestID");
                xRequestDate = rs.getDate("RequestDate");
                xProblemDescription = rs.getString("ProblemDescription");
                xStatus = rs.getString("Status");
                xRoomID = rs.getString("RoomID");
                xCompletionDate = rs.getDate("CompletionDate");
                x = new MaintenanceRequests(xRequestID, xRequestDate, xProblemDescription, xStatus, xCompletionDate, xRoomID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public List<MaintenanceRequests> getRequestsByRooms(String xRoomID) {
        MaintenanceRequests x;
        xSql = "select * from MaintenanceRequests where RoomID=?";
        List<MaintenanceRequests> t = new ArrayList<>();
        String xRequestID;
        Date xRequestDate;
        String xProblemDescription;
        String xStatus;
        Date xCompletionDate;
        String xStaffID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xRoomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xRequestID = rs.getString("RequestID");
                xRequestDate = rs.getDate("RequestDate");
                xProblemDescription = rs.getString("ProblemDescription");
                xStatus = rs.getString("Status");
                xStaffID = rs.getString("RoomID");
                xCompletionDate = rs.getDate("CompletionDate");
                x = new MaintenanceRequests(xRequestID, xRequestDate, xProblemDescription, xStatus, xCompletionDate, xRoomID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public void update(Date xCompletionDate, String xRequestID) {
        xSql = "exec Update_CompletionDate ?, ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setDate(1, xCompletionDate);
            ps.setString(2, xRequestID);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void delete() {
        xSql = "delete from MaintenanceRequests where Status='Completed'";
        try {
            ps = con.prepareStatement(xSql);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
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
