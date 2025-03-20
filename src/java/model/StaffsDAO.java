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
public class StaffsDAO extends MyDAO {

    public void insert(Staffs x) {
        xSql = "exec InsertIntoStaffs ?,?,?,?,?,?,?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStaffName());
            ps.setDate(2, (Date) x.getDOB());
            ps.setString(3, x.getGender());
            ps.setString(4, x.getEmail());
            ps.setString(5, x.getPhone());
            ps.setString(6, x.getPosition());
            ps.setString(7, String.valueOf(x.getBuildingID()));
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Lấy thông tin nhân viên theo StaffID
    public Staffs getStaffs(String xStaffID, char xBuildingID) {
        Staffs x = null;
        xSql = "select * from Staffs where StaffID=? and BuildingID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            ps.setString(2, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            String xStaffName;
            Date xDOB;
            String xGender;
            String xEmail;
            String xPhone;
            String xPosition;
            if (rs.next()) {
                xStaffName = rs.getString("StaffName");
                xDOB = rs.getDate("DOB");
                xGender = rs.getString("Gender");
                xEmail = rs.getString("Email");
                xPhone = rs.getString("Phone");
                xPosition = rs.getString("Position");
                x = new Staffs(xStaffID, xStaffName, xDOB, xGender, xEmail, xPhone, xPosition, xBuildingID);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    //Lấy thông tin nhân viên theo Email
    public Staffs getStaffsByEmail(String xEmail) {
        Staffs x = null;
        xSql = "select * from Staffs where Email=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xEmail);
            rs = ps.executeQuery();
            String xStaffID;
            String xStaffName;
            Date xDOB;
            String xGender;
            String xPhone;
            String xPosition;
            String BuildingID;
            char xBuildingID;
            if (rs.next()) {
                xStaffID = rs.getString("StaffID");
                xStaffName = rs.getString("StaffName");
                xDOB = rs.getDate("DOB");
                xGender = rs.getString("Gender");
                xPhone = rs.getString("Phone");
                xPosition = rs.getString("Position");
                BuildingID = rs.getString("BuildingID");
                xBuildingID = BuildingID.charAt(0);
                x = new Staffs(xStaffID, xStaffName, xDOB, xGender, xEmail, xPhone, xPosition, xBuildingID);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    public Staffs getStaffsByPhone(String xPhone) {
        Staffs x = null;
        xSql = "select * from Staffs where Phone=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xPhone);
            rs = ps.executeQuery();
            String xStaffID;
            String xStaffName;
            Date xDOB;
            String xGender;
            String xEmail;
            String xPosition;
            String BuildingID;
            char xBuildingID;
            if (rs.next()) {
                xStaffID = rs.getString("StaffID");
                xStaffName = rs.getString("StaffName");
                xDOB = rs.getDate("DOB");
                xGender = rs.getString("Gender");
                xEmail = rs.getString("Phone");
                xPosition = rs.getString("Position");
                BuildingID = rs.getString("BuildingID");
                xBuildingID = BuildingID.charAt(0);
                x = new Staffs(xStaffID, xStaffName, xDOB, xGender, xEmail, xPhone, xPosition, xBuildingID);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    //Cập nhật lại thông tin nhân viên
    public void update(String xEmail, Staffs x) {
        xSql = "update Staffs set StaffName=?, DOB=?, Gender=?, Phone=? where Email=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStaffName());
            ps.setDate(2, (Date) x.getDOB());
            ps.setString(3, x.getGender());
            ps.setString(4, x.getPhone());
            ps.setString(5, x.getEmail());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
//xSql = "select * from Employee WHERE name like '%" + xxName + "%'";
    //List danh sách nhân viên trong toà nhà
    public List<Staffs> getStaffsList(char xBuildingID) {
        String xStaffID;
        String xStaffName;
        Date xDOB;
        String xGender;
        String xEmail;
        String xPhone;
        String xPosition;
        Staffs x;
        List<Staffs> t = new ArrayList<>();
        xSql = "select * from Staffs where BuildingID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            while (rs.next()) {
                xStaffID = rs.getString("StaffID");
                xStaffName = rs.getString("StaffName");
                xDOB = rs.getDate("DOB");
                xGender = rs.getString("Gender");
                xEmail = rs.getString("Email");
                xPhone = rs.getString("Phone");
                xPosition = rs.getString("Position");
                x = new Staffs(xStaffID, xStaffName, xDOB, xGender, xEmail, xPhone, xPosition, xBuildingID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    //Xử lý khi 1 staff thôi việc
    public void delete(String xStaffID, String xxStaffID) {
        xSql = "update Payments where StaffID=? set StaffID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            ps.setString(2, xxStaffID);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        xSql = "update MaintenanceRequests where StaffID=? set StaffID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            ps.setString(2, xxStaffID);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        xSql = "update ServiceUsage where StaffID=? set StaffID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            ps.setString(2, xxStaffID);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        xSql = "update Assignments where StaffID=? set StaffID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            ps.setString(2, xxStaffID);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        xSql = "delete Staffs where StaffID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
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
