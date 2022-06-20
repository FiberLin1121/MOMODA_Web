<%-- 
    Document   : error
    Created on : 2019/3/24, 下午 06:14:30
    Author     : fiber
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>錯誤訊息</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>

    </head>
    <body style="background: #f4f4f4">
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <article>
            <h4 style= "margin-left:300px">
                執行<span style='color:darkred'><%= request.getAttribute("javax.servlet.error.request_uri")%></span>時發生下列錯誤：
            </h4>
            <img style='width:50%;margin: auto;display:block' src='<%= request.getContextPath()%>/images/404.png'>                

        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
