/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class AssignmentsDAO extends MyDAO{
    public void insert(Assignments x) {
        xSql = "exec InsertIntoAssignments ?,?,?,?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setDate(1, x.getAssignmentDate());
            ps.setString(2, x.getStudentID());
            ps.setString(3, x.getRoomID());
            ps.setString(4, x.getStaffID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Assignments> getAssignments(char xBuildingID) {
        Assignments x;
        xSql = "select AssignmentID, AssignmentDate, AssignmentEnd, ReAssign, Assignments.RoomID, StaffID, StudentID from Assignments join Rooms on Assignments.RoomID=Rooms.RoomID where BuildingID=?";
        List<Assignments> t = new ArrayList<>();
        String xAssignmentID;
        Date xAssignmentDate;
        Date xAssignmentEnd;
        String xReAssign;
        String xStudentID;
        String xRoomID;
        String xStaffID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            while (rs.next()) {
                xAssignmentID = rs.getString("AssignmentID");
                xStaffID = rs.getString("StaffID");
                xAssignmentDate = rs.getDate("AssignmentDate");
                xAssignmentEnd = rs.getDate("AssignmentEnd");
                xReAssign = rs.getString("ReAssign");
                xStudentID = rs.getString("StudentID");
                xRoomID = rs.getString("RoomID");
                x = new Assignments(xAssignmentID, xAssignmentDate, xAssignmentEnd, xReAssign, xStudentID, xRoomID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    
    //Lấy thông tin Assignment theo StaffID
    public List<Assignments> getAssignmentsByStaffs(String xStaffID) {
        Assignments x;
        xSql = "select * from Assignments where StaffID=?";
        List<Assignments> t = new ArrayList<>();
        String xAssignmentID;
        Date xAssignmentDate;
        Date xAssignmentEnd;
        String xReAssign;
        String xStudentID;
        String xRoomID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStaffID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xAssignmentID = rs.getString("AssignmentID");
                xAssignmentDate = rs.getDate("AssignmentDate");
                xAssignmentEnd = rs.getDate("AssignmentEnd");
                xReAssign = rs.getString("ReAssign");
                xStudentID = rs.getString("StudentID");
                xRoomID = rs.getString("RoomID");
                x = new Assignments(xAssignmentID, xAssignmentDate, xAssignmentEnd, xReAssign, xStudentID, xRoomID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    //Lấy thông tin Assignment theo StudentID
    public List<Assignments> getAssignmentsByStudents(String xStudentID) {
        Assignments x;
        xSql = "select * from Assignments where StudentID=? and ReAssign='Yes'";
        List<Assignments> t = new ArrayList<>();
        String xAssignmentID;
        Date xAssignmentDate;
        Date xAssignmentEnd;
        String xReAssign;
        String xStaffID;
        String xRoomID;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStudentID);
            rs = ps.executeQuery();
            while (rs.next()) {
                xAssignmentID = rs.getString("AssignmentID");
                xAssignmentDate = rs.getDate("AssignmentDate");
                xAssignmentEnd = rs.getDate("AssignmentEnd");
                xReAssign = rs.getString("ReAssign");
                xStaffID = rs.getString("StaffID");
                xRoomID = rs.getString("RoomID");
                x = new Assignments(xAssignmentID, xAssignmentDate, xAssignmentEnd, xReAssign, xStudentID, xRoomID, xStaffID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    //Sinh viên không muốn gia hạn phòng trong kỳ tiếp theo
    public void update_ReAssign(String xAssignmentID, Assignments x) {
        xSql = "exec Update_ReAssign ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getAssignmentID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void delete(String xAssignmentID, Assignments x) {
        xSql = "delete from Assignments where AssignmentID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getAssignmentID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
  
    public void updateData() {
        try{
            con.setAutoCommit(false);
            xSql = "exec InsertIntoAssignments '2000/02/02','XXXXXXXX','C410','XXXXXXXX'";
            ps = con.prepareStatement(xSql);
            ps.executeUpdate();
            ps.close();
            
            xSql = "delete from Assignments where StudentID='XXXXXXXX'";
            ps.executeUpdate();
            ps.close();
            
            con.commit();
        } catch (SQLException e) {
            if (con != null) {
            try {
                con.rollback(); // Hoàn tác nếu có lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
            e.printStackTrace();   
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
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
