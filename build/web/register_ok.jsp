<%-- 
    Document   : register_ok
    Created on : 2019/3/15, 上午 01:59:30
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>註冊成功</title>
    </head>
    <%
        Customer c = (Customer)request.getAttribute("customer");
    %>
    <body>
        <h1><%= c!=null?c.getName():"" %> ,註冊成功</h1>
    </body>
</html>
