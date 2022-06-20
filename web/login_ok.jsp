<%-- 
    Document   : login_ok
    Created on : 2019/3/14, 下午 11:28:45
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>登入成功</title>
    </head>
    <%
        Customer c = (Customer)request.getAttribute("member");    
    %>
    <body>
        <h1><%= c.getName() %> ,恭喜登入成功</h1>
    </body>
</html>
