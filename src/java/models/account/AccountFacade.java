/*
 * To change this license header, choose License Headeresult in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.account;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.DBContext;
import models.utils.Hasher;

/**
 *
 * @author daing
 */
public class AccountFacade {

    public Account login(String email, String password) throws Exception {
        Account account = selectByEmail(email);
        String hashPassword = Hasher.hash(password);
        if (account != null && hashPassword.equals(account.getPassword())) {
            return account;
        } else {
            if (account == null) {
                throw new Exception("Invalid email");
            } else {
                throw new Exception("Wrong password");
            }
        }
    }

    public Account register(Account account) throws Exception {
        Account existAccount = selectByEmail(account.getEmail());
        if (existAccount == null) {
            insert(account);
            account = login(account.getEmail(), account.getPassword());
            return account;
        } else {
            throw new Exception("Email was registered");
        }
    }

    public List<Account> selectAll() throws SQLException {
        String sql = "select * from accounts";
        Connection con = DBContext.getConnection();
        Statement stm = con.createStatement();
        ResultSet result = stm.executeQuery(sql);
        List<Account> accounts = new ArrayList();
        while (result.next()) {
            Account account = new Account();
            account.setId(result.getInt("id"));
            account.setEmail(result.getString("email"));
            account.setName(result.getString("name"));
            account.setPassword(result.getString("password"));
            account.setPhone(result.getString("phone"));
            account.setRole(result.getInt("role"));
            accounts.add(account);
        }
        con.close();
        return accounts;
    }

    public Account selectByEmail(String email) throws SQLException {
        Connection con = DBContext.getConnection();
        String sql = "select * from accounts where email = ?";
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        preparedStatement.setString(1, email);
        ResultSet result = preparedStatement.executeQuery();
        Account account = new Account();
        if (result.next()) {
            account.setId(result.getInt("id"));
            account.setEmail(result.getString("email"));
            account.setName(result.getString("name"));
            account.setPassword(result.getString("password"));
            account.setPhone(result.getString("phone"));
            account.setRole(result.getInt("role"));
        } else {
            account = null;
        }
        con.close();
        return account;
    }

    public int insert(Account account) throws SQLException, NoSuchAlgorithmException {
        Connection con = DBContext.getConnection();
        String sql = "INSERT INTO accounts(email, password, name, phone, role)\n"
                + "VALUES(?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = con.prepareStatement(sql);
        preparedStatement.setString(1, account.getEmail());
        preparedStatement.setString(2, Hasher.hash(account.getPassword()));
        preparedStatement.setString(3, account.getName());
        preparedStatement.setString(4, account.getPhone());
        preparedStatement.setInt(5, account.getRole());
        int count = preparedStatement.executeUpdate();
        con.close();
        return count;
    }
}
