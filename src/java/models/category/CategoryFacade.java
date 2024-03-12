/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import models.DBContext;

/**
 *
 * @author daing
 */
public class CategoryFacade {

    public ArrayList<Category> selectAll() throws SQLException {
        Connection con = DBContext.getConnection();
        String sql = "select * from categories";
        Statement statement = con.createStatement();
        ResultSet result = statement.executeQuery(sql);
        ArrayList<Category> list = new ArrayList<>();
        while (result.next()) {
            int id = result.getInt("id");
            String name = result.getString("name");
            Category category = new Category(id, name);
            list.add(category);
        }
        con.close();
        return list;
    }

    public Category getCategoryById(int id) throws SQLException {
        Connection con = DBContext.getConnection();
        String sql = "select * from categories where id = ?";
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            String name = rs.getString("name");
            Category category = new Category(id, name);
            con.close();
            return category;
        }
        con.close();
        return null;
    }
}
