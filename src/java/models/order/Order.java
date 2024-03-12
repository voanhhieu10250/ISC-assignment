/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.order;

import java.util.Date;

/**
 *
 * @author daing
 */
public class Order {
    private int id;
    private Date orderDate;
    private int status;
    private String address;
    private int accId;

    public Order() {
    }

    public Order(int status, String address, int accId) {
        this.status = status;
        this.address = address;
        this.accId = accId;
    }

    public Order(int id, Date orderDate, int status, String address, int accId) {
        this.id = id;
        this.orderDate = orderDate;
        this.status = status;
        this.address = address;
        this.accId = accId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getAccId() {
        return accId;
    }

    public void setAccId(int accId) {
        this.accId = accId;
    }
}
