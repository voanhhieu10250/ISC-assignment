/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.revenue;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author daing
 */
public class Revenue {

    private List<Item> list;

    public Revenue() {
        list = new ArrayList();
    }

    public List<Item> getList() {
        return list;
    }

    public void add(Item item) {
        list.add(item);
    }

    public double getTotal() {
        int total = 0;
        for (Item item : list) {
            total += item.getPrice();
        }
        return total;
    }
}
