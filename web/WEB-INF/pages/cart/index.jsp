<%-- 
    Document   : cart
    Created on : Mar 8, 2023, 8:16:17 PM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<!-- cart page -->
<div id="cart_page" class="cart-page animate__animated animate__fadeInUp">
    <div class="sp_header bg-white p-2 ">
        <div class="container custom_container ">
            <div class="row ">
                <div class="col-12 ">
                    <ul class="p-md-3 p-2 bg-light">
                        <li class="d-inline-block font-weight-bolderer"><a href="<c:url value="/home/index.do"/>">home</a></li>
                        <li class="d-inline-block  font-weight-bolderer"><a href="#" class="hr_">Cart</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container custom_container ">
        <div class="row">
            <div class="col-12">
                <div class="title_outer">
                    <h1 class="mb-3 d-inline-block pb-3 position-relative border-bottom h1_">Cart</h1>
                </div>
                <!-- title_outer -->
            </div>
            <!-- col-12 -->
        </div>
        <!-- row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header cart_header bg-white">
                        <div class="card-title mb-0">
                            <div class="row d-flex justify-content-between align-items-center">
                                <div class="col-6">
                                    <h5 class="mb-0"><i class="fas fa-shopping-cart"></i>&nbsp;&nbsp;Shopping Cart</h5>
                                </div>
                                <div class="col-6 col-sm-3 checkout-btn mt-2">
                                    <a class="btn btn-block f_13 font-weight-bolder" href="<c:url value="/cart/empty.do?id=${item.product.id}"/>">Empty cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body cart_body">
                        <c:forEach var="item" items="${cart.items}">
                            <div class="row mb-4">
                                <div class="col-12 col-md-6 pr-0">
                                    <div class="d-flex">
                                        <div class=" col-xl-4 col-lg-5 col-md-4 col-4 px-0">
                                            <a href="<c:url value="/product/product-detail.do?id=${item.product.id}"/>">
                                                <img src="<c:url value="${item.product.imagePath}"/>"
                                                     class="fst-image mx-auto d-block img-fluid" alt="product_13"/>
                                            </a>
                                        </div>
                                        <div class=" col-xl-8 col-lg-7 col-md-8 col-8 pr-0">
                                            <h4 class="product-name font-weight-bolder mb-2 mb-sm-3 mb-xl-3 mt-sm-2 mt-md-2">
                                                <a href="<c:url value="/product/product-detail.do?id=${item.product.id}"/>">${item.product.name}</a>
                                            </h4>
                                            <span class="sp_price font-weight-bold"><fmt:formatNumber type="currency" value="${item.product.price}" currencySymbol="$" /></span>
                                            <div class="text-secondary sp_tax">Tax included.</div>
                                            <div class="sp_add_info my-3">
                                                <ul>
                                                    <li class="availability my-2">
                                                        <span class="font-weight-bolder tags-title">Availability:</span>
                                                        <span class="p_quantity">${item.product.quantity}</span>
                                                        <span>in stock</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6 mt-4">
                                    <div class="d-flex">
                                        <div class="col-md-3 col-sm-4 col-5 text-left text-md-right my-2 ">
                                            <span class="font-weight-bolder"><fmt:formatNumber type="currency" value="${item.cost}" currencySymbol="$" /></span>
                                        </div>
                                        <div class="col-md-9 col-sm-4 col-5">
                                            <form id="update_cart-form-${item.product.id}" action="<c:url value="/cart/update.do"/>" method="post">
                                                <input type="number" value="${item.product.id}" name="id" hidden/>
                                                <input type="number" class="form-control input-number border" placeholder="0" name="quantity" value="${item.quantity}" min="0" max="${item.product.quantity}"/>
                                                <div class="row">
                                                    <div class="col-6 col-sm-6 checkout-btn mt-2 update_cart-btn">
                                                        <a id="${item.product.id}" class="btn btn-block f_13 font-weight-bolder">Update</a>
                                                    </div>
                                                    <div class="col-6 col-sm-6 checkout-btn mt-2">
                                                        <a id="${item.product.id}" class="btn btn-block f_13 font-weight-bolder" href="<c:url value="/cart/delete.do?id=${item.product.id}"/>">Delete</a>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${cartSize != null}">
                            <div class="card-footer">
                                <div class="row">
                                    <div class="col-6 col-sm-7 text-right">
                                        <div class="my-2 font-weight-bolder">
                                            <span>total:</span>
                                            <span><fmt:formatNumber type="currency" value="${total}" currencySymbol="$" /></span>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-5 checkout-btn">
                                        <a href="<c:url value="/cart/checkout.do"/>" class="btn btn-block f_13 font-weight-bolder">Continue</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <c:if test="${cartSize == null}">
                        <p class="text-center">Your Shopping cart is empty!</p>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value="/assets/js/cart/index.js"/>"></script>
