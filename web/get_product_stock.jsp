<%-- 
    Document   : get_product_stock
    Created on : 2019/4/11, 下午 05:49:18
    Author     : fiber
--%>

<%@page import="uuu.mmd.model.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String productId = request.getParameter("productId");
    String color = request.getParameter("color");
    String size = request.getParameter("size");

    ProductService service = new ProductService();
    int stock =service.getProductStock(productId, color, size);
%>
<%= stock%>