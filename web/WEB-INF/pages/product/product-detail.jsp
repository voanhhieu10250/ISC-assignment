<%-- 
    Document   : single-product
    Created on : Mar 3, 2023, 10:30:02 PM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<c:if test="${addToCartStatus == 'success'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Successfully add product to cart</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>
<c:if test="${addToCartStatus == 'fail'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Fail add product to cart</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>
<!-- single product header area -->
<div>
    <div id="single_product" class="single_product_page animate__animated animate__fadeInUp">
        <div class="sp_header bg-white p-3">
            <div class="container custom_container">
                <div class="row">
                    <div class="col-12">
                        <ul>
                            <li class="d-inline-block font-weight-bolder"><a href="<c:url value="/home/index.do"/>">home</a></li>
                            <li class="d-inline-block hr_ font-weight-bolder"><a href="#">plant</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- single product header area -->
        <!-- single product img and detail -->

        <div class="container sp_pro_container pt-2">
            <div class="row sh_page bg-white rounded border py-2">
                <div class="col-xl-4 col-lg-6 col-md-6 col-12 sp_left_product px-2">
                    <div id="content" class="page-content">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12 sp_zoom_pro mb-5">
                                <img id="zoom_03" src="<c:url value="${product.imagePath}"/>" class="rounded img-fluid js-product-cover" data-zoom-image="<c:url value="${product.imagePath}"/>"/>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12 sp_muti_pro">
                                <div id="gallery_02" class="row owl-carousel owl-theme">
                                    <div class="col-12 px-1">
                                        <a class="elevatezoom-gallery" data-image="<c:url value="${product.imagePath}"/>" data-zoom-image="<c:url value="${product.imagePath}"/>">
                                            <img src="<c:url value="${product.imagePath}"/>" class="border rounded img-fluid" width="100"/></a>
                                    </div>
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-8 col-lg-6 col-md-6 col-12 sp_right_product pl-lg-3 pl-2 pr-2">
                    <div class="sp_ri_leftpart">
                        <div class="sp_product_detail">
                            <h1 class="">${product.name}</h1>
                            <span class="sp_price font-weight-bold"><fmt:formatNumber type="currency" value="${product.price}" currencySymbol="$" /></span>
                            <div class="text-secondary sp_tax">Tax included.</div>
                            <div class="sp_add_info my-3">
                                <ul>
                                    <li class="availability my-2">
                                        <span class="font-weight-bolder tags-title">Availability:</span>
                                        <span class="p_quantity">${product.quantity}</span>
                                        <span>in stock</span>
                                    </li>
                                    <li class="my-2">
                                        <span class="font-weight-bolder tags-title">category: ${category.name}</span>
                                    </li>
                                </ul>
                            </div>
                            <form id="add_to_cart-form" action="<c:url value="/cart/add.do"/>" method="post">
                                <div class="sp_c_count1">
                                    <div class="number">
                                        <div class="sp_counter ">
                                            <div class="input-group">
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default btn-number p-0" disabled="disabled" data-type="minus" data-field="quant[${product.id}]"><span class="minus">-</span></button>
                                                </span>
                                                <input type="number" name="id" value="${product.id}" hidden/>
                                                <c:if test="${addedItem != null}">
                                                    <c:if test="${(product.quantity - addedItem.quantity) > 0}">
                                                        <input type="number" name="quant[${product.id}]" class="form-control input-number" value="1" min="1" max="${product.quantity - addedItem.quantity}"/>
                                                    </c:if>
                                                    <c:if test="${(product.quantity - addedItem.quantity) <= 0}">
                                                        <input type="number" name="quant[${product.id}]" class="form-control input-number" value="0" min="0" max="0"/>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${addedItem == null}">
                                                    <input type="number" name="quant[${product.id}]" class="form-control input-number" value="1" min="1" max="${product.quantity}"/>
                                                </c:if>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default btn-number p-0" data-type="plus" data-field="quant[${product.id}]"><span class="plus">+</span></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn btn-primary primary" name="page" value="/product/product-detail.do?id=${product.id}">
                                    add to cart
                                </button> 
                            </form>
                        </div>
                        <!--                    <div class="sp_buy mt-3">
                                                <button type="button" class="btn btn-primary primary">buy it now</button>
                                            </div>-->
                        <div class="sp_collapse_block my-4">
                            <div class="accordion" id="collapse_block">
                                <div class="card">
                                    <div class="card-header" id="heading_One">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link btn-block text-left tags-title" type="button" data-toggle="collapse" data-target="#collapse_One" aria-expanded="true" aria-controls="collapse_One">
                                                DESCRIPTION<span class="float-right"><i class="fas fa-angle-down"></i></span>
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="collapse_One" class="collapse show" aria-labelledby="heading_One" data-parent="#collapse_block">
                                        <div class="card-body">
                                            ${product.description}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- single product img and detail -->
    <!-- related product -->
    <div class="container custom_container t_pro_container fadeInUp">
        <div class="row">
            <div class="col-12">
                <div class="title_outer">
                    <h5 class="font-weight-bolder mb-4 d-inline-block">related products</h5>
                </div>
                <!-- title_outer -->
            </div>
            <!-- col-12 -->
        </div>
        <!-- row -->
        <div class="row">
            <div id="related_product_carousel" class="srelated_product_carousel owl-carousel owl-theme pro_thumb">
                <c:forEach var="relatedProduct" items="${products}">
                    <div class="item">
                        <div class="col-12">
                            <div class="product_thumb bg-white rounded">
                                <div class="pro_image">
                                    <a href="<c:url value="/product/product-detail.do?id=${relatedProduct.id}"/>">
                                        <img src="<c:url value="${relatedProduct.imagePath}"/>"
                                             class="fst-image mx-auto d-block img-fluid" alt="product_1"
                                             />
                                    </a>
                                </div>
                                <div class="text-center">
                                    <div class="main_text">
                                        <h2 class="text-center pro-heading my-2">
                                            <a href="<c:url value="/product/product-detail.do?id=${relatedProduct.id}"/>" class="font-weight-bolder">
                                                ${relatedProduct.name}
                                            </a>
                                        </h2>
                                        <span class="text-center prices font-weight-bolder price"><fmt:formatNumber type="currency" value="${product.price}" currencySymbol="$" /></span>
                                        <c:if test="${relatedProduct.quantity > 0}">
                                            <form action="<c:url value="/cart/add.do"/>" method="post">
                                                <input type="number" value="${relatedProduct.id}" name="id" hidden/>
                                                <input hidden type="number" name="quant[${relatedProduct.id}]" class="form-control input-number" value="1" min="0" max="${relatedProduct.quantity}"/>
                                                <button style="border: none" class="symbol add_to_cart" data-toggle="modal" name="page" value="/product/product-detail.do?id=${product.id}"
                                                        data-target="#cart_model">
                                                    + ADD TO CART
                                                </button>
                                            </form> 
                                        </c:if>
                                        <c:if test="${relatedProduct.quantity == 0}">
                                            <button style="border: none" class="symbol add_to_cart" data-toggle="modal"
                                                    data-target="#cart_model">
                                                Cannot add more to cart
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <!-- item --> 
            </div>
            <!-- product_carousel2 -->
        </div>
    </div>
</div>
<!-- related product end -->
<!-- single_product_page -->

