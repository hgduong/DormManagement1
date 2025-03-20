/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class ServicesDAO extends MyDAO{
    public List<Services> getServices() {
        String xServiceID;
        String xServiceName;
        int xCost;
        Services x;
        List<Services> t = new ArrayList<>();
        xSql = "select * from Services";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                xServiceID = rs.getString("ServiceID");
                xServiceName = rs.getString("ServiceName");
                xCost = rs.getInt("Cost");
                x = new Services(xServiceID, xServiceName, xCost);
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
