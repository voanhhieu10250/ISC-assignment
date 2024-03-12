<%-- 
    Document   : invoices
    Created on : Mar 16, 2023, 12:54:16 AM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                        <i class="bi bi-globe2 small me-2"></i>Orders
                    </a>
                </li>
            </ol>
        </nav>
    </div>
    <form id="main-form" class="mb-3 mb-md-0">
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-custom table-lg mb-0" id="products">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Customer Name</th>
                                <th >Delivery Address</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td><a href="<c:url value="/admin/order-detail.do?id=${order.id}"/>">${order.id}</a></td>
                                    <td><a href="<c:url value="/admin/order-detail.do?id=${order.id}"/>">${accountMap.get(order.accId)}</a></td>
                                    <td>${order.address}</td>
                                    <td><fmt:formatDate type = "date" value = "${order.orderDate}" /></td>
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
        </div>
</div>
</form>
<!-- ./ content -->
</div>
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

