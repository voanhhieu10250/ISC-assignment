<%-- 
    Document   : register
    Created on : Feb 23, 2023, 8:47:11 AM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- registration page -->
<div id="Registration_page" class="Registration-page animate__animated animate__fadeInUp">
    <div class="sp_header bg-white p-3">
        <div class="container custom_container">
            <div class="row ">
                <div class="col-12 ">
                    <ul>
                        <li class="d-inline-block font-weight-bolder"><a href="<c:url value="/product/index.do" />">home</a></li>
                        <li class="d-inline-block hr_ font-weight-bolder"><a href="#">Registration</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container custom_container">
        <h1 class="text-center h1_">Create your account</h1>
        <div id="Registration" class="page-content card card-block p-3 p-sm-4  ">
            <form class="needs-validation" method="post" action="<c:url value="/authentication/register.do"/>" novalidate >
                <p>Already have an account?<a href="login.do"> Log in instead!</a></p>
                <div class="form-group">
                    <label for="f_name" class="font-weight-bolder">Full name</label>
                    <input type="text" class="form-control" id="f_name" name="name" required>
                    <div class="invalid-feedback">Please Enter your Full name.</div>
                </div>
                <div class="form-group">
                    <label for="r_email" class="font-weight-bolder">Email address</label>
                    <input type="email" class="form-control" id="r_email" name="email" required>
                    <div class="invalid-feedback">Please Enter your Account Name.</div>
                </div>
                <div class="form-group">
                    <label for="r_password" class="font-weight-bolder">Password</label>
                    <input type="password" class="form-control" id="r_password" name="password" required>
                    <div class="invalid-feedback">Please Enter your password.</div>
                </div>
                <div class="form-group">
                    <label for="phone" class="font-weight-bolder">Phone number</label>
                    <input type="tel" id="phone" class="form-control" name="phone" required>
                    <div class="invalid-feedback">Please Enter your phone number.</div>
                </div>
                <c:if test="${message != null}">
                    <div class="error-message">${message}.</div>
                </c:if>
                <div><button id="clearButton" type="reset" class="btn btn-primary rese float-left mt-3">reset</button><input type="submit" name="submit" class="btn btn-primary mt-3 float-right" value="Register"></div>
            </form>
        </div>
    </div>
</div>
<!-- registration page -->
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
