/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author admin
 */
public class PaymentsDAO extends MyDAO{
    //Lấy thông tin thanh toán theo StaffID
    
    public Payments getPayment(String xPaymentID) {
        Payments x = null;
        xSql = "select * from Payments where PaymentID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xPaymentID);
            rs = ps.executeQuery();
            Date xPaymentDeadline;
            String xPaymentMethod;
            int xAmount;
            String xRoomID;
            String xStudentID;
            String xAssignmentID;
            String xUsageID;
            String xStatus;
            String xStaffID;
            if (rs.next()) {
                xUsageID = rs.getString("UsageID");
                xPaymentDeadline = rs.getDate("PaymentDeadline");
                xPaymentMethod = rs.getString("PaymentMethod");
                xStudentID = rs.getString("StudentID");
                xRoomID = rs.getString("RoomID");
                xAmount = rs.getInt("Amount");
                xAssignmentID = rs.getString("AssignmentID");
                xStatus = rs.getString("Status");
                xStaffID = rs.getString("StaffID");
                x = new Payments(xPaymentID, xAmount, xPaymentMethod, xPaymentDeadline, xStatus, xStudentID, xRoomID, xStaffID, xAssignmentID, xUsageID);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }

    public List<Payments> getPayments(char xBuildingID) {
        Payments x;
        xSql = "select PaymentID, Amount, PaymentMethod, PaymentDeadline, Status, StudentID, Payments.RoomID, StaffID, AssignmentID, UsageID from Payments join Rooms on Payments.RoomID=Rooms.RoomID where BuildingID=?";
        List<Payments> t = new ArrayList<>();
        String xPaymentID;
        Date xPaymentDeadline;
        String xPaymentMethod;
        int xAmount;
        String xRoomID;
        String xStudentID;
        String xAssignmentID;
        String xUsageID;
        String xStatus;
        String xStaffID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            while (rs.next()) {
                xUsageID = rs.getString("UsageID");
                xPaymentDeadline = rs.getDate("PaymentDeadline");
                xPaymentMethod = rs.getString("PaymentMethod");
                xStudentID = rs.getString("StudentID");
                xRoomID = rs.getString("RoomID");
                xAmount = rs.getInt("Amount");
                xAssignmentID = rs.getString("AssignmentID");
                xStatus = rs.getString("Status");
                xPaymentID = rs.getString("PaymentID");
                xStaffID = rs.getString("StaffID");
                x = new Payments(xPaymentID, xAmount, xPaymentMethod, xPaymentDeadline, xStatus, xStudentID, xRoomID, xStaffID, xAssignmentID, xUsageID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public List<Payments> getPaymentsByStaffs(String xStaffID) {
        Payments x;
        xSql = "select * from Payments where StaffID=?";
        List<Payments> t = new ArrayList<>();
        String xPaymentID;
        Date xPaymentDeadline;
        String xPaymentMethod;
        int xAmount;
        String xRoomID;
        String xStudentID;
        String xAssignmentID;
        String xUsageID;
        String xStatus;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xUsageID = rs.getString("UsageID");
                xPaymentDeadline = rs.getDate("PaymentDeadline");
                xPaymentMethod = rs.getString("PaymentMethod");
                xStudentID = rs.getString("StudentID");
                xRoomID = rs.getString("RoomID");
                xAmount = rs.getInt("Amount");
                xAssignmentID = rs.getString("AssignmentID");
                xStatus = rs.getString("Status");
                xPaymentID = rs.getString("PaymentID");
                x = new Payments(xPaymentID, xAmount, xPaymentMethod, xPaymentDeadline, xStatus, xStudentID, xRoomID, xStaffID, xAssignmentID, xUsageID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    //Lấy thông tin dịch vụ theo RoomID & StudentID
    public List<Payments> getPaymentsByRooms(String xRoomID) {
        Payments x;
        xSql = "select * from Payments where RoomID=?";
        List<Payments> t = new ArrayList<>();
        String xPaymentID;
        Date xPaymentDeadline;
        String xPaymentMethod;
        int xAmount;
        String xAssignmentID;
        String xUsageID;
        String xStatus;
        String xStaffID;
        String xStudentID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xRoomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xUsageID = rs.getString("UsageID");
                xPaymentDeadline = rs.getDate("PaymentDeadline");
                xPaymentMethod = rs.getString("PaymentMethod");
                xStaffID = rs.getString("StaffID");
                xAmount = rs.getInt("Amount");
                xAssignmentID = rs.getString("AssignmentID");
                xStatus = rs.getString("Status");
                xPaymentID = rs.getString("PaymentID");
                xStudentID = rs.getString("StudentID");
                x = new Payments(xPaymentID, xAmount, xPaymentMethod, xPaymentDeadline, xStatus, xStudentID, xRoomID, xStaffID, xAssignmentID, xUsageID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    public void update(Payments x) {
        xSql = "exec Update_PaymentMethod ?,?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getPaymentID());
            ps.setString(2, x.getPaymentMethod());
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
