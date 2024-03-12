/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import models.DBContext;

/**
 *
 * @author daing
 */
public class ProductFacade {

    private Product getProductFromRs(ResultSet result) throws SQLException {
        int id = result.getInt("id");
        String name = result.getString("name");
        double price = result.getDouble("price");
        int quantity = result.getInt("quantity");
        String imagePath = result.getString("image_path");
        String description = result.getString("description");
        Date createdAt = result.getDate("created_at");
        Date updatedAt = result.getDate("updated_at");
        int categoryId = result.getInt("category_id");
        Product product = new Product(id, name, price, quantity, imagePath, description, createdAt, updatedAt, categoryId);
        return product;
    }

    public int insert(Product product) throws SQLException {
        Connection con = DBContext.getConnection();
        String sql = "INSERT INTO products(name, price, quantity, image_path, description, category_id)\n"
                + "VALUES(?, ?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        preparedStatement.setString(1, product.getName());
        preparedStatement.setDouble(2, product.getPrice());
        preparedStatement.setInt(3, product.getQuantity());
        preparedStatement.setString(4, product.getImagePath());
        preparedStatement.setString(5, product.getDescription());
        preparedStatement.setInt(6, product.getCategoryId());
        int result = preparedStatement.executeUpdate();
        con.close();
        return result;
    }

    public HashMap<String, Object> getProducts(String orderBy, String orderType, int offset, int fetch) throws SQLException {
        HashMap<String, Object> map = new HashMap<>();
        ArrayList<Product> list = new ArrayList<>();
        int total = 0;
        String productsSql = "SELECT * FROM products ORDER BY %s %s OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
        String countSql = "SELECT COUNT(*) as total FROM products";
        productsSql = String.format(productsSql, orderBy, orderType);

        Connection con = DBContext.getConnection();
        PreparedStatement preparedStatement = con.prepareStatement(productsSql);
        preparedStatement.setInt(1, offset);
        preparedStatement.setInt(2, fetch);
        ResultSet result = preparedStatement.executeQuery();
        while (result.next()) {
            Product product = getProductFromRs(result);
            list.add(product);
        }

        countSql = String.format(countSql);
        Statement statement = con.createStatement();
        result = statement.executeQuery(countSql);
        if (result.next()) {
            total = result.getInt("total");
        }
        con.close();
        map.put("products", list);
        map.put("total", total);
        return map;
    }

    public HashMap<String, Object> getProducts(String orderBy, String orderType, int offset, int fetch, String search) throws SQLException {
        HashMap<String, Object> map = new HashMap<>();
        ArrayList<Product> list = new ArrayList<>();
        int total = 0;
        String productsSql = "SELECT * FROM products WHERE name LIKE ? ORDER BY %s %s OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
        String countSql = "SELECT COUNT(*) as total FROM products WHERE name LIKE ?";
        productsSql = String.format(productsSql, orderBy, orderType);

        Connection con = DBContext.getConnection();
        PreparedStatement preparedStatement = con.prepareStatement(productsSql);
        preparedStatement.setString(1, "%" + search.trim() + "%");
        preparedStatement.setInt(2, offset);
        preparedStatement.setInt(3, fetch);
        ResultSet result = preparedStatement.executeQuery();
        while (result.next()) {
            Product product = getProductFromRs(result);
            list.add(product);
        }

        countSql = String.format(countSql);
        preparedStatement = con.prepareStatement(countSql);
        preparedStatement.setString(1, "%" + search.trim() + "%");
        result = preparedStatement.executeQuery();
        if (result.next()) {
            total = result.getInt("total");
        }
        con.close();
        map.put("products", list);
        map.put("total", total);
        return map;
    }

    public HashMap<String, Object> getProducts(String orderBy, String orderType, int offset, int fetch, String search, ArrayList categoriesList) throws SQLException {
        HashMap<String, Object> map = new HashMap<>();
        ArrayList<Product> list = new ArrayList<>();
        int total = 0;
        String productsSql = "SELECT * FROM products WHERE name LIKE ? AND category_id in (%s) ORDER BY %s %s OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
        String countSql = "SELECT COUNT(*) as total FROM products WHERE name LIKE ? AND category_id in (%s)";
        String categories = categoriesList.toString();
        productsSql = String.format(productsSql, categories.substring(1, categories.length() - 1), orderBy, orderType);

        Connection con = DBContext.getConnection();
        PreparedStatement preparedStatement = con.prepareStatement(productsSql);
        preparedStatement.setString(1, "%" + search.trim() + "%");
        preparedStatement.setInt(2, offset);
        preparedStatement.setInt(3, fetch);
        ResultSet result = preparedStatement.executeQuery();
        while (result.next()) {
            Product product = getProductFromRs(result);
            list.add(product);
        }

        countSql = String.format(countSql, categories.substring(1, categories.length() - 1));
        preparedStatement = con.prepareStatement(countSql);
        preparedStatement.setString(1, "%" + search.trim() + "%");
        result = preparedStatement.executeQuery();
        if (result.next()) {
            total = result.getInt("total");
        }
        con.close();
        map.put("products", list);
        map.put("total", total);
        return map;
    }

