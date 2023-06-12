<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- pagination start -->
<div class="col text-center">
  <ul class="pagination ">
    <c:choose>
      <c:when test="${cpage.getPrePage() != 0}">
        <li>
          <a href="/${target}/findimpl2?pageNo=${cpage.getPrePage()}&keyword1=id&search1=${searc2.search1}&&keyword2=name&search2=${search2.search2}">Previous</a>
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
            <a  href="/${target}/findimpl2?pageNo=${page}&keyword1=id&search1=${search2.search1}&&keyword2=name&search2=${search2.search2}">${page }</a>
          </li>
        </c:when>
        <c:otherwise>
          <li>
            <a href="/${target}/findimpl2?pageNo=${page}&keyword1=id&search1=${search2.search1}&&keyword2=name&search2=${search2.search2}">${page }</a>
          </li>
        </c:otherwise>
      </c:choose>

    </c:forEach>
    <c:choose>
      <c:when test="${cpage.getNextPage() != 0}">
        <li>
          <a href="/${target}/findimpl2?pageNo=${cpage.getNextPage()}&keyword1=id&search1=${search2.search1}&&keyword2=name&search2=${search2.search2}">Next</a>
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
