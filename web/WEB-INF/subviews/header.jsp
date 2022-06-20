<%-- 
    Document   : header
    Created on : 2019/3/23, 上午 11:22:57
    Author     : fiber
--%>
<%@page import="uuu.mmd.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.mmd.model.ProductService"%>
<!-- header.jsp start -->
<%@page import="uuu.mmd.entity.Customer"%>
<%@page  pageEncoding="UTF-8"%>
<%
    Customer member = (Customer) session.getAttribute("member");
%>
<Header class="Header">
    <a href="/MOMODA_Web"><div class="logo"></div></a>
    <nav class="right-loginbar">
        <% if (member == null) { %>
        <a href="<%=request.getContextPath()%>/login_register.jsp" data-toggle="tooltip" data-placement="top" title="登入">SIGN IN</a>
        <a href="<%=request.getContextPath()%>/member/my_account.jsp" data-toggle="tooltip" data-placement="top" title="會員中心"><i class="fa fa-user-o" style="font-size:12px;color: #999;font-weight: bold;"></i>&emsp;ACCOUNT</a>
        <% } else {%>
        <a href="<%=request.getContextPath()%>/logout.do" data-toggle="tooltip" data-placement="top" title="登出">SIGN OUT</a>
        <a href="<%=request.getContextPath()%>/member/my_account.jsp" data-toggle="tooltip" data-placement="top" title="會員中心"><i class="fa fa-user-o" style="font-size:12px;color: #999;font-weight: bold;"></i>&emsp;<%= member != null ? member.getName() : ""%></a>
        <% }%>
        <a href="<%=request.getContextPath()%>/member/cart.jsp" data-toggle="tooltip" data-placement="top" title="購物車" id="cart-a"><i class="fa fa-shopping-cart" style="font-size:15px;color: #999;"></i>&nbsp;&nbsp;
            <div id="cart-countshow" style="margin-top:-2px;"><%@include  file="/cart_total_quantity.jsp"%></div>
        </a>
    </nav>
    <nav class="left-loginbar">
        <a href="https://www.facebook.com/EYESCREAMfans" data-toggle="tooltip" data-placement="top" title="加入粉絲專頁"><i class="fa fa-facebook-f"></i></a>
        <a href="" data-toggle="tooltip" data-placement="top" title="加入instagram"><i class="fa fa-instagram"></i></a>
        <a href="" data-toggle="tooltip" data-placement="top" title="訂閱電子報"><i class="fa fa-envelope"></i></a>
        <a href="https://www.youtube.com/channel/UCJj_aiXaeneEKWi0va46bpw" data-toggle="tooltip" data-placement="top" title="新品直播"><i class="fa fa-youtube-play"></i></a>
        <a href="" data-toggle="tooltip" data-placement="top" title="加LINE好友"><i class="fa fa-comment-o"></i></a>
        <a href="">&nbsp;&nbsp;</a>
    </nav>
</header>
<!--navbar-->
<nav class="navbar">
    <ul>
        <li><a href="<%=request.getContextPath()%>/product_list.jsp?launch_date=today">新品上市</a></li>
        <li><a href=#>熱銷排行</a></li>
        <li class="label1"><a href="<%=request.getContextPath()%>/product_list.jsp">全館商品</a>
            <div class="dropdown-content content1">
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=上衣">上衣</a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=洋裝">洋裝</a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=褲子">褲子</a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=裙子">裙子</a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=外套">外套</a>
            </div>
        </li>
        <li class="label2"><a href=#>穿搭提案</a>
            <div class="dropdown-content content2">
                <a href="<%=request.getContextPath()%>/product_list.jsp?outfit=春日出遊">甜美度上升 春日出遊這樣穿</a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?outfit=上班族">辦公室好感淑女系 OL職場穿搭</a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?outfit=約會">女人味100% ♥ 約會心機穿搭術</a>
            </div>
        </li>
        <li><a href=#>SALE</a></li>
        <li >
            <i id="search" class="fa fa-search" style="font-size:16px;color:#fff;vertical-align: middle;"></i>
        </li>
        <form method="GET" action="<%=request.getContextPath()%>/product_list.jsp">
            <input id="search-input" type="search" placeholder="Search.." name="search"><input id="search-button" type="submit" value="GO">
        </form>
    </ul>
</nav>
<!-- header.jsp end -->