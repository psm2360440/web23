<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-sm-8 text-left">
    <div class="container">
        <h3>JSP02 �Դϴ�</h3>
        <!--JSTL if-->
        <h3>
            <c:if test="${rcust != null}">
                <h4>${rcust.id}</h4>
                <c:if test="${rcust.id == 'id01'}">
                    <h4>�ݼ��� ����</h4>
                </c:if>
            </c:if>
        </h3>
        <!--JSTL if else...-->
        <h3>
            <c:choose>
                <c:when test="${num == 0}">
                    <h4>Num is bigger</h4>
                </c:when>
                <c:when test="${num == 2}">
                    <h4>Num is smaller</h4>
                </c:when>
                <c:otherwise>
                    <h4>num is 1</h4>
                </c:otherwise>
            </c:choose>
        </h3>
        <h3>End Page</h3>
    </div>
</div>
