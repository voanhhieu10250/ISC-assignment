/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.revenue;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import models.DBContext;

/**
 *
 * @author daing
 */
public class RevenueFacade {

    public Map getRevenue(Date startDate, Date endDate, int offset, int limit) throws SQLException {
        Map map = new HashMap();
        Revenue revenue = new Revenue();
        Date date = startDate;
        int index = 0;
        int count = 0;
        while (!date.after(endDate)) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            cal.add(Calendar.DATE, 1);
            if (index >= offset && count < limit) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String sql = "select sum(price) as price from orders join order_details on id = order_id where order_date >= ? AND order_date <= ?";
                Connection con = DBContext.getConnection();
                PreparedStatement stm = con.prepareStatement(sql);
                String from = sdf.format(date);
                String to = sdf.format(cal.getTime());
                stm.setString(1, from);
                stm.setString(2, to);
                ResultSet rs = stm.executeQuery();
                if (rs.next()) {
                    double price = rs.getDouble("price");
                    Item item = new Item(date, price);
                    revenue.add(item);
                }
                con.close();
                count++;
            }
            date = cal.getTime();
            index++;
        }
        map.put("revenue", revenue);
        map.put("total", index);
        return map;
    }
}
