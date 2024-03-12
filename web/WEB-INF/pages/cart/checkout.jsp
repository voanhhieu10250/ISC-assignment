<%-- 
    Document   : checkout.jsp
    Created on : Mar 12, 2023, 1:04:45 AM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<!-- checkout page -->
<div id="checkout_page" class="checkout-page animate__animated animate__fadeInUp">
    <div class="sp_header bg-white p-3 ">
        <div class="container custom_container ">
            <div class="row ">
                <div class="col-12 ">
                    <ul>
                        <li class="d-inline-block font-weight-bolderer"><a href="<c:url value="/home/index.do"/>">home</a></li>
                        <li class="d-inline-block hr_ font-weight-bolderer"><a href="#">checkout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container custom_container">
        <form class="needs-validation" method="post" action="<c:url value="/order/create.do"/>" novalidate >
            <div class="row">
                <div class="col-lg-8 col-12">
                    <div class="accordion" id="check_out_toggle">
                        <div class="card rounded mb-2">
                            <div class="card-header bg-white" id="checkout_info">
                                <h2 class="mb-0">
                                    <button class="btn btn-link btn-block text-left text-body p-0 font-weight-bolder" type="button" data-toggle="collapse" data-target="#check_info" aria-expanded="true" aria-controls="check_info">
                                        Personal information<span class="float-right"><i class="fas fa-angle-down"></i></span>
                                    </button>
                                </h2>
                            </div>
                            <div id="check_info" class="collapse show" aria-labelledby="checkout_info" data-parent="#check_out_toggle">
                                <div class="card-body">
                                    <div class="tab-content" >
                                        <div class="tab-pane fade show active" id="order_guest"  aria-labelledby="order_guest">
                                            <div id="Registration" class="page-content mb-4">
                                                <div class="form-group">
                                                    <label for="name" class="font-weight-bolder">Name</label>
                                                    <input type="text" class="form-control" id="name" name="name" disabled value="${account.name}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="email" class="font-weight-bolder">Email address</label>
                                                    <input type="email" class="form-control" id="email" name="email" disabled value="${account.email}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="phone" class="font-weight-bolder">Phone number</label>
                                                    <input type="tel" id="phone" class="form-control" name="phone" disabled value="${account.phone}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="address" class="font-weight-bolder">Address</label>
                                                    <input type="text" id="address" class="form-control" name="address" required>
                                                    <div class="invalid-feedback">Please Enter your Address.</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-12 ">
                    <div class="border rounded bg-white final_payment">
                        <div class="card-body cart_body">
                            <c:forEach var="item" items="${cart.items}">
                                <div class="row mb-4 d-flex justify-content-between">
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
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-4 mt-4">
                                        <div class="row d-flex">
                                            <div class="mr-4">
                                                <p><strong>Quantity: </strong>${item.quantity}</p>
                                            </div>
                                            <div class="mr-4">
                                                <p><strong>Cost: </strong><fmt:formatNumber type="currency" value="${item.cost}" currencySymbol="$" /></span></p>
                                            </div>  
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${cartSize != null}">
                                <div class="card-footer row d-flex justify-content-end mb-3">
                                    <div class="col-md-3 p-0 mr-4">
                                        <p><strong>Total: </strong><fmt:formatNumber type="currency" value="${total}" currencySymbol="$" /></span></p>
                                    </div>
                                </div>
                                <div class="row checkout-btn">
                                    <button class="col-12 btn btn-primary primary">Checkout</button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- checkout page -->
<script>
    // Disable form submissions if there are invalid fields
    (function () {
        'use strict';
        window.addEventListener('load', function () {
            // Get the forms we want to add validation styles to
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>
