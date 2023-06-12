<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-sm-8 text-left">
    <div class="container">
        <div class="row content">
            <div class="col-sm-6  text-left ">
                <h3>Cust All Page</h3>
                <form action="/cust/findimpl" method="get">
                    <div>
                        <select name="keyword" id="keyword">

                            <option value="id" <c:if test="${search.keyword == 'id'}">selected</c:if>>ID</option>
                            <option value="name" <c:if test="${search.keyword == 'name'}">selected</c:if>>NAME</option>
                        </select>
                        <input type="text" id="search" name="search" <c:if test="${search.search != null}">value="${search.search}"</c:if>>
                        <button type="submit">검색</button>
                    </div>
                </form>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>NAME</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="c" items="${cpage.getList()}">
                        <tr>
                            <td><a href="/cust/get?id=${c.id}">${c.id}</a></td>
                            <td>${c.name}</td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
                <c:if test="${cpage.getList() == null}">
                    <h4>데이터가 없습니다.</h4>
                </c:if>
                <jsp:include page="../findpage.jsp"/>
            </div>
        </div> <!-- -->
    </div>
</div>
