/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.account.Account;
import models.cart.Cart;
import models.order.Order;
import models.order.OrderFacade;

/**
 *
 * @author daing
 */
@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {

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
        processRequest(request, response);
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
        processRequest(request, response);
        String action = (String) request.getAttribute("action");
        OrderFacade orderFacade = new OrderFacade();
        switch (action) {
            case "create": {
                HttpSession session = request.getSession();
                ServletContext context = request.getServletContext();
                Cart cart = (Cart) session.getAttribute("cart");
                Account account = (Account) session.getAttribute("account");
                if (account == null) {
                    account = (Account) context.getAttribute("account");
                }
                if (account != null && !cart.getItems().isEmpty()) {
                    String address = request.getParameter("address");
                    int status = 1;
                    Order order = new Order(status, address, account.getId());
                    try {
                        orderFacade.createOrder(order, cart);
                        cart.empty();
                        session.setAttribute("cart", cart);
                        session.setAttribute("checkoutStatus", "success");
                    } catch (Exception ex) {
                        session.setAttribute("checkoutStatus", "fail");
                        System.out.println(ex.getMessage());
                    }
                    response.sendRedirect(request.getContextPath() + "/home/index.do");
                }
                break;
            }
            default:
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
    }// </editor-fold>

}
