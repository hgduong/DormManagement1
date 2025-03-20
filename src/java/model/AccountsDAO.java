/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author admin
 */
public class AccountsDAO extends MyDAO {

    public void insert(Accounts x) {
        xSql = "insert into Accounts (Email, password, Role) values (?,?,?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getEmail());
            ps.setString(2, x.getPassword());
            ps.setString(3, x.getRole());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //Lấy lại mật khẩu
    public Accounts getAccount(String xEmail) {
        Accounts x = null;
        xSql = "select * from Accounts where Email=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xEmail);
            rs = ps.executeQuery();
            String xPassword;
            String xRole;
            if (rs.next()) {
                xEmail = rs.getString("Email");
                xPassword = rs.getString("password");
                xRole = rs.getString("Role");
                x = new Accounts(xEmail, xPassword, xRole);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    //Đổi mật khẩu
    public void update(String xEmail, Accounts x) {
        xSql = "update Accounts set password=? where Email=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getPassword());
            ps.setString(2, x.getEmail());
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
