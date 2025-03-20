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
public class BuildingDAO extends MyDAO {
    //Lấy thông tin Building
    public Building getBuilding(char xBuildingID) {
        Building x = null;
        xSql = "select * from Building where BuildingID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            int xNumberOfFloors;
            int xNumberOfRooms;
            if (rs.next()) {
                xNumberOfFloors = rs.getInt("NumberOfFloors");
                xNumberOfRooms = rs.getInt("NumberOfRooms");
                x = new Building(xBuildingID, xNumberOfFloors, xNumberOfRooms);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    //Danh sách toà nhà
    public List<Building> getBuilding() {
        String buildingID;
        char xBuildingID;
        int xNumberOfFloors;
        int xNumberOfRooms;
        Building x;
        List<Building> t = new ArrayList<>();
        xSql = "select * from Building";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                buildingID = rs.getString("BuildingID");
                xBuildingID = buildingID.charAt(0);
                xNumberOfFloors = rs.getInt("NumberOfFloors");
                xNumberOfRooms = rs.getInt("NumberOfRooms");
                x = new Building(xBuildingID, xNumberOfFloors, xNumberOfRooms);
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
