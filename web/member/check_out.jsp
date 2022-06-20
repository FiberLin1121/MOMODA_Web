<%-- 
    Document   : check_out
    Created on : 2019/4/2, 上午 01:16:13
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.ShippingType"%>
<%@page import="uuu.mmd.entity.PaymentType"%>
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
        <title>結帳作業</title>
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
            .cart-item-list{
                border-bottom: 1px solid #ccc;
                height: 200px;
                clear: both;
            }
            .cart-title{
                margin-top: 22px; 
                margin-left: 384px;
                display: flex;
                flex-direction: row;
                justify-content:space-around;
                align-items:center;
                width: 710px;
            }
            .inner-cart-item-list{
                margin: 22px 0; 
                height: 133px;
                display: flex;
                flex-direction: row;
            }
            .col-1{
                justify-content: center;
                display: flex;
                flex-direction: column;
            }
            .col-1 span{
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 300;
                letter-spacing: .1em;
                font-size: 1.3rem;
            }
            .col-2-outer{
                display: flex;
                flex-direction: row;
                margin-left: 70px;
                align-items: center;
            }
            .col-2{
                width: 100px;
                height: 100px;
                margin-left: 50px;
            }
            .col-2-1 div{      
                text-align: center;
                line-height:100px;
            }
            .total-amount{
                /*border-bottom: 1px solid #ccc;*/
                width: 1036px;
                height: 180px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
            }
            #total-amount-comtent1{
                width: 500px;
                display: flex;
                flex-direction: column;
            }
            #total-amount-comtent2{
                margin-left: 180px;
                width: 130px;
            }
            #total-amount-comtent3{
                width: 100px;
            }
            #total-amount-comtent1 span{
                padding-left: 1em;
                text-indent: -1em;
                word-wrap: break-word;
                word-break: break-all;
                text-align: justify;
                display: block;
                font-family: inherit;
                line-height: 1.9em;
                top: -1em!important;
                font-weight: 300;
                vertical-align: middle;
                color: #666;
                font-size: .825em;
            }
            .button{
                float: right;
                border: none;
                width: 20%;
                height: 45px;
                background-color: #333;
                color: #f2f2f2;
                font-size: 14px;
                margin-top: 15px;
                margin-right: 10px;
                font-family: Lato,'PingFang TC', 'Hiragino Sans GB', 'Microsoft JhengHei', 'Helvetica Neue', icomoon, serif,sans-serif;
            }
            #goHOME{
                float: right;
                margin-top: 27px;
                margin-right: 25px;
                color: #333;
                letter-spacing: .09em;
                font-size: 13px;
                text-decoration:none;
            }
            #goHOME:hover{
                color: #96866F;
            }
            .paymentType-session select{
                width: 180px;
                height: 40px;
                border-radius : 3px;
                border: 0.5px solid #ccc;
                margin-top: 35px;
            }
            input{
                width: 180px;
                height: 35px;
                border-radius : 3px;
                border: 0.5px solid #ccc;
                padding: 0 5px;
            }
            .shipping-info{
                margin-top: 10px;
                padding-bottom: 40px;
                border-bottom: 1px solid #ccc;
            }
            label{
                margin-right:6px;
                font-weight: 300;
                letter-spacing: 0.1em;
            }
            legend {
                display: block; 
                padding: 10px; 
                margin-bottom: 20px;
                font-size: 20px;
                line-height: 0;
                color: #333;
                border: 0; 
            }
            .myTest{
                padding:10px;
                border:1px dashed #666;
                width: 400px
            }
            .myLegend{
                width:80px;
            }
            #copy-info{
                width: 75px;
                height: 20px;
                font-size: 12px;
                margin-left: 5px;
            }
            #total-amount-comtent2 div{
                text-align:center;
                font-size:1em;
                letter-spacing: .1em;
                font-family: Lato,'PingFang TC', 'Hiragino Sans GB', 'Microsoft JhengHei', 'Helvetica Neue', icomoon, serif,sans-serif;
            }
            .wrapper {
                width: 1200px;
                margin: 0 auto;
                margin-right: 7px;
                margin-bottom: 30px;
            }
            .steps.active, .btn.btn-pick-store {
                color: #fff;
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
                var phone = $("#sender-phone").val();
//                var address = $("#sender-address").val();
                $("#recipient-name").val(name);
                $("#recipient-email").val(email);
                $("#recipient-phone").val(phone);
//                $("#recipient-address").val(address);
            }

            function changeShippingOption() {
                var shipping = $("#paymentType>option:selected").attr("data-shipping");
//                console.log(shipping);
                if (shipping !== undefined && shipping.length > 0) {
                    var shippingArray = shipping.split(",");
                    var options = $("#shippingType option");
                    $.map(options, function (option) {
                        $(option).attr("disabled", true);
                    });
                    for (i = 0; i < shippingArray.length; i++) {
                        $("#shippingType>option[value='" + shippingArray[i] + "']").attr("disabled", false);
                    }
                    $("#shippingType>option[value='']").attr("disabled", false);
                    $("#shippingType").val("${param.shippingType}");
                }
                calculateFee();
            }

            function calculateFee() {
                var paymentFee = parseFloat($("#paymentType>option:selected").attr("data-fee"));
                var shippingFee = parseFloat($("#shippingType>option:selected").attr("data-fee"));
                var totalAmount = parseFloat($("#totalAmount").text());
                console.log(paymentFee, shippingFee, totalAmount);
                if (totalAmount > 1500) {
                    $("#totalAmountWithFee").text((isNaN(paymentFee) ? 0 : paymentFee) + totalAmount);
                    $("#isfree").val("true");
//                     console.log($("#isfree").val());
                }else{
                    $("#totalAmountWithFee").text((isNaN(paymentFee) ? 0 : paymentFee) + (isNaN(shippingFee) ? 0 : shippingFee) + totalAmount);
                }
                    
            }

            function shippingChange() {
                var width = parseFloat($("#recipient-phone").css("width"));
//                console.log(width);

                $("#recipient-address").removeAttr("list");
                $("#recipient-address").removeAttr("autocomplete");
                $("#recipient-address").removeAttr("placeholder");
                $("#recipient-address").attr("readonly", false);
                $("#recipient-address").css("width", width);
                $("#storeButton").css("display", "none");
                $("#storeButton").css("width", width - 100);
                $("#recipient-address").val("");
                if ($("#shippingType").val() == "<%= ShippingType.SHOP.name()%>") {
                    $("#recipient-address").attr("placeholder", "請選擇門市");
                    $("#recipient-address").css("width", width + 120);
                    $("#recipient-address").attr("list", "shopList");
                    $("#recipient-address").attr("autocomplete", "off");
                } else if ($("#shippingType").val() == "<%= ShippingType.STORE.name()%>") {
                    $("#recipient-address").attr("readonly", true);
                    $("#recipient-address").attr("placeholder", "請按右邊的按鈕選擇超商");
                    $("#recipient-address").css("width", width);
                    $("#storeButton").css("display", "inline");
                } else {
                    $("#recipient-address").attr("placeholder", "請輸入收件地址");
                }
                calculateFee();
            }

            function changeSize() {
                var width = parseFloat($("#recipient-phone").css("width"));
                if ($("#shippingType").val() == "<%= ShippingType.STORE.name()%>") {
                    $("#recipient-address").css("width", width - 77);
                } else {
                    $("#recipient-address").css("width", width);
                }
            }

            $(function () {
                changeShippingOption();
            });

        </script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <article>
            <%
                ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
            %>
            <%if (cart != null && !cart.isEmpty()) {%>

            <div>
                <h2>CHECK OUT</h2>
            </div>
            <section class="section-shopping-step wrapper">
                <div style="background: #A49178;" class="col-md-3 col-xs-6 steps active">
                    <div>
                        <span>1.</span>
                    </div>
                    <div>
                        <span style="font-size: 13px">確認購物清單</span>
                        <span style="font-size: 12px">shopping cart</span>
                    </div>  
                    <i style="font-size: 0.8em;position: absolute;right:2em;top:2.5em" class="fa fa-check"></i>
                </div>
                <div style="background: #A49178;" class="col-md-3 col-xs-6 steps">
                    <div>
                        <span>2.</span>
                    </div>
                    <div>
                        <span style="font-size: 13px">選擇付款方式</span>
                        <span style="font-size: 12px;color:#CFC1AF">choose payment</span>
                    </div>            
                    <i style="font-size: 0.8em;position: absolute;right:2em;top:2.5em" class="fa fa-check"></i>
                </div>
                <div class="col-md-3 col-xs-6 steps">
                    <div>
                        <span>3.</span>
                    </div>
                    <div>
                        <span style="font-size: 13px">完成訂購</span>
                        <span style="font-size: 12px">final confirm</span>
                    </div>            
                    <i style="font-size:1em;position: absolute;right:2em;top:2.2em" class="fa fa-check-circle"></i>
                </div>
            </section>
            <section class="cart-item-session">
                <h1>YOUR CART 購物清單</h1>
                <div class="cart-title">
                    <div>折扣</div>
                    <div>價格</div>
                    <div style="margin-left: 10px">數量</div>
                    <div>小計</div>
                </div>
                <div style="width: 1036px;border-bottom: 2px solid #555;margin-bottom: 20px;margin-top: 10px"></div>
                <form id="cartForm" method="POST" action="check_out.do">
                    <input type="hidden" id="isfree" name="isfree" value="false">
                    <%
                        for (CartItem item : cart.getCartItemSet()) {
                            Product p = item.getProduct();
                    %>
                    <div class="cart-item-list">
                        <div class="inner-cart-item-list">
                            <a href="<%=request.getContextPath()%>/product.jsp?productId=<%= p.getId()%>">
                                <img src="<%=request.getContextPath() + "/" + p.getColor().getMain_photoUrl()%>" style="width:103.6px;margin-right: 15px">
                            </a>
                            <div class="col-1" style="width: 185.9px">
                                <span style="color:#96866F">#<%=p.getId()%></span>
                                <span style="font-weight: 400"><%= p.getName()%></span>
                                <span style="font-weight: 400">COLOR:<%=item.getColor()%>&nbsp;&nbsp;|&nbsp;&nbsp;SIZE:<%=item.getSize()%></span>
                            </div>
                            <div class="col-2-outer">
                                <div class="col-2 col-2-1">
                                    <%if (p instanceof Outlet) {%>
                                    <div style=" letter-spacing:0.2em"><%=p.getActivity() != null ? p.getActivity() : ""%></div>
                                </div>
                                <div class="col-2" style="margin-left:80px;text-align: center;">
                                    <div style="margin-top:30px">
                                        <del style="color: #999999">NT.<%= ((Outlet) p).getListPrice()%> 元</del>
                                        <%} else {%>
                                        <div style=" letter-spacing:0.2em"></div>
                                    </div>
                                    <div class="col-2" style="margin-left:80px;text-align: center;">
                                        <div style="margin-top:30px">
                                            <%}%>
                                            <%if (p instanceof Outlet) {%>
                                            <div style="color: #CC6C7C">NT.<%= p.getUnitPrice()%> 元</div>
                                            <%} else {%>
                                            <div style="color: #CC6C7C;margin-top: 45px">NT.<%= p.getUnitPrice()%> 元</div>
                                            <%}%>
                                        </div>
                                    </div>
                                    <div class="col-2" style="margin-left:80px">
                                        <div style="text-align: center;margin-top:40px"><%= cart.getQuantity(item)%></div>
                                    </div>
                                    <div class="col-2">
                                        <div style="text-align: right;margin-top:40px;margin-right: 15px;">NT.<%= cart.getProductAmount(item)%></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>
                    <session class="total-amount">
                        <div id="total-amount-comtent1">
                            <% if (Integer.parseInt(cart.getTotalAmount()) > 1500) {%>
                            <span class="total-txt" style="margin-top:31px;font-size:1em;letter-spacing:.1em;font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;">
                                您購買的商品總金額已超過<strong style="color:#96866F"> 1500 </strong>元，達免運門檻</span>
                                <%} else {%>
                            <span class="total-txt" style="margin-top:31px;font-size:1em;letter-spacing:.1em;font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;">
                                再消費<strong style="color:#96866F"> <%=1500 - Integer.parseInt(cart.getTotalAmount())%> </strong>元，就可享免運囉!</span>
                                <%}%>
                        </div>
                        <div id="total-amount-comtent2">
                            <div style="margin-top:31px;color:#999999">商品總金額</div>
                            <div style="margin-top:20px"><small>(含付款/物流手續費)</small>應付總金額</div>
                        </div>
                        <div id="total-amount-comtent3">
                            <div style="margin-top:28px;margin-left:25px;text-align:center;font-size:1.2em;color: #999999"><span style="font-size:0.6em">NT.</span><span id="totalAmount"><%= cart.getTotalAmount()%></span></div>
                            <div style="margin-top:28px;text-align:center;font-size:1.8em"><span style="font-size:0.6em">NT.</span><span id="totalAmountWithFee"><%= cart.getTotalAmount()%></span></div>
                        </div>
                    </session>
                    <section class="paymentType-session" style="height: 190px;">
                        <h1>DELIVERY 選擇配送方式</h1>
                        <div style="width: 1036px;border-bottom: 2px solid #555;padding-bottom: 50px;margin-top: -20px"></div>
                        <div>
                            <label style="margin-right:11px">1. 請選擇付款方式</label>
                            <select name="paymentType" id="paymentType" required onchange="changeShippingOption()">
                                <option value="">--請選擇--</option>
                                <% for (PaymentType pType : PaymentType.values()) {
                                        String shipping = "";
                                        for (ShippingType shType : pType.getShippingTypeArray()) {
                                            if (shipping.length() > 0) {
                                                shipping += ",";
                                            }
                                            shipping += shType.name();
                                        }
                                %>
                                <option value="<%= pType.name()%>" <%= pType.name().equals(request.getParameter("paymentType")) ? "selected" : ""%>
                                        data-fee="<%= pType.getFee()%>" data-shipping="<%= shipping%>">
                                    <%= pType%>
                                </option>
                                <% } %>
                            </select>
                            <label disable style="margin-left:80px;margin-right:11px">2. 請選擇送貨方式</label>
                            <select name="shippingType" id="shippingType" required onchange="shippingChange()">
                                <option value="">--請選擇--</option>
                                <% for (ShippingType shType : ShippingType.values()) {%>
                                <option value="<%= shType.name()%>" <%= shType.name().equals(request.getParameter("shippingType")) ? "selected" : ""%>data-fee="<%= shType.getFee()%>"><%= shType%></option>
                                <%}%>
                            </select>
                        </div>
                    </section>
                    <session class="shipping-info-session" >
                        <h1>SHIPPING INFORMATION 填寫資料</h1>
                        <div style="width: 1036px;border-bottom: 2px solid #555;padding-bottom: 70px;margin-top: -20px"></div>
                        <span style="margin-left:20px;font-size:1.1em;line-height:50px">${requestScope.errors}</span>
                        <div class="shipping-info">
                            <fieldset class="myTest" style="float: left">
                                <legend class="myLegend">訂貨人</legend>
                                <label>姓名*</label><br>
                                <input id="sender-name" type="text" readonly value="<%= ((Customer) session.getAttribute("member")).getName()%>"><br>
                                <label style="margin-top: 10px">電子信箱*</label><br>
                                <input id="sender-email" type="text"  readonly value="<%= ((Customer) session.getAttribute("member")).getEmail()%>"><br>
                                <label style="margin-top: 10px">行動電話*</label><br>
                                <input id="sender-phone" type="text" required><br>
                                <label style="margin-top: 10px">地址(選填)</label><br>
                                <input id="sender-address" style="width: 350px;margin-bottom: 30px" type="text"><br>
                            </fieldset>
                            <div style="width:100px;height:50px;float:left"></div>
                            <fieldset class="myTest">
                                <legend class="myLegend" style="width:180px;padding:0">&nbsp;&nbsp;收件人<button id="copy-info" type="button">同訂貨人</button></legend>
                                <label>姓名*</label><br>
                                <input id="recipient-name" type="text" name="name" value="${empty param.name?"":param.name}" required><br>
                                <label style="margin-top: 10px">電子信箱*</label><br>
                                <input id="recipient-email" type="text" name="email" value="${empty param.email?"":param.email}" required><br>
                                <label style="margin-top: 10px">行動電話*</label><br>
                                <input id="recipient-phone" type="text" name="phone" value="${empty param.phone?"":param.phone}" required><br>
                                <label style="margin-top: 10px">收件地址*</label><br>
                                <input id="recipient-address" style="width: 350px;margin-bottom: 30px" type="text" name="address" value="${empty param.address?"":param.address}" required>
                                <input type="button" value="選擇超商" style="display:none" id="storeButton" onclick="goEzShip()"><br>
                                <datalist id="shopList">
                                    <option value="敦南門市-台北市大安區敦化南路161巷4號">
                                    <option value="南西門市-台北市中山區南京西路23巷3號">
                                </datalist>
                            </fieldset>
                        </div>
                    </session>
                    <div style="clear: both;width: 10px;height: 10px"></div>
                    <input style="letter-spacing: 0.1em;border-radius : 0;" type="submit" name="submit" value="送出訂單" class="button">
                    <a id="goHOME" href="<%=request.getContextPath()%>/member/cart.jsp"> ‹ BACK 上一步</a>
                    <div style="clear: both;width: 10px;height: 50px"></div>
                </form>
                <script>
                    function goEzShip() {
                        $("#recipient-name").val($("#recipient-name").val().trim());
                        $("#recipient-email").val($("#recipient-email").val().trim());
                        $("#recipient-phone").val($("#recipient-phone").val().trim());
                        $("#recipient-address").val($("#recipient-address").val().trim());
                        var protocol = "<%= request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/"))%>";
                        var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
                        var url = protocol + "://" + ipAddress + ":" + location.port + "<%= request.getContextPath()%>/member/ez_ship_callback.jsp";
                        $("#rtURL").val(url);
                        $("#webPara").val($("#cartForm").serialize());

//                        alert(url);
                        alert($("#webPara").val());
//                        alert($("#cartForm").serialize());

                        $("#ezForm").submit();
//                        alert($("#cartForm").serialize());
                    }
                </script>
                <form method="post" action="http://map.ezship.com.tw/ezship_map_web.jsp" id="ezForm">
                    <input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 這裡可以隨便寫 -->
                    <input type="hidden" name="processID" value="VGB201804230000005"> <!-- 購物網站自行產生之訂單編號, 這裡可以隨便寫 -->
                    <input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->            
                    <input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->            
                    <input type="hidden" name="rtURL" id="rtURL" value=""><!-- 回傳路徑及程式名稱 -->
                    <input type="hidden" id="webPara" name="webPara" value=""><!-- 我們網站所需的原Form Data。ezShip會將原值回傳，供我們網站帶回畫面用 -->
                </form>  
                <%} else {%>
                <p style="margin: 200px auto;letter-spacing: 0.2em">您的購物車是空的，請回到<a style="color:#E6B0AA;font-weight: 600" href="<%= request.getContextPath()%>/product_list.jsp"> 賣場購物</a></p>
                <%}%>
            </section>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
