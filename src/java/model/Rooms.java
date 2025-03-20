package model;

public class Rooms {
    private String RoomID;
    private int Capacity;
    private int CurrentOccupants;
    private int RoomNumber;
    private int Floor;
    private int RoomPrice;
    private char BuildingID;

    public Rooms() {
    }

    public Rooms(String RoomID, int Capacity, int CurrentOccupants, int RoomNumber, int Floor, int RoomPrice, char BuildingID) {
        this.RoomID = RoomID;
        this.Capacity = Capacity;
        this.CurrentOccupants = CurrentOccupants;
        this.RoomNumber = RoomNumber;
        this.Floor = Floor;
        this.RoomPrice = RoomPrice;
        this.BuildingID = BuildingID;
    }
    
    public String getRoomID() {
        return RoomID;
    }

    public void setRoomID(String RoomID) {
        this.RoomID = RoomID;
    }

    public int getCapacity() {
        return Capacity;
    }

    public void setCapacity(int Capacity) {
        this.Capacity = Capacity;
    }

    public int getRoomNumber() {
        return RoomNumber;
    }

    public void setRoomNumber(int RoomNumber) {
        this.RoomNumber = RoomNumber;
    }

    public int getCurrentOccupants() {
        return CurrentOccupants;
    }

    public void setRCurrentOccupants(int CurrentOccupants) {
        this.CurrentOccupants = CurrentOccupants;
    }

    public int getFloor() {
        return Floor;
    }

    public void setFloor(int Floor) {
        this.Floor = Floor;
    }

    public int getRoomPrice() {
        return RoomPrice;
    }

    public void setRoomPrice(int RoomPrice) {
        this.RoomPrice = RoomPrice;
    }

    public char getBuildingID() {
        return BuildingID;
    }

    public void setBuildingID(char BuildingID) {
        this.BuildingID = BuildingID;
    }
    
    
}
