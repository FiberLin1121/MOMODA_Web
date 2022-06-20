<%-- 
    Document   : cart_total_quantity
    Created on : 2019/4/1, 下午 02:34:54
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart"); //從session取出cart物件
    if (cart != null && cart.getTotalQuantity() > 0) {
%>
<%= cart.getTotalQuantity() %>
<%}else{%>
<%=0%>
<%}%>