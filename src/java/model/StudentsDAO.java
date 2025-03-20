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
public class StudentsDAO extends MyDAO {

    public void insert(Students x) {
        xSql = "exec InsertIntoStudents @StudentName=?, @DOB=?, @Gender=?, @Email=?, @Phone=?, @Department=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStudentName());
            ps.setDate(2, x.getDob());
            ps.setString(3, x.getGender());
            ps.setString(4, x.getEmail());
            ps.setString(5, x.getPhone());
            ps.setString(6, x.getDepartment());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //Lấy thông tin sinh viên theo StudentID
    public Students getStudents(String xStudentID) {
        Students x = null;
        xSql = "select * from Students where StudentID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xStudentID);
            rs = ps.executeQuery();
            String xStudentName;
            Date xDob;
            String xGender;
            String xEmail;
            String xPhone;
            String xDepartment;
            if (rs.next()) {
                xStudentName = rs.getString("StudentName");
                xDob = rs.getDate("DOB");
                xGender = rs.getString("Gender");
                xEmail = rs.getString("Email");
                xPhone = rs.getString("Phone");
                xDepartment = rs.getString("Department");
                x = new Students(xStudentID, xStudentName, xDob, xGender, xEmail, xPhone, xDepartment);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    //Lấy thông tin sinh viên theo Email
    public Students getStudentsByEmail(String xEmail) {
        Students x = null;
        xSql = "select * from Students where Email=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xEmail);
            rs = ps.executeQuery();
            String xStudentID;
            String xStudentName;
            Date xDob;
            String xGender;
            String xPhone;
            String xDepartment;
            if (rs.next()) {
                xStudentID = rs.getString("StudentID");
                xStudentName = rs.getString("StudentName");
                xDob = rs.getDate("DOB");
                xGender = rs.getString("Gender");
                xPhone = rs.getString("Phone");
                xDepartment = rs.getString("Department");
                x = new Students(xStudentID, xStudentName, xDob, xGender, xEmail, xPhone, xDepartment);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    public Students getStudentsByPhone(String xPhone) {
        Students x = null;
        xSql = "select * from Students where Phone=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xPhone);
            rs = ps.executeQuery();
            String xStudentID;
            String xStudentName;
            Date xDob;
            String xGender;
            String xEmail;
            String xDepartment;
            if (rs.next()) {
                xStudentID = rs.getString("StudentID");
                xStudentName = rs.getString("StudentName");
                xDob = rs.getDate("DOB");
                xGender = rs.getString("Gender");
                xEmail = rs.getString("Phone");
                xDepartment = rs.getString("Department");
                x = new Students(xStudentID, xStudentName, xDob, xGender, xEmail, xPhone, xDepartment);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    //Cập nhật lại thông tin sinh viên
    public void update(String xEmail, Students x) {
        xSql = "update Students set StudentName=?, DOB=?, Gender=?, Phone=? where Email=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStudentName());
            ps.setDate(2, (Date) x.getDob());
            ps.setString(3, x.getGender());
            ps.setString(4, x.getPhone());
            ps.setString(5, x.getEmail());
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
