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
public class RequestDAO extends MyDAO {

    public void insert(Request x) {
        xSql = "insert into Request (StudentID,RoomID,Description,Position,BuildingID) values (?,?,?,?,?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStudentID());
            ps.setString(2, x.getRoomID());
            ps.setString(3, x.getDescription());
            ps.setString(4, x.getPosition());
            ps.setString(5, String.valueOf(x.getBuildingID()));
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void insertService(Request x) {
        xSql = "insert into Request (StudentID,RoomID,Description,Position,BuildingID,ServiceID) values (?,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStudentID());
            ps.setString(2, x.getRoomID());
            ps.setString(3, x.getDescription());
            ps.setString(4, x.getPosition());
            ps.setString(5, String.valueOf(x.getBuildingID()));
            ps.setString(6, x.getServiceID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void update(String xStudentID, String xRoomID, String xDescription, Request x) {
        xSql = "update Request set Status=? where StudentID=? and RoomID=? and Description=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStatus());
            ps.setString(2, x.getStudentID());
            ps.setString(3, x.getRoomID());
            ps.setString(4, x.getDescription());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateService(String xStudentID, String xRoomID, String xDescription, String ServiceID, Request x) {
        xSql = "update Request set Status=? where StudentID=? and RoomID=? and Description=? and ServiceID=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getStatus());
            ps.setString(2, x.getStudentID());
            ps.setString(3, x.getRoomID());
            ps.setString(4, x.getDescription());
            ps.setString(5, x.getServiceID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Request> getRequestForStudent(String xStudentID) {
    List<Request> t = new ArrayList<>();
    xSql = "select * from Request where StudentID=?";
    String xRoomID;
    String xDescription;
    String xPosition;
    String xStatus;
    String BuildingID;
    char xBuildingID;
    String xServiceID;
    Request x;
    try {
      ps = con.prepareStatement(xSql);
      ps.setString(1, xStudentID);
      rs = ps.executeQuery();
      while(rs.next()) {
        xRoomID = rs.getString("RoomID");  
        xDescription = rs.getString("Description");  
        xPosition = rs.getString("Position");
        xStatus = rs.getString("Status");
        BuildingID = rs.getString("BuildingID");
        xBuildingID = BuildingID.charAt(0);
        xServiceID = rs.getString("ServiceID");
        x = new Request(xStudentID,xRoomID,xDescription,xPosition,xStatus,xBuildingID,xServiceID);
        t.add(x);
      }
      rs.close();
      ps.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
    return(t);
  }
    
    public List<Request> getRequest(char xBuildingID) {
    List<Request> t = new ArrayList<>();
    xSql = "select * from Request where BuildingID=? and Status = 'Pending'";
    String xStudentID;
    String xRoomID;
    String xDescription;
    String xPosition;
    String xStatus;
    String xServiceID;
    Request x;
    try {
      ps = con.prepareStatement(xSql);
      ps.setString(1, String.valueOf(xBuildingID));
      rs = ps.executeQuery();
      while(rs.next()) {
        xStudentID = rs.getString("StudentID"); 
        xRoomID = rs.getString("RoomID");  
        xDescription = rs.getString("Description");  
        xPosition = rs.getString("Position");
        xStatus = rs.getString("Status");
        xServiceID = rs.getString("ServiceID");
        x = new Request(xStudentID,xRoomID,xDescription,xPosition,xStatus,xBuildingID,xServiceID);
        t.add(x);
      }
      rs.close();
      ps.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
    return(t);
  }
    
    public List<Request> getRequestForStaff(String xPosition, char xBuildingID) {
    List<Request> t = new ArrayList<>();
    xSql = "select * from Request where Position=? and BuildingID=? and Status = 'Pending'";
    String xRoomID;
    String xDescription;
    String xStudentID;
    String xStatus;
    String xServiceID;
    Request x;
    try {
      ps = con.prepareStatement(xSql);
      ps.setString(1, xPosition);
      ps.setString(2, String.valueOf(xBuildingID));
      rs = ps.executeQuery();
      while(rs.next()) {
        xRoomID = rs.getString("RoomID");  
        xDescription = rs.getString("Description");  
        xStudentID = rs.getString("StudentID");
        xStatus = rs.getString("Status");
        xServiceID = rs.getString("ServiceID");
        x = new Request(xStudentID,xRoomID,xDescription,xPosition,xStatus,xBuildingID,xServiceID);
        t.add(x);
      }
      rs.close();
      ps.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
    return(t);
  }
    
    public void delete(String xStatus) {
     xSql = "delete from Request where Status=?";
     try {
        ps = con.prepareStatement(xSql);
        ps.setString(1, xStatus);
        ps.executeUpdate();
        //con.commit();
        ps.close();
     }
     catch(Exception e) {
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
