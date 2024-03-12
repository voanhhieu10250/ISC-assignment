/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.category;

/**
 *
 * @author daing
 */
public class Category {
    private int id;
    private String name;

    // constructor
    public Category() {
    }

    // constructor with parameters inputted
    public Category(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // setter and getter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
