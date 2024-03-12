<%-- 
    Document   : create-product
    Created on : Mar 18, 2023, 10:25:24 AM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
    <!-- basic -->
    <div class="mb-4">
        <!-- contact -->
        <div class="card m-5">
            <div class="card-body">
                <form method="post" action="<c:url value="/admin/edit-product.do?id=${product.id}"/>">
                    <h6 class="card-title mb-4">Edit</h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="name" value="${product.name}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Price</label>
                                <span class="input-group-addon">&#36;</span>
                                <input type="number" step="0.01" class="form-control" name="price" value="${product.price}" required>
                            </div>
                        </div> 
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Quantity</label>
                                <input type="number" class="form-control" name="quantity" value="${product.quantity}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Category</label>
                                <select class="form-control" name="category" required>
                                    <option value="">Select category</option>
                                    <c:forEach var="category" items="${categories}">
                                        <c:if test="${product.categoryId == category.id}">
                                            <option value="${category.id}" selected>${category.name}</option>
                                        </c:if>
                                        <c:if test="${product.categoryId != category.id}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="5" cols="10" wrap="soft">${product.description}</textarea>
                        </div>
                    </div>
                    <button class="btn btn-primary btn-icon">
                        Submit
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
