/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.cart.Cart;
import models.cart.Item;
import models.product.Product;
import models.product.ProductFacade;

/**
 *
 * @author daing
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

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
        String action = (String) request.getAttribute("action");
        switch (action) {
            case "index": {
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                double total = cart.getTotal();
                request.setAttribute("total", total);
                request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                break;
            }
            case "delete": {
                int id = Integer.parseInt(request.getParameter("id"));
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                cart.remove(id);
                response.sendRedirect(request.getContextPath() + "/cart/index.do");
                break;
            }
            case "empty": {
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                cart.empty();
                response.sendRedirect(request.getContextPath() + "/cart/index.do");
                break;
            }
            case "checkout": {
                HttpSession session = request.getSession();
                ServletContext context = request.getServletContext();
                Cart cart = (Cart) session.getAttribute("cart");
                if ((session.getAttribute("account") != null || context.getAttribute("account") != null) && !cart.getItems().isEmpty()) {
                    double total = cart.getTotal();
                    request.setAttribute("total", total);
                    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/authentication/login.do");
                }
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
        processRequest(request, response);
        String action = (String) request.getAttribute("action");
        ProductFacade productFacade = new ProductFacade();
        switch (action) {
            case "add": {
                int id = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter(String.format("quant[%d]", id)));
                String fromPage = request.getParameter("page");
                try {
                    Product product = productFacade.getProductById(id);
                    Item item = new Item(product, quantity);
                    HttpSession session = request.getSession();
                    Cart cart = (Cart) session.getAttribute("cart");
                    cart.add(item);
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
                response.sendRedirect(request.getContextPath() + fromPage);
                break;
            }
            case "update": {
                int id = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                if (quantity == 0) {
                    cart.remove(id);
                } else {
                    cart.update(id, quantity);
                }
                response.sendRedirect(request.getContextPath() + "/cart/index.do");
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
