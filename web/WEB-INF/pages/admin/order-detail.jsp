<%-- 
    Document   : invoice-detail
    Created on : Mar 16, 2023, 12:37:59 AM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<!-- content -->
<div class="content ">
    <div class="d-flex gap-3 mb-4 d-print-none">
        <button onclick="javascript:window.print()" class="btn btn-outline-secondary d-none d-md-block btn-icon">
            <i class="bi bi-printer"></i> Print
        </button>
    </div>
    <div class="card">
        <div class="card-body">
            <div class="invoice">
                <div class="d-md-flex justify-content-between align-items-center mb-4">
                    <div>Order ID : ${order.id}</div>
                    <div>Date: <fmt:formatDate type = "date" value = "${order.orderDate}" /></div>
                </div>
                <div class="d-md-flex justify-content-between align-items-center">
                    <h4>Order</h4>
                </div>
                <hr class="my-4">
                <div class="row">
                    <p>
                        <strong>Delivery to</strong>
                    </p>
                    <p>${order.address}</p>
                </div>
                <div class="table-responsive">
                    <table class="table mb-4 mt-4">
                        <thead class="thead-light">
                            <tr>
                                <th>No</th>
                                <th>Product name</th>
                                <th class="text-end">Price</th>
                                <th class="text-end">Quantity</th>
                                <th class="text-end">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="orderDetail" items="${orderDetails}" varStatus="loop">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>${productMap.get(orderDetail.productId).name}</td>
                                    <td class="text-end"><fmt:formatNumber type="currency" value="${productMap.get(orderDetail.productId).price}" currencySymbol="$" /></td>
                                    <td class="text-end">${orderDetail.quantity}</td>
                                    <td class="text-end"><fmt:formatNumber type="currency" value="${orderDetail.price}" currencySymbol="$" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="text-end">
                    <p>Shipping: Free</p>
                    <h4 class="fw-bold"><fmt:formatNumber type="currency" value="${total}" currencySymbol="$" /></h4>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- ./ content -->
