<%-- 
    Document   : orders_history
    Created on : 2019/4/6, 下午 10:17:00
    Author     : fiber
--%>

<%@page import="uuu.mmd.model.OrderService"%>
<%@page import="uuu.mmd.entity.Order"%>
<%@page import="java.util.List"%>
<%@page import="uuu.mmd.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>會員中心</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入top-button.css-->
        <link href="<%= request.getContextPath()%>/style/top-button.css" rel="stylesheet" type="text/css"/>
        <style>
            article {
                font-size: 16px;
                padding: 25px 55px 50px;
                display: flex;
                flex-direction: row;
                font-family: Lato,'PingFang TC', 'Hiragino Sans GB', 'Microsoft JhengHei', 'Helvetica Neue', icomoon, serif,sans-serif;
            }
            .aside-menu{
                line-height: 2.2;
                padding-top: 4em;
                margin-left: -50px;
                width: 220px;
                min-width: 150px;
                background: #fcfcfc;
            }
            .aside-menu section{
                margin-top: 35px;
                margin-left: -10px;
                display: block;
                width:200px; 
            }
            .aside-menu .first{
                margin-top: 0;
            }
            .aside-menu h3{
                display:block;
                color: #E6B0AA;
                margin: 0;
                position: relative;
                font-size: 1.2em;
                font-family: 'Trajan Pro','Playfair Display','Microsoft JhengHei','Hiragino Sans GB','PingFang TC';
            }
            .aside-menu span{
                font-size: 15px;
                color: #999;
                display: block;
                margin-bottom: 11px;
                font-weight: 100;
                letter-spacing: 0.08em;
                font-family: 'Trajan Pro','Playfair Display','Microsoft JhengHei','Hiragino Sans GB','PingFang TC';
            }
            .aside-menu li{
                list-style-type: none; 
            }
            .aside-menu a {
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 300;
                line-height: 2.4em;
                font-size: 0.78em;
                color: #444;
                text-decoration:none;
                letter-spacing: 0.1em;
            }
            .aside-menu a:hover{
                color: #E6B0AA;
                padding-bottom: 3px;
                border-bottom: 1px solid #E6B0AA; 
            }
            .aside-menu ul a span{
                font-size: 1em;
            }   
            .welcome{
                margin: auto;
                margin-left: 375px;
                padding: .1em;
                color: #666;
                line-height: 1.5em;
                text-align: center;
                font-family: Lato,'PingFang TC', 'Hiragino Sans GB', 'Microsoft JhengHei', 'Helvetica Neue', icomoon, serif,sans-serif;
            }
            .section-shopping-cart.orders {
                width: 1100px;
                margin-left: -10px;
                padding-top: 1.5em;
                text-align: center;
                box-sizing: border-box;
            }
            .section-shopping-cart.orders h1 {
                font-size: 24px;
                margin: 1.5em 0;
                color: #555;
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 300;
            }
            .orders .cart-title {
                font-size: 13px;
                line-height: 40px;
                border: 1px solid #636262;
                /*background: #636262;*/
                height: 40px;
                display: block;
                color: #636262;   
            }
            .orders .cart-item-list span {
                font-size: 13px;
                line-height: 5;
            }
            .cart-item-list {
                height: 100px;
                clear: both;
                padding: 1em 0;
                border-bottom: 1px solid #efefef;
                width: 100%;
            }
            .col-md-2 a{
                text-decoration:none;
                color: #96866F;
            }
            .col-md-2 a:hover{
                color: #E6B0AA;
                padding-bottom: 1px;
                border-bottom: 1px solid #E6B0AA; 
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <!---------------------------------------------article------------------------------------------------------>
        <%
            Customer member = (Customer) session.getAttribute("member");
            List<Order> list = null;

            if (member != null) {
                OrderService service = new OrderService();
                list = service.searchOrdersByCustomerEmail(member.getEmail());
            }

            if (list != null && list.size() > 0) {
        %>            
        <article>
            <aside class="aside-menu">
                <section class="first">
                    <ul>
                        <h3>My Account</h3>
                        <span>我的帳戶</span>
                        <li><a href="<%=request.getContextPath()%>/member/my_account.jsp">會員中心</a></li>
                        <li><a href="<%=request.getContextPath()%>/member/update.jsp">會員資料修改</a></li>
                        <li><a href="<%=request.getContextPath()%>/member/orders_history.jsp">訂單查詢</a></li>
                        <li><a href=#>常見問與答</a></li>
                        <li><a href=#>客服詢問</a></li>
                    </ul>
                </section>
            </aside>
            <section class="section-shopping-cart orders">
                <h1><span style="font-weight: 400">Order Tracking</span> 訂單查詢</h1>

                <div class="cart-title v-align mh992">
                    <div class="col-md-9">
                        <div class="col-md-2">訂單編號</div>
                        <div class="col-md-3">訂單成立時間</div>
                        <div class="col-md-3">付款方式</div>
                        <div class="col-md-2">貨運方式</div>
                        <div class="col-md-2"></div>
                    </div>
                    <div class="col-md-3">
                        <div style="margin-left: 10px;" class="col-md-6">總金額</div>
                    </div>
                </div>

                <div class="cart-wrap">
                    <% for (Order order : list) {%>
                    <div class="cart-item-list">
                        <div class="block col-md-9 col-xs-12 v-align">
                            <div class="col-md-2 col-xs-12">
                                <span class="tag order-detail">
                                    <a href="order.jsp?orderId=<%= order.getId()%>">
                                        <%= order.getFormatedId()%>
                                    </a>
                                </span>
                            </div>
                            <div class="col-md-3 col-xs-12">
                                <span href="#!" class="order-detail" ><%=order.getOrderDate()%></span>
                            </div>
                            <div class="col-md-3 col-xs-12">
                                <span class="order-detail"><%= order.getPaymentType().getDescription()%></span>
                            </div>
                            <div class="col-md-2 col-xs-12">
                                <span class="order-detail"><%= order.getShippingType().getDescription()%></span>
                            </div>
                            <div class="col-md-2 col-xs-12">
                                <span class="order-detail trial-date"></span>
                            </div>
                        </div>
                        <div class="block col-md-3 col-xs-12 v-align">
                            <div class="col-md-7 col-xs-12">
                                <span class="order-detail"><%= order.getTotalAmount() + order.getPaymentFee() + order.getShippingFee()%> 元</span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </section>
            <%} else {%>
            <p>查無訂單紀錄!</p>
            <%}%>
             <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
