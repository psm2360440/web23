<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- pagination start -->
<div class="col text-center">
  <ul class="pagination ">
    <c:choose>
      <c:when test="${cpage.getPrePage() != 0}">
        <li>
          <a href="/${target}/findimpl?pageNo=${cpage.getPrePage()}&keyword=${search.keyword}&search=${search.search}">Previous</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="disabled">
          <a href="#">Previous</a>
        </li>
      </c:otherwise>
    </c:choose>

    <c:forEach begin="${cpage.getNavigateFirstPage() }" end="${cpage.getNavigateLastPage() }" var="page">
      <c:choose>
        <c:when test="${cpage.getPageNum() == page}">
          <li class="active">
            <a  href="/${target}/findimpl?pageNo=${page}&keyword=${search.keyword}&search=${search.search}">${page }</a>
          </li>
        </c:when>
        <c:otherwise>
          <li>
            <a href="/${target}/findimpl?pageNo=${page}&keyword=${search.keyword}&search=${search.search}">${page }</a>
          </li>
        </c:otherwise>
      </c:choose>

    </c:forEach>
    <c:choose>
      <c:when test="${cpage.getNextPage() != 0}">
        <li>
          <a href="/${target}/findimpl?pageNo=${cpage.getNextPage()}&keyword=${search.keyword}&search=${search.search}">Next</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="disabled">
          <a href="#">Next</a>
        </li>
      </c:otherwise>
    </c:choose>

  </ul>
</div>
<!-- pagination end -->
