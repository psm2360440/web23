<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="/js/index0421.js"></script>
    <!--카카오 지도 api-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5f154fb7d1604c83c2bdb25d0f4a23c"></script>
    <!--차트 라이브러리-->
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/cylinder.js"></script>
    <script src="https://code.highcharts.com/modules/funnel3d.js"></script>
    <script src="https://code.highcharts.com/modules/data.js"></script>
    <!--websocket-->
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>

    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>


    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */
        .navbar {
            margin-bottom: 0;
            border-radius: 0;
        }

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {
            height: 750px
        }

        /* Set gray background color and 100% height */
        .sidenav {
            padding-top: 20px;
            background-color: #f1f1f1;
            height: 100%;
        }

        /* Set black background color, white text and some padding */
        footer {
            background-color: #555;
            color: white;
            padding: 15px;
        }

        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 767px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }

            .row.content {
                height: auto;
            }
        }
    </style>
</head>
<script>
    let chatbtn = {
        init:function(){
            const scrollBtn = document.createElement("button");
            scrollBtn.innerHTML = "chatbot";
            scrollBtn.setAttribute("id", "scroll-btn");
            document.body.appendChild(scrollBtn);
            scrollBtn.classList.add("show");
            scrollBtn.addEventListener("click", function(){
                location.href='/chatbot';
            });
            const scrollBtn2 = document.createElement("button");
            scrollBtn2.innerHTML = "1:1";
            scrollBtn2.setAttribute("id", "scroll-btn2");
            document.body.appendChild(scrollBtn2);
            scrollBtn2.classList.add("show");
            scrollBtn2.addEventListener("click", function(){
                location.href='/callcenter';
            });
        }
    };

    $(function(){
        chatbtn.init();
    });
</script>
<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">
                <img style="width: 10px" src="https://cdn-icons-png.flaticon.com/512/1076/1076928.png">
            </a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/">Logo</a></li>
                <li><a href="/">Home</a></li>
                <c:if test="${logincust != null}">
                    <li><a href="/jsp">JSP</a></li>
                    <li><a href="/ajax">AJAX</a></li>
                    <li><a href="/map">MAP</a></li>
                    <li><a href="/chart">CHART</a></li>
                    <li><a href="/cust">Cust</a></li>
                    <li><a href="/item">Item</a></li>
                    <li><a href="#">Contact</a></li>
                </c:if>

            </ul>
            <c:choose>
                <c:when test="${logincust == null}">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                        <li><a href="/register"><span class="glyphicon glyphicon-pencil"></span> Register</a></li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/custinfo?id=${logincust.id}">${logincust.name}님(${logincust.id})</a></li>
                        <li><a href="/item/allcart?id=${logincust.id}"><span class="glyphicon glyphicon-shopping-cart"></span></a></li>
                        <li><a href="/logout"><span class="glyphicon glyphicon-log-out"></span>${logincust.name}님(${logincust.id}) LogOut</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container-fluid text-center">
    <div class="row content">
        <%-- Left menu--%>
        <c:choose>
            <c:when test="${left==null}">
                <jsp:include page="left.jsp"/>
            </c:when>
            <c:otherwise>
                <jsp:include page="${left}.jsp"/>
            </c:otherwise>
        </c:choose>
        <%--Left menu end--%>

        <%--   Center start--%>
        <c:choose>
            <c:when test="${center==null}">
                <jsp:include page="center.jsp"/>
            </c:when>
            <c:otherwise>
                <jsp:include page="${center}.jsp"/>
            </c:otherwise>
        </c:choose>

        <%--   Center end--%>
        <div class="col-sm-2 sidenav">
            <div class="well">
                <p>ADS</p>
            </div>
            <div class="well">
                <p>ADS</p>
            </div>
        </div>
    </div>
</div>
</div>

<footer class="container-fluid text-center">
    <p>Footer Text</p>
</footer>
<style>
    #scroll-btn {
        opacity: 0;
        width: 50px;
        height: 50px;
        color: #fff;
        background-color: #ef476f;
        position: fixed;
        bottom: 13%;
        right: 10%;
        border: 2px solid #fff;
        border-radius: 50%;
        font: 2px monospace;
        transition: opacity 2s, transform 2s;
    }
    #scroll-btn.show {
        opacity: 1;
        transition: opacity 5s, transform 5s;
    }
    #scroll-btn2 {
        opacity: 0;
        width: 50px;
        height: 50px;
        color: #fff;
        background-color: #ef476f;
        position: fixed;
        bottom: 5%;
        right: 10%;
        border: 2px solid #fff;
        border-radius: 50%;
        font: bold 10px monospace;
        transition: opacity 2s, transform 2s;
    }
    #scroll-btn2.show {
        opacity: 1;
        transition: opacity 5s, transform 5s;
    }
</style>

</body>
</html>