    public HashMap<String, Object> getProducts(int minQuantity, String orderBy, String orderType, int offset, int fetch, String search) throws SQLException {
        HashMap<String, Object> map = new HashMap<>();
        ArrayList<Product> list = new ArrayList<>();
        int total = 0;
        String productsSql = "SELECT * FROM products WHERE quantity >= ? AND name LIKE ? ORDER BY %s %s OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
        String countSql = "SELECT COUNT(*) as total FROM products WHERE quantity >= ? AND name LIKE ?";
        productsSql = String.format(productsSql, orderBy, orderType);

        Connection con = DBContext.getConnection();
        PreparedStatement preparedStatement = con.prepareStatement(productsSql);
        preparedStatement.setInt(1, minQuantity);
        preparedStatement.setString(2, "%" + search.trim() + "%");
        preparedStatement.setInt(3, offset);
        preparedStatement.setInt(4, fetch);
        ResultSet result = preparedStatement.executeQuery();
        while (result.next()) {
            Product product = getProductFromRs(result);
            list.add(product);
        }

        preparedStatement = con.prepareStatement(countSql);
        preparedStatement.setInt(1, minQuantity);
        preparedStatement.setString(2, "%" + search.trim() + "%");
        result = preparedStatement.executeQuery();
        if (result.next()) {
            total = result.getInt("total");
        }
        con.close();
        map.put("products", list);
        map.put("total", total);
        return map;
    }

    public HashMap<String, Object> getProducts(int minQuantity, String orderBy, String orderType, int offset, int fetch, String search, ArrayList categoriesList) throws SQLException {
        HashMap<String, Object> map = new HashMap<>();
        ArrayList<Product> list = new ArrayList<>();
        int total = 0;
        String productsSql = "SELECT * FROM products WHERE quantity >= ? AND name LIKE ? AND category_id in (%s) ORDER BY %s %s OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
        String countSql = "SELECT COUNT(*) as total FROM products WHERE quantity >= ? AND name LIKE ? AND category_id in (%s)";
        String categories = categoriesList.toString();
        productsSql = String.format(productsSql, categories.substring(1, categories.length() - 1), orderBy, orderType);

        Connection con = DBContext.getConnection();
        PreparedStatement preparedStatement = con.prepareStatement(productsSql);
        preparedStatement.setInt(1, minQuantity);
        preparedStatement.setString(2, "%" + search.trim() + "%");
        preparedStatement.setInt(3, offset);
        preparedStatement.setInt(4, fetch);
        ResultSet result = preparedStatement.executeQuery();
        while (result.next()) {
            Product product = getProductFromRs(result);
            list.add(product);
        }

        countSql = String.format(countSql, categories.substring(1, categories.length() - 1));
        preparedStatement = con.prepareStatement(countSql);
        preparedStatement.setInt(1, minQuantity);
        preparedStatement.setString(2, "%" + search.trim() + "%");
        result = preparedStatement.executeQuery();
        if (result.next()) {
            total = result.getInt("total");
        }
        con.close();
        map.put("products", list);
        map.put("total", total);
        return map;
    }

    public Product getProductById(int id) throws SQLException {
        Connection cn = DBContext.getConnection();
        Product product = null;
        String sql = "SELECT *\n"
                + "FROM products\n"
                + "WHERE products.id = ?";
        PreparedStatement pst = cn.prepareStatement(sql);
        pst.setInt(1, id);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            product = getProductFromRs(rs);
        }
        cn.close();
        return product;
    }

    public ArrayList<Product> getRelatedProducts(int id, int categoryId) throws SQLException {
        Connection cn = DBContext.getConnection();
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE products.id != ? AND products.category_id = ?";
        PreparedStatement pst = cn.prepareStatement(sql);
        pst.setInt(1, id);
        pst.setInt(2, categoryId);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Product product = getProductFromRs(rs);
            list.add(product);
        }
        cn.close();
        return list;
    }

    //delete product by id
    public int delete(int id) throws SQLException {
        int result = 0;
        Connection cn = DBContext.getConnection();
        if (cn != null) {
            String sql = "DELETE FROM products\n"
                    + "	WHERE id= ?;";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, id);
            result = pst.executeUpdate();
        }
        cn.close();
        return result;
    }

    //update product
    public int updateProduct(Product product) throws SQLException {
        int result = 0;
        Connection cn = DBContext.getConnection();
        if (cn != null) {
            String sql = "update dbo.products set  name = ?, price=?, quantity=?, image_path=?, description=?, updated_at = ?, category_id=? FROM products  where [id] = ?;";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, product.getName());
            pst.setDouble(2, product.getPrice());
            pst.setInt(3, product.getQuantity());
            pst.setString(4, product.getImagePath());
            pst.setString(5, product.getDescription());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            pst.setString(6, sdf.format(new Date().getTime()));
            pst.setInt(7, product.getCategoryId());
            pst.setInt(8, product.getId());
            result = pst.executeUpdate();
        }
        cn.close();
        return result;
    }

}
