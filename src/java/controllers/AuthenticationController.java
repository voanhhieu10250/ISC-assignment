/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.account.Account;
import models.account.AccountFacade;

/**
 *
 * @author daing
 */
@WebServlet(name = "Authentication", urlPatterns = {"/authentication"})
public class AuthenticationController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = (String) request.getAttribute("action");
        switch (action) {
            case "login": {
                ServletContext context = request.getServletContext();
                HttpSession session = request.getSession();
                if (session.getAttribute("account") != null || context.getAttribute("account") != null) {
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                } else {
                    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                }
                break;
            }
            case "register": {
                ServletContext context = request.getServletContext();
                HttpSession session = request.getSession();
                if (session.getAttribute("account") != null || context.getAttribute("account") != null) {
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                } else {
                    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                }
                break;
            }
            case "logout": {
                ServletContext context = request.getServletContext();
                HttpSession session = request.getSession();
                if (context.getAttribute("account") != null) {
                    context.removeAttribute("account");
                } else if (session.getAttribute("account") != null) {
                    session.removeAttribute("account");
                }
                response.sendRedirect(request.getContextPath() + "/home/index.do");
                break;
            }
            default:
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = (String) request.getAttribute("action");
        AccountFacade accountFacade = new AccountFacade();
        switch (action) {
            case "login": {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                try {
                    Account account = accountFacade.login(email, password);
                    String remember = request.getParameter("remember");
                    if (remember != null) {
                        ServletContext context = request.getServletContext();
                        context.setAttribute("account", account);
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("account", account);
                    }
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                } catch (SQLException | NoSuchAlgorithmException e) {
                    System.out.println(e.getMessage());
                    // Need to show the error 500 page
                } catch (Exception ex) {
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                }
                break;
            }
            case "register": {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                int role = 0;
                Account account = new Account(email, password, name, phone, role);
                try {
                    account = accountFacade.register(account);
                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
//                    show successfully register page
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                } catch (SQLException | NoSuchAlgorithmException ex) {
                    System.out.println(ex.getMessage());
                    // Need to show the error 500 page
                } catch (Exception ex) {
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                }
                break;
            }
            default:
            // need to show the error 404 page
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    } // </editor-fold>

}
