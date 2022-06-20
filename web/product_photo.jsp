<%-- 
    Document   : product_photo
    Created on : 2019/3/26, 下午 08:49:47
    Author     : Admin
--%>

<%@page import="uuu.mmd.model.ProductService"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%><%--plain:純文字檔--%>
<%
    String productId=request.getParameter("productId");
    String color=request.getParameter("color");
    String photoId=request.getParameter("photoId");

    ProductService service = new ProductService();
    String photo_url = service.selectPhotoByIdandColor(productId, color, photoId);    
%>
<%= photo_url%>
