<%-- 
    Document   : cart
    Created on : 2019/4/1, 上午 01:16:13
    Author     : fiber
--%>

<%@page import="uuu.mmd.model.ProductService"%>
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
        <title>購物車</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入top-button.css-->
        <link href="<%= request.getContextPath()%>/style/top-button.css" rel="stylesheet" type="text/css"/>
        <style>
            body{
                background:#f2f2f2;
            }
            article{
                /*height: 1600px;*/
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
                /*height: 334px;這裡不能把高度設死,否則內容會長出去蓋住footer*/
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
                border-bottom: 1px solid #ccc;
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
            #goHOME2{
                float: right;
                margin-top: 27px;
                margin-right: 25px;
                color: #333;
                letter-spacing: .09em;
                font-size: 13px;
                text-decoration:none;
            }
            #goHOME2:hover{
                color: #96866F;
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
            .stockShortage{
                border: red 1px solid;
            }
        </style>
        <script>
            function checkQuantity(inputQuantity){
                var min = parseInt($(inputQuantity).attr("min"));
                var max = parseInt($(inputQuantity).attr("max"));
                var quantity = parseInt($(inputQuantity).val());
                if(quantity<min || quantity>max){
                    $(inputQuantity).addClass("stockShortage");
                }else{
                    $(inputQuantity).removeClass("stockShortage");
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <article>
            <%
                Customer member = (Customer)session.getAttribute("member");
                ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
                if(cart!=null && member!=null) cart.setMember(member);
                ProductService service = new ProductService();
            %>
            <%if (cart != null && !cart.isEmpty()) {%>
            <div>
                <h2>CHECK OUT</h2>
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
                <div class="col-md-3 steps">
                    <div>
                        <span>2.</span>
                    </div>
                    <div>
                        <span style="font-size: 13px">選擇付款方式</span>
                        <span style="font-size: 12px">choose payment</span>
                    </div>            
                    <i style="font-size:0.8em;position: absolute;right:2em;top:2.5em" class="fa fa-chevron-right"></i>
                </div>
                <div class="col-md-3 steps">
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
                    <div>刪除</div>
                </div>
                <div style="width: 1036px;border-bottom: 2px solid #555;margin-bottom: 20px;margin-top: 10px"></div>
                <form method="POST" action="update_cart.do">
                    <%
                        for (CartItem item : cart.getCartItemSet()) {
                            Product p = item.getProduct();
                            int stock = service.getProductStock(p.getId(), item.getColor(), item.getSize());
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
                                        <div style="text-align: center;margin-top:40px">
                                            <input <%= stock<cart.getQuantity(item)?"class='stockShortage'":""%> onchange="checkQuantity(this)" 
                                            style="width: 45px" id="quantity" type="number" name="quantity_<%= item.hashCode()%>" min="<%= stock>0?1:0 %>" max="<%= stock>10?10:stock %>" value="<%= cart.getQuantity(item)%>">
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div style="text-align: right;margin-top:40px;margin-right: 22px;">
                                            <input type="checkbox" name="delete_<%= item.hashCode()%>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>
                    <session class="total-amount">
                        <div id="total-amount-comtent1">
                            <span style="margin-top: 30px;">► 請確認您購買的商品尺寸、顏色及數量。確認後訂單將無法進行任何更改喔！</span>
                            <span>► 若您上有其他商品需購買，請點選「<strong style="color: #96866F">繼續購物</strong>」。如果要進行結帳，請點選「<strong style="color: #96866F">下一步</strong>」</span>
                            <span>► 商品售價將以您實際結帳之即時價格為主，商品數量、贈品與優惠等，也將以您實際結賬為準。</span>
                            <span style="margin-left: 2px;"> &nbsp;&nbsp;&nbsp;&nbsp;請儘早完成結帳以確保享有贈品與優惠。</span>
                        </div>
                        <div id="total-amount-comtent2">
                            <div style=" line-height:150px;text-align:center;font-size:1em;letter-spacing: .1em;">商品總金額</div>
                        </div>
                        <div id="total-amount-comtent3">
                            <div style=" line-height:140px;text-align:center;font-size:1.8em"><span style="font-size:0.6em">NT.</span><%= cart.getTotalAmount()%></div>
                        </div>
                    </session>
                    <session>
                        <div style="clear: both;width: 10px;height: 10px"></div>
                        <input style="letter-spacing: 0.1em" type="submit" name="submit" value="NEXT  下一步" class="button">
                        <input style="letter-spacing: 0.1em" type="submit" name="submit" value="確定修改" class="button">
                        <a id="goHOME" href="<%=request.getContextPath()%>/product_list.jsp"> ‹ HOME 繼續購物</a>
                        <div style="clear: both;width: 10px;height: 50px"></div>
                    </session>
                </form>
                <%} else {%>
                <div>
                    <h2>CHECK OUT</h2>
                </div>
                <section class="cart-item-session">
                    <h1>YOUR CART 購物清單</h1>
                    <div class="cart-title">
                        <div>折扣</div>
                        <div>價格</div>
                        <div style="margin-left: 10px">數量</div>
                        <div>刪除</div>
                    </div>
                    <div style="width: 1036px;border-bottom: 2px solid #555;margin-bottom: 20px;margin-top: 10px"></div>
                    <p style="margin: 60px 36%;letter-spacing: 0.2em">您的購物車是空的，請回到<a style="color:#E6B0AA;font-weight: 600" href="../product_list.jsp">賣場購物</a></p>
                    <session class="total-amount">
                        <div id="total-amount-comtent1">
                            <span style="margin-top: 30px;">► 請確認您購買的商品尺寸、顏色及數量。確認後訂單將無法進行任何更改喔！</span>
                            <span>► 若您上有其他商品需購買，請點選「<strong style="color: #96866F">繼續購物</strong>」。如果要進行結帳，請點選「<strong style="color: #96866F">下一步</strong>」</span>
                            <span>► 商品售價將以您實際結帳之即時價格為主，商品數量、贈品與優惠等，也將以您實際結賬為準。</span>
                            <span style="margin-left: 2px;"> &nbsp;&nbsp;&nbsp;&nbsp;請儘早完成結帳以確保享有贈品與優惠。</span>
                        </div>
                        <div id="total-amount-comtent2">
                            <div style=" line-height:150px;text-align:center;font-size:1em;letter-spacing: .1em;">商品總金額</div>
                        </div>
                        <div id="total-amount-comtent3">
                            <div style=" line-height:140px;text-align:center;font-size:1.8em">
                                <span style="font-size:0.6em">NT.</span>0
                            </div>
                        </div>
                    </session>
                    <session>
                        <div style="clear: both;width: 10px;height: 10px"></div>
                        <input style="letter-spacing: 0.1em" type="submit" name="submit" value="NEXT  下一步" class="button">
                        <a id="goHOME2" href="<%=request.getContextPath()%>/product_list.jsp"> ‹ HOME 繼續購物</a>
                        <div style="clear: both;width: 10px;height: 50px"></div>
                    </session>
                </section>
                <%}%>
            </section>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
