package controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.account.Account;
import models.account.AccountFacade;
import models.cart.Cart;
import models.cart.Item;
import models.category.Category;
import models.category.CategoryFacade;
import models.order.Order;
import models.order.OrderFacade;
import models.order_detail.OrderDetail;
import models.order_detail.OrderDetailFacade;
import models.product.Product;
import models.product.ProductFacade;
import models.revenue.Revenue;
import models.revenue.RevenueFacade;

/**
 *
 * @author daing
 */
@WebServlet(urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

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
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null || account.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/home/index.do");
        } else {
            switch (action) {
                case "index": {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");
                    int offset = Integer.parseInt(request.getParameter("offset") != null ? request.getParameter("offset") : "0");
                    int limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "10");
                    if (startDate == null) {
                        startDate = sdf.format(new Date().getTime());
                    }
                    if (endDate == null) {
                        endDate = sdf.format(new Date().getTime());
                    }
                    RevenueFacade revenueFacade = new RevenueFacade();
                    try {
                        Map map = revenueFacade.getRevenue(sdf.parse(startDate), sdf.parse(endDate), offset, limit);
                        Revenue revenue = (Revenue) map.get("revenue");
                        request.setAttribute("revenue", revenue.getList());
                        request.setAttribute("startDate", startDate);
                        request.setAttribute("endDate", endDate);
                        int totalItem = (int) map.get("total");
                        int totalPage = (int) Math.ceil(totalItem * 1.0 / limit);
                        int currentPage = (offset / limit) + 1;
                        request.setAttribute("pageSize", limit);
                        request.setAttribute("totalPage", totalPage);
                        request.setAttribute("currentPage", currentPage);
                        request.getRequestDispatcher(Config.ADMIN_LAYOUT).forward(request, response);
                    } catch (ParseException | SQLException ex) {
                        log(ex.getMessage());
                    }

                    break;
                }
                case "products": {
                    ProductFacade productFacade = new ProductFacade();
                    ArrayList<Integer> checkedCategories = new ArrayList<>();
                    CategoryFacade categoryFacade = new CategoryFacade();
                    Map<String, String> orders = new LinkedHashMap<>();
                    orders.put("updated_at-desc", "Latest");
                    orders.put("name-asc", "Name, A to Z");
                    orders.put("name-desc", "Name, Z to A");
                    orders.put("price-asc", "Price, low to high");
                    orders.put("price-desc", "Price, high to low");
                    Cart cart = (Cart) session.getAttribute("cart");

                    int offset = Integer.parseInt(request.getParameter("offset") != null ? request.getParameter("offset") : "0");
                    int limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "6");
                    String search = request.getParameter("search") != null ? request.getParameter("search") : "";
                    String[] categoriesFilter = request.getParameterValues("categories");
                    String selectedOrder = request.getParameter("order") != null && orders.containsKey(request.getParameter("order")) ? request.getParameter("order") : "updated_at-desc";
                    String orderBy = selectedOrder.substring(0, selectedOrder.indexOf("-"));
                    String orderType = selectedOrder.substring(selectedOrder.indexOf("-") + 1, selectedOrder.length());
                    if (categoriesFilter != null) {
                        for (String category : categoriesFilter) {
                            checkedCategories.add(Integer.parseInt(category));
                        }
                    }

                    try {
                        ArrayList<Category> categories = categoryFacade.selectAll();
                        HashMap<String, Object> productsMap;
                        if (checkedCategories.isEmpty()) {
                            productsMap = productFacade.getProducts(orderBy, orderType, offset, limit, search);
                        } else {
                            productsMap = productFacade.getProducts(orderBy, orderType, offset, limit, search, checkedCategories);
                        }
                        ArrayList<Product> products = (ArrayList<Product>) productsMap.get("products");
                        Map<Integer, String> categoryMap = new HashMap();
                        for (Category category : categories) {
                            categoryMap.put(category.getId(), category.getName());
                        }
                        for (Product product : products) {
                            Item addedItem = cart.getItem(product.getId());
                            if (addedItem != null) {
                                product.setQuantity(product.getQuantity() - addedItem.getQuantity());
                            }
                        }
                        int totalProduct = (int) productsMap.get("total");
                        int totalPage = (int) Math.ceil(totalProduct * 1.0 / limit);
                        int currentPage = (offset / limit) + 1;
                        request.setAttribute("products", products);
                        request.setAttribute("pageSize", limit);
                        request.setAttribute("totalPage", totalPage);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("search", search);
                        request.setAttribute("categories", categories);
                        request.setAttribute("categoryMap", categoryMap);
                        request.setAttribute("checkedCategories", checkedCategories);
                        request.setAttribute("orders", orders);
                        request.setAttribute("selectedOrder", selectedOrder);
                        request.getRequestDispatcher(Config.ADMIN_LAYOUT).forward(request, response);
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    break;
                }
                case "create-product": {
                    CategoryFacade categoryFacade = new CategoryFacade();
                    try {
                        ArrayList<Category> categories = categoryFacade.selectAll();
                        request.setAttribute("categories", categories);
                        request.getRequestDispatcher(Config.ADMIN_LAYOUT).forward(request, response);
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    break;
                }
                case "edit-product": {
                    CategoryFacade categoryFacade = new CategoryFacade();
                    ProductFacade productFacade = new ProductFacade();
                    int id = Integer.parseInt(request.getParameter("id"));
                    try {
                        ArrayList<Category> categories = categoryFacade.selectAll();
                        Product product = productFacade.getProductById(id);
                        request.setAttribute("categories", categories);
                        request.setAttribute("product", product);
                        request.getRequestDispatcher(Config.ADMIN_LAYOUT).forward(request, response);
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    break;
                }
                case "delete-product": {
                    ProductFacade productFacade = new ProductFacade();
                    int id = Integer.parseInt(request.getParameter("id"));
                    try {
                        productFacade.delete(id);
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/products.do");
                    break;
                }
                case "orders": {
                    OrderFacade orderFacade = new OrderFacade();
                    AccountFacade accountFacade = new AccountFacade();

                    int offset = Integer.parseInt(request.getParameter("offset") != null ? request.getParameter("offset") : "0");
                    int limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "6");

                    try {
                        Map map = orderFacade.getOrders(offset, limit);
                        List<Account> accounts = accountFacade.selectAll();
                        ArrayList<Product> orders = (ArrayList<Product>) map.get("orders");
                        Map<Integer, String> accountMap = new HashMap();
                        for (Account acc : accounts) {
                            accountMap.put(acc.getId(), acc.getName());
                        }

                        int totalOrder = (int) map.get("total");
                        int totalPage = (int) Math.ceil(totalOrder * 1.0 / limit);
                        int currentPage = (offset / limit) + 1;
                        request.setAttribute("orders", orders);
                        request.setAttribute("pageSize", limit);
                        request.setAttribute("totalPage", totalPage);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("accountMap", accountMap);
                        request.getRequestDispatcher(Config.ADMIN_LAYOUT).forward(request, response);
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    break;
                }
                case "order-detail": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    OrderFacade orderFacade = new OrderFacade();
                    OrderDetailFacade orderDetaiFa = new OrderDetailFacade();
                    ProductFacade productFacade = new ProductFacade();
                    try {
                        Map<Integer, Object> productMap = new HashMap();
                        double total = 0;
                        Order order = orderFacade.getOrderById(id);
                        List<OrderDetail> orderDetails = orderDetaiFa.getOrderDetailsByOrderId(id);
                        for (OrderDetail orderDetail : orderDetails) {
                            Product product = productFacade.getProductById(id);
                            productMap.put(orderDetail.getProductId(), product);
                            total += orderDetail.getPrice();
                        }
                        request.setAttribute("order", order);
                        request.setAttribute("orderDetails", orderDetails);
                        request.setAttribute("productMap", productMap);
                        request.setAttribute("total", total);
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    request.getRequestDispatcher(Config.ADMIN_LAYOUT).forward(request, response);
                    break;
                }
            }
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
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null || account.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/home/index.do");
        } else {
            switch (action) {
                case "create-product": {
                    String name = request.getParameter("name");
                    Double price = Double.parseDouble(request.getParameter("price"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int categoryId = Integer.parseInt(request.getParameter("category"));
                    String description = request.getParameter("description");
                    String imagePath = "/assets/images/product/new_product.webp";

                    ProductFacade productFacade = new ProductFacade();
                    Product product = new Product(name, price, quantity, imagePath, description, categoryId);
                    try {
                        productFacade.insert(product);
                        response.sendRedirect(request.getContextPath() + "/admin/products.do");
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    break;
                }
                case "edit-product": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("name");
                    Double price = Double.parseDouble(request.getParameter("price"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int categoryId = Integer.parseInt(request.getParameter("category"));
                    String description = request.getParameter("description");
                    String imagePath = "/assets/images/product/new_product.webp";

                    ProductFacade productFacade = new ProductFacade();
                    Product product = new Product(id, name, price, quantity, imagePath, description, categoryId);
                    try {
                        productFacade.updateProduct(product);
                        response.sendRedirect(request.getContextPath() + "/admin/products.do");
                    } catch (SQLException ex) {
                        log(ex.getMessage());
                    }
                    break;
                }
            }
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
