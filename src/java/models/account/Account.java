/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.account;

/**
 *
 * @author daing
 */
public class Account {

    private int id;
    private String email;
    private String password;
    private String name;
    private String phone;
    private int role;

    public Account() {
    }

    public Account(String email, String password, String name, String phone, int role) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.role = role;
    }

    public Account(int id, String email, String password, String name, String phone, int role) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}
