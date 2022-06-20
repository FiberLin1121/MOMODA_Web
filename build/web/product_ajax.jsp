<%-- 
    Document   : product
    Created on : 2019/3/21, 下午 11:30:40
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.Size"%>
<%@page import="uuu.mmd.entity.Outlet"%>
<%@page import="uuu.mmd.entity.Product"%>
<%@page import="uuu.mmd.model.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>商品明細</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">    
        <%--<%@include file="/WEB-INF/subviews/global.jsp"  %>--%>
        <!--引入aside_menu.css-->
        <link href="style/aside_menu.css" rel="stylesheet" type="text/css"/>
        <style>
            article {
                height: 3150px;
            }
            .aside-menu{
                position: sticky;
                top: 50px;
                margin-left: 20px;
                width: 347px;
                height: 1199px;
            }
            .p-photo{
                margin-left: 20px;
                margin-right: 20px;
                width: 664px;
                height: 886px;
            }
            #p-main-photo img,#p-detail_photo_1 img,#p-detail_photo_2 img{
                width: 570px;
            }
            figcaption{
                background-color: #fcfcfc;
                margin-right: 100px;
                width:347px; 
                height: 600px;
                position: sticky;
                top: 60px;
            }
            .block-01{
                width: 300px;
                height: 166px;
                background: #fcfcfc;
            }
            .tag{
                color: #999;
                font-size: .75em;
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 400;
            }
            .tag-a a {
                margin-left: 10px;
                padding: 0px 10px 0px 12px;
                background-color: #E1CBAA;
                color: #fff;
                float: left;
                height: 22px;
                line-height: 21px;
                font-size: 11px;
                border-radius: 6px;
            }
            .block-01 .tag {
                top: -.6em;
            }
            .block-01 div {
                display: inline-block;
                position: relative;
            }
            .block-01 h1 {
                font-size: 1.65em;
                display: block;
                line-height: 1.2;
                font-weight: 400;
                margin-top: .5em;
                margin-bottom: 17.6px;
                font-family: 'Playfair Display',PingFangTC-Thin,'Hiragino Sans GB','Droid Sans Fallback','Noto Sans TC','Microsoft JhengHei';
            }
            .block-01 del{
                font-size: .82em;
                font-weight: 400;
                color: #999;
            }
            .block-01 span{
                font-size: 0.9em;
                font-weight: bolder;
                color: #ce687a;
                padding-right: .5em;
            }
            .block-01 p a{
                font-size: .75em;
                line-height: 4em;
                color: #cc6c7c;
                padding-bottom: 0.8px;
                border-bottom: 1px solid #cc6c7c;
                text-decoration: none;
            }
            .block-02{
                margin-top: 23px;
                width: 300px;
                height: 100px;
            }
            .block-02 p{
                font-size: 0.75em;
                font-weight: 500;
                letter-spacing: .08em;
            }
            .block-03{
                width: 300px;
                height: 360px;
            }
            .color-button{
                display: inline-block;
                cursor: pointer;
                width: 31px;
                height: 31px;
                padding: 2.5px;
                margin-right: 5px;
                border: 1px solid lightgrey;
            }
            #size-box{
                margin-top: 10px;
            }
            .size-button{
                font-size: 14px;
                width: 30px;
                height: 21px;
                display: inline-block;
                border: 1px solid #c9c9c9;
                text-align: center;
                line-height: 22px;
                margin-top: 5px;
                margin-right: 7px;
                font-family: arial;
                cursor: pointer;
                padding-left: 5px;
                padding-right: 5px;
            }
            .Quantity-form {
                margin-top: 5px;
                display: inline-block;
            }
            .Quantity-form label,.Quantity-form select,Quantity-form op{
                font-size: 12px;
                font-weight: 500;
                width: 80px;
            }
            .Quantity label{
                margin-bottom: -5px;
            }
            .size-list{
                display: inline-block;
                font-size: 0.7em;
                border-bottom: 1px solid #444; 
                position: relative;
                top: -112px;
                right: -255px;
            }
            .button{
                margin-top: 45px;
                clear: both;
                display: block;
                border: #444 1px solid;
                width: 290px;
                height: 44px;
                background-color: #fcfcfc;
                color: #333;
                line-height: 30px;
                font-size: 16px;
                transition: all 0.6s;
            }
            .button:hover{
                background-color: #444;
                color: white;
            }
            .border{   
                border: 1px solid #444;
            }
            .collocation {
                width:570px;
                height: 270px;
                margin: 20px;
                margin-top: -10px;
            }
            .collocation p{
                font-size: 0.9em;
                text-align: center;
                font-weight: 500;
                padding-bottom: 5px;
                border-bottom: 1px dashed #999;
            }
            .collocation h4{
                font-size: 1.6em;
                text-align: center;
                font-weight: 300;
            }
            .product-photos_slider{
                width: 420px;
                margin: auto;
                padding: 10px;
            }
            .product-photos_slider img{
                margin: 20px auto;
                width: 170px;
                vertical-align: middle;
            }
            .collocation-Box{ 
                display: inline-block;
                border-radius:20px;
                padding: 5px;
                transition: all 0.4s;
            }
            .collocation-Box img{
                max-height: 330px;

            } 
            .collocation-Box:hover{
                background: #f2e7de;
            }
            .product-photos_slider span{
                font-size: 1.5em;
                font-weight: bold;
                margin: 5px;
            }
        </style>
        <script>
            $(document).ready(init);
            function init() {
                $(".size-button").click(borderHandler);
                $(".color-button").click(borderHandler);
            }
            function borderHandler() {
                $(this).addClass("border");
                $(this).siblings().removeClass("border");
            }

            function getCollocationId(cid) {
//                //同步GET請求
//                location.href = "product.jsp?productId=" + cid;

                //非同步GET請求
//                $.ajax({
//                    url:"product_ajax.jsp?productId=" + cid
//                }).done(getProductDoneHandler);
            }

            var prd_id;
            var prd_color;
            var pid_size;
            var prd_quantity;
            function changePhoto(pid, color) {
//                console.log(pid, color);
                prd_id = pid;
                prd_color = color;
                $.ajax({
                    url: "product_photo.jsp?productId=" + pid + "&color=" + color + "&photoId=1"
                }).done(changePhoto1DoneHandler);
                $.ajax({
                    url: "product_photo.jsp?productId=" + pid + "&color=" + color + "&photoId=2"
                }).done(changePhoto2DoneHandler);
                $.ajax({
                    url: "product_photo.jsp?productId=" + pid + "&color=" + color + "&photoId=3"
                }).done(changePhoto3DoneHandler);
                $.ajax({
                    url: "product_photo.jsp?productId=" + pid + "&color=" + color + "&photoId=4"
                }).done(changePhoto4DoneHandler);
                $.ajax({
                    url: "product_photo.jsp?productId=" + pid + "&color=" + color + "&photoId=5"
                }).done(changePhoto5DoneHandler);
            }


            function getStock() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/get_product_stock.jsp?productId=' + prd_id + '&color=' + prd_color
                }).done(getStockDoneHandler);
            }
            function getStockDoneHandler(result){
            var stock = ParseInt(result);
            }
