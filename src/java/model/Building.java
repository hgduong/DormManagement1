/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Building {
    private char BuildingID;
    private int NumberOfFloors;
    private int NumberOfRooms;

    public Building() {
    }

    public Building(char BuildingID, int NumberOfFloors, int NumberOfRooms) {
        this.BuildingID = BuildingID;
        this.NumberOfFloors = NumberOfFloors;
        this.NumberOfRooms = NumberOfRooms;
    }

    public char getBuildingID() {
        return BuildingID;
    }

    public void setBuildingID(char BuildingID) {
        this.BuildingID = BuildingID;
    }

    public int getNumberOfFloors() {
        return NumberOfFloors;
    }

    public void setNumberOfFloors(int NumberOfFloors) {
        this.NumberOfFloors = NumberOfFloors;
    }

    public int getNumberOfRooms() {
        return NumberOfRooms;
    }

    public void setNumberOfRooms(int NumberOfRooms) {
        this.NumberOfRooms = NumberOfRooms;
    }
    
    
}
