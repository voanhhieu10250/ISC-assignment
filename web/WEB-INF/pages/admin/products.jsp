<%-- 
    Document   : products.jsp
    Created on : Mar 16, 2023, 12:53:49 AM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<!-- content -->
<div class="content ">
    <div class="mb-4">
        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="#">
                        <i class="bi bi-globe2 small me-2"></i>Products
                    </a>
                </li>
            </ol>
        </nav>
    </div>



    <a href="<c:url value="/admin/create-product.do"/>">    
        <button class="btn btn-primary btn-icon">
            <i class="bi bi-plus-circle"></i>Add Product
        </button>
    </a>

    <form id="main-form" class="mb-3 mb-md-0">
        <div class="row">
            <div class="col-md-8">
                <div class="table-responsive">
                    <table class="table table-custom table-lg mb-0" id="products">
                        <thead>
                            <tr>
                                <th>Photo</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th class="text-end">Quantity</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>
                                        <a href="#">
                                            <img src="<c:url value="${product.imagePath}"/>" class="rounded" width="40"
                                                 alt="...">
                                        </a>
                                    </td>
                                    <td>${product.name}</td>
                                    <td>
                                        ${categoryMap.get(product.categoryId)}
                                    </td>
                                    <td><fmt:formatNumber type="currency" value="${product.price}" currencySymbol="$" /></td>
                                    <td class="text-end">${product.quantity}</td>
                                    <td class="text-end">
                                        <div class="d-flex">
                                            <div class="dropdown ms-auto">
                                                <a href="#" data-bs-toggle="dropdown"
                                                   class="btn btn-floating"
                                                   aria-haspopup="true" aria-expanded="false">
                                                    <i class="bi bi-three-dots"></i>
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-end">
                                                    <a href="<c:url value="/admin/edit-product.do?id=${product.id}"/>" class="dropdown-item">Edit</a>
                                                    <a href="<c:url value="/admin/delete-product.do?id=${product.id}"/>" class="dropdown-item">Delete</a>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${totalPage != 0}">
                    <nav class="mt-4" aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <c:forEach begin="0" end="${totalPage + 1}" step="1" var="pageNumber">
                                <c:choose>
                                    <c:when test="${pageNumber == 0}">
                                        <li class="pagination-item page-item page-link" value="1">
                                            &laquo;
                                        </li>
                                    </c:when>
                                    <c:when test="${pageNumber == totalPage + 1}">
                                        <li class="pagination-item page-item page-link" value="${totalPage}">
                                            &raquo;
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${currentPage == pageNumber}">
                                                <li class="pagination-item page-item active page-link" value="${pageNumber}">
                                                    ${pageNumber}
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="pagination-item page-item page-link" value="${pageNumber}">
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
            <!-- filter -->
            <div class="col-md-4">

                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center" data-bs-toggle="collapse"
                             aria-expanded="true" data-bs-target="#keywordsCollapseExample" role="button">
                            <div>Keywords</div>
                            <div class="bi bi-chevron-down"></div>
                        </div>
                        <div class="collapse show mt-4" id="keywordsCollapseExample">
                            <div class="input-group">
                                <input type="text" class="form-control" name="search" placeholder="Pot, Japanese..." value="${search}">
                                <button class="btn btn-outline-light" type="submit">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-md-flex gap-4 align-items-center">
                            <div class="d-none d-md-flex">Sort by</div>
                            <div class="d-md-flex gap-4 align-items-center">
                                <div class="row g-2">
                                    <select class="form-select" name="order" onchange="this.form.submit()">
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
                                    <!--                                    <div class="col-md-6">
                                                                            <select class="form-select">
                                                                                <option value="10">10</option>
                                                                                <option value="20">20</option>
                                                                                <option value="30">30</option>
                                                                                <option value="40">40</option>
                                                                                <option value="50">50</option>
                                                                            </select>
                                                                        </div>-->
                                </div>
                            </div>
                            <!-- <div class="dropdown ms-auto">
                                <a href="#" data-bs-toggle="dropdown"
                                   class="btn btn-primary dropdown-toggle"
                                   aria-haspopup="true" aria-expanded="false">Actions</a>
                                <div class="dropdown-menu dropdown-menu-end">
                                    <a href="#" class="dropdown-item">Action</a>
                                    <a href="#" class="dropdown-item">Another action</a>
                                    <a href="#" class="dropdown-item">Something else here</a>
                                </div>
                            </div> -->
                        </div>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center" data-bs-toggle="collapse"
                             aria-expanded="true" data-bs-target="#categoriesCollapseExample" role="button">
                            <div>Categories</div>
                            <div class="bi bi-chevron-down"></div>
                        </div>
                        <div class="collapse show mt-4" id="categoriesCollapseExample">
                            <div class="d-flex flex-column gap-3">
                                <c:forEach var="category" items="${categories}">
                                    <div class="form-check">
                                        <c:choose>
                                            <c:when test="${checkedCategories.contains(category.id)}">
                                                <input class="form-check-input" name="categories" type="checkbox" value="${category.id}" checked id="category-${catgory.id}">
                                                <label class="form-check-label" for="category-${catgory.id}">
                                                    ${category.name}
                                                </label>
                                            </c:when>
                                            <c:otherwise>
                                                <input class="form-check-input" name="categories" type="checkbox" value="${category.id}" id="category-${catgory.id}">
                                                <label class="form-check-label" for="category-${catgory.id}">
                                                    ${category.name}
                                                </label>
                                            </c:otherwise></c:choose>
                                        </div>
                                </c:forEach>
                                <button id="submitButton" class="btn btn-primary" type="submit">
                                    Filter
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center" data-bs-toggle="collapse"
                             aria-expanded="true" data-bs-target="#colorsCollapseExample" role="button">
                            <div>Colors</div>
                            <div class="bi bi-chevron-down"></div>
                        </div>
                        <div class="collapse show mt-4" id="colorsCollapseExample">
                            <div class="color-filter-group d-flex gap-3">
                                <input class="form-check-input" type="checkbox" value="#1fa0c6" aria-label="...">
                                <input class="form-check-input" type="checkbox" checked value="green" aria-label="...">
                                <input class="form-check-input" type="checkbox" checked value="#c61faa" aria-label="...">
                                <input class="form-check-input" type="checkbox" value="#1fc662" aria-label="...">
                                <input class="form-check-input" type="checkbox" value="#9dc61f" aria-label="...">
                                <input class="form-check-input" type="checkbox" checked value="#c67b1f" aria-label="...">
                            </div>
                        </div>
                    </div>
                </div> -->
            </div>
        </div>
    </form>
</div>
<!-- ./ content -->
<script>
    const LIMIT = ${pageSize};

    const handleClick = (event) => {
        const hiddenOffsetInput = document.createElement("input");
        hiddenOffsetInput.type = "hidden";
        hiddenOffsetInput.name = "offset";
        hiddenOffsetInput.value = (Number.parseInt(event.target.value) - 1) * LIMIT;
        form.appendChild(hiddenOffsetInput);
        const hiddenLimitInput = document.createElement("input");
        hiddenLimitInput.type = "hidden";
        hiddenLimitInput.name = "limit";
        hiddenLimitInput.value = LIMIT;
        form.appendChild(hiddenLimitInput);
        form.submit();
    }

    const form = document.getElementById("main-form");
    const paginationItems = document.getElementsByClassName("pagination-item");
    for (let i = 0; i < paginationItems.length; i++) {
        paginationItems[i].addEventListener("click", handleClick);
    }
</script>
