<%-- 
    Document   : order
    Created on : 2019/4/6, 上午 01:16:13
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.OrderItem"%>
<%@page import="uuu.mmd.model.OrderService"%>
<%@page import="uuu.mmd.entity.Order"%>
<%@page import="uuu.mmd.entity.Customer"%>
<%@page import="uuu.mmd.entity.Outlet"%>
<%@page import="uuu.mmd.entity.Product"%>
<%@page import="uuu.mmd.entity.CartItem"%>
<%@page import="uuu.mmd.entity.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>訂單明細</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入top-button.css-->
        <link href="<%= request.getContextPath()%>/style/top-button.css" rel="stylesheet" type="text/css"/>
        <style>
            body{
                background:#f2f2f2;
            }
            h2{
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 500;
                font-size: 2.6rem;
                letter-spacing: .08em;
                text-align: center;
                margin-bottom: 50px;
            }
            .cart-item-session{
                width: 1036px;
                margin: 0 auto;
            }
            .cart-item-session h1{
                float: left;
                font-family: 'Playfair Display',Georgia,'PingFang TC','Hiragino Sans GB','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 300;
                font-size: 1.9rem;
            }
            .cart-wrap h4 {
                clear: both;
                text-align: left;
                background: #eaeaea;
                margin: 0;
                padding: 1em;
                letter-spacing: .1em;
                font-weight: normal;
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-size: .8em;
                border-top: 1.5px solid #555;
            }
            .cart-wrap .row {
                padding: 10px 0;
            }
            .cart-wrap div > div {
                line-height: 2.2em;
            }
            .v-align div{
                letter-spacing: .1rem;
                font-weight: 300;
                display: inline-block;
                vertical-align: middle;
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
            }
            .cart-title {
                padding: 1em 0;
                height: 32px;
            }
            .cart-title div{
                font-weight: 400;
            }
            .row {
                margin-right: -15px;
                margin-left: -15px;
            }
            .section-shopping-cart h1{
                margin-top: 50px;
            }
            .list div{
                font-size: 13px;
                margin-top: 59px;
                margin-left: 100px;
            }
            .inner{
                border-bottom: 1px solid #ccc;
                height: 150px
            }
            .recipient{
                font-size: 13px;
                line-height: 2em;
            }
            .wrapper {
                width: 1200px;
                margin: 0 auto;
                margin-right: 7px;
                margin-bottom: 30px;
            }
            .section-shopping-step > div {
                border-right: 1px solid #fff;
            }
            .steps {
                background: #a2a2a2;
                color: #fafafa;
                padding: 1em;
                position: relative;
                padding: .7em .5em .7em 1em;
            }
            .steps > div, p.warning1.txt-left {
                display: inline-block;
                font-size: .8125em;
            }
            .steps > div:first-child span {
                font-family: 'Trajan Pro','Times New Roman',Georgia;
                font-style: italic;
                font-size: 33px;
                font-weight: normal;
            }
            .steps.active > div:nth-child(2) span:nth-child(2) {
                color: #cfc1af;
                ont-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 300;
            }
            .steps > div:nth-child(2) span:nth-child(2) {
                font-size: .75em;
                text-transform: uppercase;
            }
            .steps > div:nth-child(2) span {
                display: block;
                margin: .2em;
                letter-spacing: .1em;
            }
        </style>
        <script>
            $(document).ready(init);
            function init() {
                $("#copy-info").click(copyInfoHeadler);
            }

            function copyInfoHeadler() {
                var name = $("#sender-name").val();
                var email = $("#sender-email").val();
                $("#recipient-name").val(name);
                $("#recipient-email").val(email);
            }
        </script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <%
            Customer member = (Customer) session.getAttribute("member");
            Order order = (Order) request.getAttribute("order");
            String orderId = request.getParameter("orderId");
            if (order == null && orderId != null) {
                OrderService service = new OrderService();
                order = service.searchOrderById(orderId);
                if (order != null && !order.getMember().equals(member)) {
                    order = null;
                }
            }
        %>
        <article>
            <%  if (order != null) {%>
            <div>
                <h2>SUCCESS!</h2>
            </div>
            <section class="section-shopping-step wrapper">
                <div style="background: #A49178;" class="col-md-3 steps">
                    <div>
                        <span>1.</span>
                    </div>
                    <div>
                        <span style="font-size: 13px">確認購物清單</span>
                        <span style="font-size: 12px;color:#CFC1AF">shopping cart</span>
                    </div>  
                    <i style="font-size: 0.8em;position: absolute;right:2em;top:2.5em" class="fa fa-check"></i>
                </div>
                <div style="background: #A49178;" class="col-md-3 steps">
                    <div>
                        <span>2.</span>
                    </div>
                    <div>
                        <span style="font-size: 13px">選擇付款方式</span>
                        <span style="font-size: 12px;color:#CFC1AF">choose payment</span>
                    </div>            
                    <i style="font-size: 0.8em;position: absolute;right:2em;top:2.5em" class="fa fa-check"></i>
                </div>
                <div style="background: #A49178;" class="col-md-3 steps">
                    <div>
                        <span>3.</span>
                    </div>
                    <div>
                        <span style="font-size: 13px">完成訂購</span>
                        <span style="font-size: 12px">final confirm</span>
                    </div>            
                    <i style="font-size:0.8em;position: absolute;right:2em;top:2.5em" class="fa fa-check"></i>
                </div>
            </section>
            <section class="cart-item-session">
                <h1>ORDER COMPLETE&nbsp;&nbsp;恭喜您，完成訂購!</h1>
                <session class="cart-wrap">
                    <h4><span>訂單編號：<%= order.getFormatedId()%></span>&nbsp;&nbsp;<span style="text-transform:uppercase">會員帳號：<%= order.getMember().getEmail()%></span></h4>

                    <div class="row v-align">
                        <div class="form-group col-md-6 col-xs-12">
                            <div>訂單日期：</div>
                            <div style="font-weight:400"><%= order.getOrderDate()%></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>出貨日期：</div>
                            <div>無</div> 
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>處理狀態：</div>
                            <div><font color="#e28e8c"><%= order.getStatusString() %></font></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>送貨方式： </div>
                            <div><%= order.getShippingType().getDescription() %></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>付款方式：</div>
                            <div style="font-weight:400"><%= order.getPaymentType().getDescription()%></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>運費：</div>
                            <div style="font-weight:400">NT$<%= order.getShippingFee()%><span style="font-weight:300">元</span></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>購買件數：</div>
                            <div style="font-weight:400"> <%= order.getTotalQuantity()%> <span style="font-weight:300">件</span></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>手續費：</div>
                            <div style="font-weight:400">NT$<%= order.getPaymentFee()%><span style="font-weight:300">元</span></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>產品金額：</div>
                            <div style="font-weight:400">NT$<%= order.getTotalAmount()%> <span style="font-weight:300">元</span></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>應繳金額總計：</div>
                            <div style="font-weight:400">NT$<%= order.getTotalAmount() + order.getPaymentFee() + order.getShippingFee()%><span style="font-weight:300">元</span></div>
                        </div>
                    </div>
                    <%  if (order.getOrderItemSet().size() > 0) {%>
                    <session class="section-shopping-cart">
                        <h1>ORDER LIST&nbsp;&nbsp;購買明細資料</h1>
                        <div class="cart-title row v-align list">
                            <div>尺寸</div>
                            <div>顏色</div>
                            <div>訂單數</div>
                            <div style="margin-left:180px">單價</div>
                            <div style="margin-left:130px">小計</div>
                        </div>
                    </session>
                    <div style="margin-top: 70px;width:1036px;border-top:1px solid #555;">
                        <% for (OrderItem item : order.getOrderItemSet()) {%>
                        <div class="cart-title v-align list inner">
                            <div style="float:left;display:flex;flex-direction:column;margin-left:10px;width:250px;margin-top:50px">
                                <span style="line-height:0.9em;color:#96866F">#<%=item.getProduct().getId() %></span> 
                                <span style=""><%=item.getProduct().getName() %></span> 
                            </div>
                            <div style="margin-left:83px;width:20px"><%=item.getSize() %></div>
                            <div style="margin-left:100px;width:98px"><%=item.getColor() %></div>
                            <div style="margin-left:48px"><%=item.getQuantity() %></div>
                            <div style="margin-left:175px">NT.<%=item.getPrice() %></div>
                            <div style="margin-left:90px">NT.<%=item.getPrice() * item.getQuantity() %></div>
                        </div>
                        <% }%>
                    </div>
                </session>
                <session class="section-shopping-cart">
                    <h1 style="margin-top:30px">DELIVERY DETAIL&nbsp;&nbsp;配送與收件人資訊</h1>
                    <div style="margin-top:-40px" class="cart-title row v-align list"></div>
                </session>
                <div style="margin-top: 70px;height:200px;width:1036px;border-top:1px solid #555;">
                    <div style="margin-top:30px" class="row v-align recipient">
                        <div class="form-group col-md-6 col-xs-12 re">
                            <div>收件人姓名：</div>
                            <div style="font-weight:400"><%= order.getRecipientName()%></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>收件人信箱：</div>
                            <div style="font-weight:400"><%= order.getRecipientEmail()%></div> 
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>收件人手機：</div>
                            <div style="font-weight:400"><%= order.getRecipientPhone()%></div>
                        </div>
                        <div class="form-group col-md-6 col-xs-12">
                            <div>收件人地址： </div>
                            <div style="font-weight:400"><%= order.getShippingAddress()%></div>
                        </div>
                    </div>
                </div>
                </session>
            </section>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
            <%}%>
            <%} else {%>
            <p>查無此訂單</p>
            <%}%>  
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
