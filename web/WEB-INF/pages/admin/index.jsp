<%-- 
    Document   : index
    Created on : Mar 15, 2023, 9:28:02 PM
    Author     : daing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="org.apache.taglibs.standard.tag.common.fmt.Bundle" />
<!-- content -->
<div class="content">
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <!-- sale chart -->
        <div class="col-lg-12 col-md-12">
            <div class="card widget h-100">
                <div class="card-header d-flex">
                    <h6 class="card-title">
                        Revenue
                    </h6>
                </div>
                <form id="main-form" class="mb-3 mb-md-0" action="<c:url value="/admin/index.do"/>">
                    <div class="card-body p-0">
                        <div class="mb-3">
                            <div class="d-flex gap-4 align-items-center mb-3 mt-lg-0">
                                <input class="form-control" type="date" name="startDate" value="${startDate}"/>
                                <input class="form-control" type="date" name="endDate" value="${endDate}"/>
                            </div>
                            <button id="submitButton" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class=" table-responsive">
                                <!--<div id="sales-chart"></div>-->
                                <table class="table table-custom table-lg mb-0" id="products">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${revenue}" varStatus="loop">
                                            <tr>
                                                <td><fmt:formatDate type = "date" value = "${item.date}" /></td>
                                                <td><fmt:formatNumber type="currency" value="${item.price}" currencySymbol="$" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
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
                </form>
            </div>     
        </div>
    </div>
    <!-- content -->

    <!-- content-footer -->
    <!-- <footer class="content-footer">
        <div>© 2021 Vetra - <a href="https://laborasyon.com" target="_blank">Laborasyon</a></div>
        <div>
            <nav class="nav gap-4">
                <a href="https://themeforest.net/licenses/standard" class="nav-link">Licenses</a>
                <a href="#" class="nav-link">Change Log</a>
                <a href="#" class="nav-link">Get Help</a>
            </nav>
        </div>
    </footer> -->
    <!-- ./ content-footer -->

</div>
<!-- ./ layout-wrapper -->
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
