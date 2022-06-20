<%-- 
    Document   : ${name}
    Created on : ${date}, ${time}
    Author     : ${user}
--%>

<%@page contentType="text/html" pageEncoding="${encoding}"%>
${doctype}
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="${encoding}">     
        <title>JSP Page</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <article>

        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
