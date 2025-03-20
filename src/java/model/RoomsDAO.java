/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class RoomsDAO extends MyDAO {
    
    public Rooms getRooms(String xRoomID) {
        Rooms x = null;
        xSql = "select * from Rooms where RoomID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xRoomID);
            rs = ps.executeQuery();
            int xCapacity;
            int xCurrentOccupants;
            int xRoomNumber;
            int xFloor;
            int xRoomPrice;
            char xBuildingID;
            String BuildingID;
            if (rs.next()) {
                xCapacity = rs.getInt("Capacity");
                xCurrentOccupants = rs.getInt("CurrentOccupants");
                xRoomNumber = rs.getInt("RoomNumber");
                xFloor = rs.getInt("Floor");
                xRoomPrice = rs.getInt("RoomPrice");
                BuildingID = rs.getString("BuildingID");
                xBuildingID = BuildingID.charAt(0);
                x = new Rooms(xRoomID, xCapacity, xCurrentOccupants, xRoomNumber, xFloor, xRoomPrice, xBuildingID);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    //Lấy thông tin các phòng theo BuildingID
    public List<Rooms> getRooms(char xBuildingID) {
        String xRoomID;
        int xCapacity;
        int xCurrentOccupants;
        int xRoomNumber;
        int xFloor;
        int xRoomPrice;
        Rooms x;
        
        List<Rooms> t = new ArrayList<>();
        xSql = "select * from Rooms where BuildingID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            while (rs.next()) {
                xRoomID = rs.getString("RoomID");
                xCapacity = rs.getInt("Capacity");
                xCurrentOccupants = rs.getInt("CurrentOccupants");
                xRoomNumber = rs.getInt("RoomNumber");
                xFloor = rs.getInt("Floor");
                xRoomPrice = rs.getInt("RoomPrice");
                x = new Rooms(xRoomID, xCapacity, xCurrentOccupants, xRoomNumber, xFloor, xRoomPrice, xBuildingID);
                t.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (t);
    }
    
    //Lấy list phòng trống trong 1 Building
    public List<Rooms> getFreeRooms(char xBuildingID) {
        String xRoomID;
        int xCapacity;
        int xCurrentOccupants;
        int xRoomNumber;
        int xFloor;
        int xRoomPrice;
        Rooms x;
        
        List<Rooms> t = new ArrayList<>();
        xSql = "select * from Rooms where BuildingID=? and (Capacity - CurrentOccupants)>0";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, String.valueOf(xBuildingID));
            rs = ps.executeQuery();
            while (rs.next()) {
                xRoomID = rs.getString("RoomID");
                xCapacity = rs.getInt("Capacity");
                xCurrentOccupants = rs.getInt("CurrentOccupants");
                xRoomNumber = rs.getInt("RoomNumber");
                xFloor = rs.getInt("Floor");
                xRoomPrice = rs.getInt("RoomPrice");
                x = new Rooms(xRoomID, xCapacity, xCurrentOccupants, xRoomNumber, xFloor, xRoomPrice, xBuildingID);
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
