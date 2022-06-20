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
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入aside_menu.css-->
        <link href="<%= request.getContextPath()%>/style/aside_menu.css" rel="stylesheet" type="text/css"/>
        <!--引入top-button.css-->
        <link href="<%= request.getContextPath()%>/style/top-button.css" rel="stylesheet" type="text/css"/>
        <style>
            article {
                /*height: 3150px;*/
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
                font-weight: 300;
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
                text-decoration: none;
            }
            .block-01 p a:hover{
                padding-bottom: 3px;
                border-bottom: 1px solid #cc6c7c; 
            }
            .effect{
                animation: blink 1s infinite;
            }
            /*定義blink動畫*/
            @keyframes blink{
                0%{opacity:0}
                50%{opacity:1}
                100%{opacity:0}
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
            .collocation-Box:hover{
                background: #f2e7de;
            }
            .product-photos_slider span{
                font-size: 1.5em;
                font-weight: bold;
                margin: 5px;
            }
            #collocationDetail{
                width: 80%;
            }
            .blue{
                color:#68c2ce;
                border: 1px solid #66b8cc;
            }
            .blue:hover{
                background: #66b8cc;
                color: #fcfcfc;
            }
        </style>
        <script>
            $(document).ready(init);
            function init() {
                $(".size-button").click(borderHandler);
                $(".color-button").click(borderHandler);

                $(".size-button").click(getStock);
            }

            function borderHandler() {
                $(this).addClass("border");
                $(this).siblings().removeClass("border");
            }

            function getCollocationId(cid) {
                //同步GET請求
                location.href = "product.jsp?productId=" + cid;
//                 非同步GET請求
//                $.ajax({
//                    url:"product_ajax.jsp?productId=" + cid
//                }).done(getCollocationIdDoneHandler);
            }