//            function  chaangeCollocation_url(){
//                 $.ajax({
//                    url: "collocation_id.jsp?productId=" + prd_id + "&color=" + prd_color"
//                }).done(changeCollocation_idDoneHandler);
//            }

            function changePhoto1DoneHandler(result) {
//                alert(result.trim());
                $("#p-main-photo img").attr("src", result.trim());
            }

            function changePhoto2DoneHandler(result) {
                $("#p-detail_photo_1 img").attr("src", result.trim());
            }

            function changePhoto3DoneHandler(result) {
                $("#p-detail_photo_2 img").attr("src", result.trim());
            }

            function changePhoto4DoneHandler(result) {
                $("#png-Box img").attr("src", result.trim());
            }
            function changePhoto5DoneHandler(result) {
                $("#collocation-Box img").attr("src", result.trim());
            }

            function passSizeValue(size) {
                prd_size = size;
            }

//            function changeCollocation_urlDoneHandler(result) {
//
//            }

//            function  validateForm() {
//                var x = document.getElementById("quantity").selector[selector.selectedIndex].value;
//                if (x == "") {
//                    alert("請選擇數量");
//                    return false;
//                }
//            }

            function dispatchServletHandler() {
//                prd_quantity = $(".quantity").val(); //錯誤寫法(直接抓option的id的值)
                var selector = document.getElementById("quantity");/*正確寫法:先用id抓到select(選單)*/
                prd_quantity = selector[selector.selectedIndex].value;/*再抓出select(選單)中被selected的option(選項)的值*/
                console.log(prd_id, prd_color, prd_quantity, prd_size);

//            var tmp = document.createElement("form");
//            var action = "add_cart.do?productId=" + prd_id +"&color=" + prd_color + "&quantity=" + prd_quantity + "&size=" + prd_size ;
//            tmp.action = action;
//            tmp.method = "post";
//            document.body.appendChild(tmp);
//            tmp.submit();
//            return tmp;
            }
        </script>
        <%
            String productId = request.getParameter("productId"); //取得前端送的GET請求的資料

            ProductService service = new ProductService();
            Product p = null;
            if (productId != null) {
                p = service.searchProductById(productId);
            }
        %>
    </head>
    <body id="body">
        <%--<jsp:include page="/WEB-INF/subviews/header.jsp" />--%>
        <!---------------------------------------------article------------------------------------------------------>
        <article>
            <%--<%@include file="/WEB-INF/subviews/aside-menu.jsp"  %>--%>
            <!------------------------------------------aside-end---------------------------------------------------->
            <% if (p != null) {%>
            <figure>
                <div id="p-main-photo" class="p-photo">
                    <img src="<%= p.getColor() != null ? p.getColor().getMain_photoUrl() : ""%>">
                </div>
                <div id="p-detail_photo_1" class="p-photo">
                    <img src="<%= p.getColor() != null ? p.getColor().getDetail_photoUrl_1() : ""%>">
                </div>
                <div id="p-detail_photo_2" class="p-photo">
                    <img src="<%= p.getColor() != null ? p.getColor().getDetail_photoUrl_2() : ""%>">
                </div>
            </figure>
            <figcaption>
                <section class="block-01">
                    <div class="tag">#<%= p.getId()%></div>
                    <% if (p instanceof Outlet) {%>
                    <div class="tag-a">
                        <a>特價品</a>
                    </div>
                    <%}%>
                    <h1><%= p.getName()%></h1>
                    <%if (p instanceof Outlet) {%>
                    <del>NT.<%= (int) ((Outlet) p).getListPrice()%></del>
                    <%}%>
                    <span>NT.<%= (int) p.getUnitPrice()%></span>
                    <p><a href=#>早春特惠新品8折</a></p>
                </section>
                <section class="block-02">
                    <p>
                        <%=p.getDescription().replace("\n", "<br>")%>
                    </p>
                </section>
                <section class="block-03">
                    <div id="color-select">
                        <% for (String colorName : p.getColorKeySet()) {%>
                        <img id="color" onclick="changePhoto('<%= p.getId()%>', '<%= colorName%>')" class="color-button" title="<%= colorName%>" src="<%= p.getColor(colorName).getColor_block()%>">
                        <%}%>
                    </div>
                    <div id ="size-box">
                        <%for (Size size : p.getSizeList()) {%>
                        <span onclick="passSizeValue('<%= size%>')" onchange="getStock()" id="<%= size%>" class="size-button"><%= size%></span>
                        <%}%>
                    </div>
                    <form class="Quantity-form">
                        <label>數量:</label><br>
                        <input type='number' id='quantity' name='quantity' style="width:5.8em" required 
                        min='<%= p.getStock()>0?1:0 %>' max='<%= p.getStock()>10?10:p.getStock() %>' placeholder="輸入數量"> 
                            <!--<select id="quantity">
                            <option value="">選擇數量</option>
                            <%for (int i = 1; i <= p.getStock(); i++) {%>
                            <option value="<%=i%>"><%=i%></option>-->
                            <%}%>
                        </select>

                        <input onclick="dispatchServletHandler()" id="AddToCart_button" type="button" name="product_submit" value="加入購物車" class="button">
                    </form>
                    <div class="size-list">尺寸表</div>
                </section>
            </figcaption>
            <%} else {%>
            <p>查無此產品!</p>
            <%}%>
        </article>
        <%--<%@include file="/WEB-INF/subviews/footer.jsp"  %>--%>
    </body>
</html>
