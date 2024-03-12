<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- contact page -->
<section class="contact-page">
    <div class="sp_header ">
        <div class="container custom_container ">
            <div class="row ">
                <div class="col-12 ">
                    <ul class="p-md-3 p-2 bg-light">
                        <li class="d-inline-block font-weight-bolder"><a href="<c:url value="/home/index.do"/>">home</a></li>
                        <li class="d-inline-block  font-weight-bolder"><a href="#" class="hr_">Contact us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-sm-12 title_outer">
                <h2 class="font-weight-bolder mt-2 mb-3 d-inline-block pb-3 position-relative border-bottom">contact us</h2>
            </div>
            <!-- title_outer -->  
            <div class="col-lg-6 col-md-12 col-sm-12 col-12">
                <form id="contactForm" method="post">
                    <div class="row">
                        <div class="form-group mb-3 col-sm-12 col-12">
                            <label>Your Name</label>
                            <input type="text" class="form-control" name="txt_name" id="txt_name" placeholder="Your Name*" data-form-field="Name" required="">
                        </div>
                        <div class="form-group mb-3 col-sm-12 col-12">
                            <label>Your Email</label>
                            <input type="email" class="form-control" name="txt_email" required="" id="txt_email" placeholder="Your Email*" data-form-field="Email">
                        </div>
                        <div class="form-group mb-3 col-12">
                            <label>Your Phone</label>
                            <input type="tel" class="form-control" name="txt_phone" id="txt_phone" placeholder="Your Phone" data-form-field="Phone">
                        </div>
                        <div class="form-group mb-3 col-12">
                            <label>Your Message</label>
                            <textarea class="form-control" name="txt_message" id="txt_message"  placeholder="Your Message" rows="7" data-form-field="Message"></textarea>
                        </div>
                        <div class="contact-us-btn col-12">
                            <button type="submit" class="btn btn-small">contact us</button>
                        </div>
                        <div id="message" class="ajax_response"></div>
                    </div>
                </form>
            </div>
            <div class="col-lg-6 col-md-12 col-sm-12 col-12 col-sm-offset-2 pt-lg-0 pt-md-4 pt-sm-4 pt-4">
                <div class="our_off">
                    <h4 class="mb-3">Our <strong>Office</strong></h4>
                    <ul class="list list-icons list-icons-style-2 mt-2">
                        <li class="mb-3"><i class="fas fa-map-marker-alt top-6"></i> <strong class="text-dark">Address:</strong> Demo A - 2 Tong Duy Tan Street,
                            District 5, HCM</li>
                        <li class="mb-3"><i class="fas fa-phone top-6"></i> <strong class="text-dark">Phone:</strong> (84)1234567890</li>
                        <li class="mb-0"><i class="fas fa-envelope top-6"></i> <strong class="text-dark">Email:</strong> <a href="#">website@gmail.com</a></li>
                    </ul>
                </div>
                <div class="buss_hou">
                    <h4 class="pt-5 mb-3">Business <strong>Hours</strong></h4>
                    <ul class="list list-icons list-dark mt-2">
                        <li class="mb-3"><i class="far fa-clock top-6"></i> Monday - Friday - 9am to 5pm</li>
                        <li class="mb-3"><i class="far fa-clock top-6"></i> Saturday - 9am to 2pm</li>
                        <li class="mb-0"><i class="far fa-clock top-6"></i> Sunday - Closed</li>
                    </ul>
                </div>
                <div class="pt-5">
                    <h4>Get in <strong>Touch</strong></h4>
                    <p class="lead mb-0 get_in">Have questions, feedback or just want to say hello.</p>
                    <p class="lead mb-0 get_in">Send us a message and we will get back to you in 24-48 hours.</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- contact page -->