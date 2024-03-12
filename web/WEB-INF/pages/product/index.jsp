<%-- 
    Document   : index.jsp
    Created on : Feb 26, 2023, 2:16:55 AM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<!-- Shop Page-->
<div id="shop_page" class="shop-page animate__animated animate__fadeInUp">
    <div class="sp_header bg-white p-3">
        <div class="container custom_container ">
            <div class="row ">
                <div class="col-12 ">
                    <ul>
                        <li class="d-inline-block font-weight-bolder"><a href="<c:url value="/home/index.do"/>">home</a></li>
                        <li class="d-inline-block hr_ font-weight-bolder"><a href="#">shop</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container custom_container">
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <form action="index.do" id="category-form" method="get" class="needs-validation shop_page-form" novalidate>
                    <div class="shop_sidebar border card-body rounded bg-white">
                        <h2 class="text-uppercase card-title  font-weight-bolder d-md-block d-none">filter by</h2>
                        <div class="s_filter">
                            <h6 class="text-uppercase border-bottom font-weight-bold">categories
                                <button type="button" class="toggle collapsed" data-toggle="collapse" data-target="#shop_size_collapse">        
                                </button>
                            </h6>
                            <div class="collapse" id="shop_size_collapse">
                                <c:forEach var="category" items="${categories}">
                                    <label class="form-check">
                                        <c:choose>
                                            <c:when test="${checkedCategories.contains(category.id)}">
                                                <input type="checkbox" name="categories" value="${category.id}" checked/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" name="categories" value="${category.id}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="form-check-label font-weight-bolder">${category.name}</span>
                                        <span class="text-right float-right font-weight-bolder"></span>
                                    </label>
                                </c:forEach>
                                <button id="submitButton" class="btn btn-primary" type="submit">
                                    filter
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-9 col-md-8">
                <form id="search-form" class="needs-validation shop_page-form input-group mb-3" novalidate>
                    <input type="search" name="search" placeholder="Enter product name" value="${search}" class="form-control rounded border" aria-label="Search" aria-describedby="search-addon"/>
                    <button type="submit" class="btn btn-primary">search</button>
                </form>
                <div class="row shop_grid_list_row mb-5 bg-white p-2 p-md-1 mb-lg-3 mx-0">
                    <div class="col-xl-2 col-sm-2 col-4 pl-0">
                        <a href="#" id="grid" class="btn">
                            <span class="grid_icon  p-1"><i class="fas fa-th"></i></span>
                        </a>
                        <a href="#" id="list" class="btn">
                            <span class="list_icon  p-1"><i class="fas fa-list"></i></span>
                        </a>
                    </div>
                    <div class="col-xl-4 d-xl-inline-block d-lg-none d-sm-none d-none">
                        <div class="show-product pt-1">There are ${totalProduct} products.</div>
                    </div>
                    <div class="col-xl-6 col-sm-10 col-8 pr-0 sortpro">
                        <div class="sort-by text-right">
                            <div class="sort">
                                <form id="order-form" class="needs-validation shop_page-form" novalidate>
                                    <select name="order" class="custom-select" id="order-selection">
                                        <c:forEach var="order" items="${orders}">
                                            <c:choose>
                                                <c:when test="${selectedOrder.equals(order.key)}">
                                                    <option value="${order.key}" selected>${order.value}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${order.key}">${order.value}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="products" class="row">
                    <c:forEach var="product" items="${products}">
                        <div class="item col-lg-4 col-md-6">
                            <div class="product_thumb bg-white rounded">
                                <div class="pro_image">
                                    <a href="<c:url value="/product/product-detail.do?id=${product.id}"/>"><img src="<c:url value="${product.imagePath}"/>" class="fst-image mx-auto d-block img-fluid" alt="product_7a"></a>
                                </div>
                                <div class="text-center main_text pt-3">
                                    <div>
                                        <div class="star mb-2">
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                        </div>
                                        <h2 class="pro-heading  font-weight-bolder mb-1	">
                                            <a href="<c:url value="/product/product-detail.do?id=${product.id}"/>">${product.name}</a>
                                        </h2>
                                        <span class="text-center prices"><fmt:formatNumber type="currency" value="${product.price}" currencySymbol="$" /></span>
                                        <p class="description mt-1 text-muted">${product.description}</p>
                                        <c:if test="${product.quantity > 0}">
                                            <form action="<c:url value="/cart/add.do"/>" method="post">
                                                <input type="number" value="${product.id}" name="id" hidden/>
                                                <input hidden type="number" name="quant[${product.id}]" class="form-control input-number" value="1" min="0" max="${product.quantity}"/>
                                                <button style="border: none" class="symbol add_to_cart" data-toggle="modal" name="page" value="/product/index.do"
                                                        data-target="#cart_model">
                                                    + ADD TO CART
                                                </button>
                                            </form> 
                                        </c:if>
                                        <c:if test="${product.quantity == 0}">
                                            <button style="border: none" class="symbol add_to_cart" data-toggle="modal"
                                                    data-target="#cart_model">
                                                Cannot add more to cart
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <div class="container custom_container">
        <div class="row">
            <div class="col-12">
                <c:if test="${totalPage != 0}">
                    <nav class="float-right mt-5 mt-col-3">
                        <ul class="pagination">
                            <c:forEach begin="0" end="${totalPage + 1}" step="1" var="pageNumber">
                                <c:choose>
                                    <c:when test="${pageNumber == 0}">
                                        <li class="page-item pagination-item page-link" value="1">
                                            &laquo;
                                        </li>
                                    </c:when>
                                    <c:when test="${pageNumber == totalPage + 1}">
                                        <li class="page-item pagination-item page-link" value="${totalPage}">
                                            &raquo;
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${currentPage == pageNumber}">
                                                <li class="page-item pagination-item page-link active" value="${pageNumber}">
                                                    ${pageNumber}
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item pagination-item page-link" value="${pageNumber}">
                                                    ${pageNumber}
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value="/assets/js/product/index.js"/>"></script>