//            
//            function getCollocationIdDoneHandler(result, status, xhr){
////                console.log(result);
//               $("#collocationDetail").html(result);
//                $.fancybox.open({
//                    src:"#collocationDetail"
//                });                
//            }
            var p_id;
            var p_color;
            var p_size;
            function changePhoto(pid, color) {
                p_id = pid;
                p_color = color;

                $("#color").val(color);
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
                    url: '${pageContext.request.contextPath}/get_product_stock.jsp?productId=' + p_id + '&color=' + p_color + '&size=' + p_size
                }).done(getStockDoneHandler);
            }

            function getStockDoneHandler(result) {
                var stock = parseInt(result);
                if (stock > 0) {
                    $("#quantity").attr("min", 1);
                    $("#quantity").attr("max", stock);
                    $("#quantity").val(1);
                    $("#AddToCart_button").val("加入購物車");
                    $("#AddToCart_button").removeClass("blue");
                } else {
                    $("#quantity").attr("min", 0);
                    $("#quantity").attr("max", 0);
                    $("#quantity").val("");
                    $("#quantity").attr("placeholder", "已無庫存");
                    $("#AddToCart_button").val("貨到通知我");
                    $("#AddToCart_button").addClass("blue");
                }
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
                p_size = size;
                $("#size").val(size);
            }


            function addCart() {
//                alert($(".Quantity-form").serialize());
//                if (!validate()) {
//                    return false;
//                }
                var valid = validate();
                console.log(valid);
                if (valid) {
                    var url = $(".Quantity-form").attr("action");
                    var method = $(".Quantity-form").attr("method");
                    alert("商品已加入購物車");

//                console.log(url, method);
                    $.ajax({
                        url: url,
                        method: method,
                        data: $(".Quantity-form").serialize() //序列化
                    }).done(addCartDoneHandler);
                }
            }
            //小購物車動態更新購買數量
            function addCartDoneHandler(result, status, xhr) {
//                alert(result);
                $("#cart-countshow").html(result);
            }

            function validate() {
                var min = parseInt($("#quantity").attr("min"));
                var max = parseInt($("#quantity").attr("max"));
                if (min == 0 && max == 0) {
                    alert("此產品已無庫存，無法加入購物車!");
                    return false;
                }
                var value = parseInt($("#quantity").val());
                var colorInput = $("#color").val();
                var sizeInput = $("#size").val();
                console.log(min, max, value, colorInput, sizeInput);
                var message = "請";
                var isCorrect = true;

                if (!colorInput) { //如果顏色有值的話(true)
                    isCorrect = ($(colorInput).val() != undefined);
//                    alert(colorInput);
                    if (!isCorrect) {
                        message += "選擇顏色";

                    }
                }
                if (!sizeInput) { //如果尺寸的值有的話(true)
                    isCorrect = ($(sizeInput).val() != undefined);
//                    alert(sizeInput);
                    if (!isCorrect) {
                        if (message != "請")
                            message += "和";
                        message += "選擇尺寸";
                    }
                }
                if (isNaN(value) || value < min || value > max) { //如果數量的值不是數字
                    isCorrect = isCorrect && (value >= min && value <= max);
                    if (message != "請")
                        message += "和";
                    message += "輸入正確的數量(" + min + "~" + max + ")";
                }

                if (!isCorrect) {
                    alert(message);
                }
                return (isCorrect);
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
        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <!---------------------------------------------article------------------------------------------------------>
        <article>
            <%@include file="/WEB-INF/subviews/aside-menu.jsp"  %>
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
                <div class="collocation">
                    <% if (p.getColor().getCollocation_photoUrl() != null) {%>
                    <p>〃COMPLETE&nbsp;&nbsp;YOUR&nbsp;&nbsp;LOOK〃</p>
                    <h4>單品搭配推薦</h4>
                    <div class="product-photos_slider">
                        <div id="png-Box" class="collocation-Box">
                            <img src="<%= p.getColor().getPng_photoUrl()%>">
                        </div>
                        <span>+</span>
                        <div id="collocation-Box" class="collocation-Box">
                            <a href="javascript:getCollocationId('<%= p.getColor().getCollocation_id()%>')"><img src="<%= p.getColor().getCollocation_photoUrl()%>"></a>
                        </div>
                    </div>
                </div>
                <%}%>
            </figure>
            <figcaption>
                <section class="block-01">
                    <div class="tag">#<%= p.getId()%></div>
                    <% if (p instanceof Outlet) {%>
                    <div class="tag-a effect">
                        <a>折價品</a>
                    </div>
                    <%}%>
                    <h1><%= p.getName()%></h1>
                    <%if (p instanceof Outlet) {%>
                    <del>NT.<%= (int) ((Outlet) p).getListPrice()%></del>
                    <%}%>
                    <span>NT.<%= p.getUnitPrice()%></span>
                    <p>
                        <a href=#><%=p.getActivity() != null ? p.getActivity() : ""%></a>
                    </p>
                    <div id="hr"></div>
                </section>
                <section class="block-02">
                    <p>
                        <%=p.getDescription().replace("\n", "<br>")%>
                    </p>
                </section>
                <section class="block-03">
                    <div id="color-select">
                        <% for (String colorName : p.getColorKeySet()) {%>
                        <img onclick="changePhoto('<%= p.getId()%>', '<%= colorName%>')" class="color-button" title="<%= colorName%>" src="<%= p.getColor(colorName).getColor_block()%>">
                        <%}%>
                    </div>
                    <div id ="size-box">
                        <%for (Size size : p.getSizeList()) {%>
                        <span onclick="passSizeValue('<%= size%>')" id="<%= size%>" class="size-button"><%= size%></span>
                        <%}%>
                    </div>
                    <form class="Quantity-form" action="add_cart.do" method="POST">
                        <input type="hidden" name="productId" id="productId" value="<%= p.getId()%>">
                        <input type="hidden" name="color" id="color" >
                        <input type="hidden" name="size" id="size" >
                        <label>數量:</label><br>
                        <input type='number' id='quantity' name='quantity' style="width:6em ;padding: 0 1px;font-size: 0.8em" required 
                               min='<%= p.getStock() > 0 ? 1 : 0%>' max='<%= p.getStock() > 10 ? 10 : p.getStock()%>' placeholder="選擇數量"> 


                        <!--                        <select id="quantity" name="quantity">
                                                    <option value="">選擇數量</option>
                        <%for (int i = 1; i <= p.getStock(); i++) {%>
                        <option value="<%=i%>"><%=i%></option>
                        <%}%>
                    </select>-->

                        <input onclick="addCart()" id="AddToCart_button" type="button" name="product_submit" value="加入購物車" class="button">
                    </form>
                    <div class="size-list">尺寸表</div>
                </section>
            </figcaption>
            <%} else {%>
            <p>查無此產品!</p>
            <%}%>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <div id="collocationDetail"></div>
    </div>
    <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</body>
</html>
