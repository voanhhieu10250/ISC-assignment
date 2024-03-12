<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- about us page -->
<div id="about_us_page" class="about-us-page animate__animated animate__fadeInUp">
    <div class="sp_header ">
        <div class="container custom_container ">
            <div class="row ">
                <div class="col-12 ">
                    <ul class="p-md-3 p-2 bg-light">
                        <li class="d-inline-block font-weight-bolder"><a href="<c:url value="/home/index.do"/>">home</a></li>
                        <li class="d-inline-block  font-weight-bolder"><a class="hr_">About us </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container info_container">
        <div class="row">
            <div class="col-12">
                <div class="title_outer">
                    <h1 class="mb-3 d-inline-block pb-3 position-relative border-bottom h1_">About us </h1>
                </div>
                <!-- title_outer -->
            </div>
            <!-- col-12 -->
        </div>
        <!-- row -->
        <div class="bg-white rounded py-3">
            <div class="">
                <div>
                    <div class="row">
                        <div class="col-12">
                            <img src="<c:url value="/assets/images/about_us/about_us.jpg"/>" class="mx-auto rounded d-block img-fluid" alt="about_us2">
                        </div>
                    </div>
                </div>
            </div>
            <div class="">
                <div class="row">
                    <div class="col-12">
                        <div class="mt-3 mt-lg-5">
                            <h4 class="">It all Started Off as a Side Hustle</h4>
                            <p class="font-weight-bolder text-muted mt-3 f_13">As children of garden veterans, they ensure that The Planty only houses carefully curated house plants, outdoor plants, beautiful ceramics and other gardening accessories to green up any space. Their group of experienced plantsmen are also trained to equip clients with the knowledge needed to keep plants thriving and create insta-worthy ensembles suitable for the environment.</p>
                            <p class="font-weight-bolder text-muted f_13">Our passionate team strives to curate unique spaces by greening them up. </p>
                            <p class="font-weight-bolder text-muted f_13">service is a personally tailored service where our team will be on site to assess natural lighting conditions, interior design and spatial requirements for seamless integration of plants and planters we have selected. Our on site services are not restricted to just addition of new plants. If you have existing plants that need help, we can do that too.</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- container custom_container -->
        </div>
        <!-- bg-white rounded p-3 -->
    </div>
</div>
<!-- about us page end -->

<script>
    // init Masonry
    var $grid = $('.grid').masonry({
        itemSelector: '.grid-item',
        percentPosition: true,
        columnWidth: '.grid-sizer'
    });

    // layout Masonry after each image loads
    $grid.imagesLoaded().progress(function () {
        $grid.masonry();
    });
</script>
