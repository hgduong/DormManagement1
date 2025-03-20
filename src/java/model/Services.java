/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Services {
    private String ServiceID;
    private String ServiceName;
    private int Cost;

    public Services() {
    }
    
    
    public Services(String ServiceID, String ServiceName, int Cost) {
        this.ServiceID = ServiceID;
        this.ServiceName = ServiceName;
        this.Cost = Cost;
    }

    public String getServiceID() {
        return ServiceID;
    }

    public void setServiceID(String ServiceID) {
        this.ServiceID = ServiceID;
    }

    public String getServiceName() {
        return ServiceName;
    }

    public void setServiceName(String ServiceName) {
        this.ServiceName = ServiceName;
    }

    public int getCost() {
        return Cost;
    }

    public void setCost(int Cost) {
        this.Cost = Cost;
    }
    
}
