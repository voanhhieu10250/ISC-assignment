<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<!-- Home Page -->
<!-- services -->
<c:if test="${checkoutStatus == 'success'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Successfully checkout</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>
<c:if test="${checkoutStatus == 'fail'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Fail to checkout</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>
<div class="container ">
    <div class="main_services">
        <div class="row">
            <div class="col-md-3 col-sm-6 col-12 m_service ">
                <ul class="bg-white service service-1 rounded text-center  animate__animated animate__fadeInUp"
                    data-wow-duration="0.8s" data-wow-delay="0.1s">
                    <li class="ser-svg d-lg-inline-block d-md-block  align-middle">
                        <span class="icon-image"></span>
                    </li>
                    <li class="ser-t d-lg-inline-block d-md-block  align-middle text-left">
                        <h6>24/7 free support</h6>
                        <p class="mb-0 text-muted">Online Support 24/7</p>
                    </li>
                </ul>
            </div>
            <div class="col-md-3 col-sm-6 col-12 m_service">
                <ul class="bg-white service service-2 rounded text-center  animate__animated animate__fadeInUp"
                    data-wow-duration="0.8s" data-wow-delay="0.2s">
                    <li class="ser-svg d-lg-inline-block d-md-block align-middle">
                        <span class="icon-image"></span>
                    </li>
                    <li class="ser-t d-lg-inline-block d-md-block align-middle text-left">
                        <h6>secure payment</h6>
                        <p class="mb-0 text-muted">100% Secure Payment</p>
                    </li>
                </ul>
            </div>
            <div class="col-md-3 col-sm-6 col-12 m_service">
                <ul class="bg-white service service-3 rounded text-center  animate__animated animate__fadeInUp"
                    data-wow-duration="0.8s" data-wow-delay="0.3s">
                    <li class="ser-svg d-lg-inline-block d-md-block align-middle">
                        <span class="icon-image"></span>
                    </li>
                    <li class="ser-t d-lg-inline-block d-md-block align-middle  text-left">
                        <h6>special gift cards</h6>
                        <p class="mb-0 text-muted">Give The Perfect Gift</p>
                    </li>
                </ul>
            </div>
            <div class="col-md-3 col-sm-6 col-12 m_service">
                <ul class="bg-white service service-4 rounded text-center  animate__animated animate__fadeInUp"
                    data-wow-duration="0.8s" data-wow-delay="0.4s">
                    <li class="ser-svg d-lg-inline-block d-md-block align-middle">
                        <span class="icon-image"></span>
                    </li>
                    <li class="ser-t d-lg-inline-block d-md-block align-middle  text-left">
                        <h6>world wide shipping</h6>
                        <p class="mb-0 text-muted">On Order Over $99</p>
                    </li>
                </ul>
            </div>
        </div>
        <!-- row -->
    </div>
    <!-- main_services -->
</div>
<!-- services end -->

<!-- top-product -->
<div class="main_top_pro_tab">
    <div class="container ">
        <div class="title_outer">
            <h5 class="font-weight-bolderer d-inline-block">popular Products</h5>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="featured_" role="tabpanel" aria-labelledby="featured_tab">
                        <div class="row">
                            <div id="product_carousel2" class="owl-carousel owl-theme pro_thumb">
                                <c:forEach var="products" items="${popularProducts}">
                                    <div class="item">
                                        <c:forEach var="product" items="${products}">
                                            <div class="col-12">
                                                <div class="product_thumb bg-white rounded">
                                                    <div class="pro_image">
                                                        <a href="<c:url value="/product/product-detail.do?id=${product.id}"/>">
                                                            <img
                                                                src="<c:url value="${product.imagePath}"/>"
                                                                class="fst-image mx-auto d-block img-fluid"
                                                                alt="product_1a"
                                                                />
                                                        </a>
                                                    </div>
                                                    <div class="text-center">
                                                        <div class="main_text">
                                                            <h2 class="text-center pro-heading my-2">
                                                                <a href="<c:url value="/product/product-detail.do?id=${product.id}"/>"
                                                                   class="font-weight-bolderer">
                                                                    ${product.name}
                                                                </a>
                                                            </h2>
                                                            <span class="text-center prices">
                                                                <span
                                                                    class="font-weight-bolderer price"><fmt:formatNumber type="currency" value="${product.price}" currencySymbol="$" />
                                                                </span>
                                                            </span>
                                                            <c:if test="${product.quantity > 0}">
                                                                <form action="<c:url value="/cart/add.do"/>" method="post">
                                                                    <input type="number" value="${product.id}" name="id" hidden/>
                                                                    <input hidden type="number" name="quant[${product.id}]" class="form-control input-number" value="1" min="0" max="${product.quantity}"/>
                                                                    <button style="border: none" class="symbol add_to_cart" data-toggle="modal" name="page" value="/home/index.do"
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
                                    <!-- item -->
                                </c:forEach>
                            </div>
                            <!-- owl-carousel-1 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- top-product end -->

<!-- testimonial -->
<div class="testimonial">
    <div class="container ">
        <div class="title_outer">
            <h5 class="font-weight-bolderer d-inline-block"> Testimonials </h5>
        </div>
        <div id="testimonial_carousel" class="owl-carousel owl-theme pro_thumb row">
            <div class="item">
                <div class="col-12">
                    <div class="mr-jhon">
                        <p class="">
                            In this featured interview series, we meet plant people, gardeners and creators who make plant related goods to introduce their delightful life with plants. This time, we meet Japanese designer Takeshi Shima, design director of creative studio moss.
                        </p>
                    </div>
                    <div class="designer">
                        <div class="">
                            <!-- <img src="assets/images/Testi-1.png" alt="Testi-1" class="jhon-img img-fluid" style="width: 10%;"> -->
                        </div>
                        <div class="name">
                            <h5 class=""> Jac Semmler </h5>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="col-12">
                    <div class="mr-jhon">
                        <p class="">
                            In this edition of The Plant Scociety Journal, we chat to gardener and plant specialist Jac Semmler, newly appointed Head of Plants & Strategy at The Plant Society, about 'all things green'. We also take a moment to introduce her garden 'Heartland'
                        </p>
                    </div>
                    <div class="designer">
                        <div class="">
                            <!-- <img src="assets/images/Testi-2.png" alt="Testi-2" class="jhon-img img-fluid"> -->
                        </div>
                        <div class="name">
                            <h5 class="">Hiroyuki Ogura</h5>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="col-12">
                    <div class="mr-jhon">
                        <p class="">
                            In this interview series with plant people, we visited a new studio of Melbourne-based potter Arcadia Scott for our third story. Her works are very popular for their lovely shapes and delicate touch. This time, we will introduce her motivation for ceramics and her studio where you can see lots of cheerful greenery
                        </p>
                    </div>
                    <div class="designer">
                        <div class="">
                            <!-- <img src="assets/images/Testi-3.png" alt="Testi-3" class="jhon-img img-fluid"> -->
                        </div>
                        <div class="name">
                            <h5 class="">Arcadia Scott</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- testimonial end -->

<!-- video -->
<div class="video_bg">
    <h3 class="perfect-choice">
        The Perfect Choice Of Any Plant
    </h3>
    <div class="video text-center">
        <!-- <a data-fancybox="gallery" href="https://www.youtube.com/watch?v=BaKwRXMoL1Q"><img src="assets/img/playvideo.png"></a> -->
        <!-- <p>Play Video</p> -->
    </div>
</div>
<!-- video end -->