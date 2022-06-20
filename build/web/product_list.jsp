<%-- 
    Document   : product_list
    Created on : 2019/3/19, 上午 01:44:52
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.Outlet"%>
<%@page import="uuu.mmd.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.mmd.model.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>全館商品</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">    
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入aside_menu.css-->
        <link href="<%= request.getContextPath()%>/style/aside_menu.css" rel="stylesheet" type="text/css"/>
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
            /*----------------------------------------------p-list-main-------------------------------------------------------*/
            .p-list-main{
                margin-top: -10px;
                margin-left: 50px;
                width:1100px;
            }
            .p-list-container{
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
            }
            /*----------------------------------------------p-list-title-------------------------------------------------------*/
            .p-list-title{
                width: 1070px;
                height: 47.6px;
            }
            .p-list-title h1{
                display: inline-block;
                margin: 0 0 0 10px;
                font-size: 1em;
                line-height:47.6px;
                font-family: Roboto,'PingFang TC','Hiragino Sans GB','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 300;
                color: #666;
                letter-spacing: .1em;
            }
            /*-----------------------------------------------order_form-------------------------------------------------------*/
            #order_form{
                float: right;
                margin-top: 10px;
                margin-right: 21px;
            }
            select, option{
                height: 30px;
                background: white;
                border: 1px solid #efefef;
                width: 150px;
                font-weight: 300;
                color: #666;
                font-size: 0.9em;
                font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                transition: all 0.2s;
            }
            select:hover{
                border: 1px solid #666;
            }
            /*-----------------------------------------------figure-------------------------------------------------------*/
            figure{
                width: 270px;
                height: 462px;
                margin-bottom: 40px;
                display: flex;
                flex-direction: column;
            }
            .p-item-img{
                width: 237.8px;
                height: 317.06px;
                margin: 0 auto;
                display: inline-block;
                overflow: hidden;
            }
            .p-item-img img{
                width: 237.8px;
                height: 317.06px;
                /*filter: brightness(.95);*/
                transition: all 0.4s;
            }
            .p-item-img img:hover{
                transform: scale(1.08);
                /*遮罩效果:暗變亮*/
                filter: brightness(1.1);
            }
            figcaption{
                width: 237.8px;
                height: 89.6px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                margin: auto;
                margin-top: 15px;
                margin-right: 30px;
                text-align: center;
                line-height: 1.4em;
            } 
            .p-item-title{
                font-size: 1.4rem;
                margin: 5px;
                color: #393132;
                letter-spacing: .05em;
            }
            .p-item-size{
                font-size: 1.5rem;
                color: #888;
                position: relative;
                margin: 0.4em;
            }
            .p-item-price{
                font-size: 1.3rem;
                font-weight: bold;
                color: #ce687a;
                padding-right: .4em;
                line-height: 1.4em;
            }
            .p-item-price del{
                color: #999;
                font-weight: normal;
                font-size: 1.3rem;
            }

            @media screen and (max-width: 1000px) {
                .p-list-container {
                    width: 75%;
                }

            }
            @media screen and (max-width: 800px) {
                .p-list-container {
                    width: 50%;
                }
            }
            @media screen and (max-width: 600px) {
                .p-list-container {
                    width: 25%;
                }
            }
            #officeLady1{
                position:relative;
                width:1048px;
                height:448px;
            }
            .tag{
                position:absolute;
                width:60px;
                height:20px;
                text-align: center;
                line-height: 20px;
                background: rgba(0, 0, 0, 0.6);
                border-radius: 3px;
                color: #fcfcfc;
                font-size: 0.8em;
                display: none;
            }
            #tag1-1{
                left:851px;
                top:61px;
            }
            #cloth1-1:hover~#tag1-1{
                display: block;
            }
            #tag2-1{
                left:845px;
                top:187px;
            }
            #pants1-1:hover~#tag2-1{
                display: block;
            }
            #tag3-1{
                left:658px;
                top:157px;
            }
            #cloth2-1:hover~#tag3-1{
                display: block;
            }
            #tag4-1{
                left:508px;
                top:297px;
            }
            #pants2-1:hover~#tag4-1{
                display: block;
            }
            #tag5-1{
                left:145px;
                top:130px;
            }
            #cloth3-1:hover~#tag5-1{
                display: block;
            }
            #tag6-1{
                left:351px;
                top:218px;
            }
            #pants3-1:hover~#tag6-1{
                display: block;
            }

            #tag1-1{
                left:851px;
                top:61px;
            }
            #cloth1-1:hover~#tag1-1{
                display: block;
            }
            #officeLady2{
                position:relative;
                width:1048px;
                height:606px;
            }
            #tag1-2{
                left:95px;
                top:200px;
            }
            #cloth1-2:hover~#tag1-2{
                display: block;
            }
             #tag2-2{
                left:378px;
                top:195px;
            }
            #cloth2-2:hover~#tag2-2{
                display: block;
            }
            #tag3-2{
                left:245px;
                top:342px;
            }
            #pants2-2:hover~#tag3-2{
                display: block;
            }
            #tag4-2{
                left:425px;
                top:205px;
            }
            #cloth3-2:hover~#tag4-2{
                display: block;
            } 
            #tag5-2{
                left:504px;
                top:320px;
            }
            #pants3-2:hover~#tag5-2{
                display: block;
            }
             #tag6-2{
                left:659px;
                top:246px;
            }
            #cloth4-2:hover~#tag6-2{
                display: block;
            }
            #tag7-2{
                left:694px;
                top:342px;
            }
            #pants4-2:hover~#tag7-2{
                display: block;
            }
            #tag7-2{
                left:694px;
                top:342px;
            }
            #pants4-2:hover~#tag7-2{
                display: block;
            }
            #tag8-2{
                left:755px;
                top:198px;
            }
            #cloth5-2:hover~#tag8-2{
                display: block;
            }
            #tag9-2{
                left:866px;
                top:410px;
            }
            #pants5-2:hover~#tag9-2{
                display: block;
            }
        </style>
        <script>

            function getOrderList(type) {
                var option_value = $("#order_select").val();
//               alert(type);

                if (type != 'null') {
                    location.href = "product_list.jsp?type=" + type + "&order=" + option_value;
//                    alert('not null');
                } else {
                    location.href = "product_list.jsp?order=" + option_value;
//                    alert('is null');
                }
            }
        </script>
    </head>        
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <!---------------------------------------------article------------------------------------------------------>
        <article>
            <%@include file="/WEB-INF/subviews/aside-menu.jsp"  %>
            <!-------------------------------------------p-list-main----------------------------------------------------->
            <%  /*分類查詢*/
                //部分名稱查詢
                String search = request.getParameter("search");
                //服飾類型查詢
                String type = request.getParameter("type");
                //穿搭主題查詢
                String outfit = request.getParameter("outfit");
                //新品(一周內上架)查詢
                String launchDate = request.getParameter("launch_date");

                /*排序查詢*/
                String order = request.getParameter("order");

                ProductService service = new ProductService();
                List<Product> list = null;

                if (search != null && search.length() > 0) {
                    list = service.searchProductsByName(search);
                    //分類查詢+排序
                } else if (type != null && type.length() > 0 && order != null && order.length() > 0) {
                    list = service.searchProductByTypeOrderBy(type, order);
                } else if (type != null && type.length() > 0) {
                    list = service.searchProductByType(type);
                } else if (outfit != null && outfit.length() > 0) {
                    list = service.searchProductByOutfit(outfit);
                } else if (launchDate != null && launchDate.length() > 0) {
                    list = service.searchNewProductsByTodayMinusWeek();
                    //排序查詢
                } else if (order != null && order.length() > 0) {
                    list = service.searchAllProductsOrderBy(order);
                } else {
                    list = service.getAllProducts();
                }
            %>
            <section class="p-list-main">

                <%if (outfit != null && outfit.equals("上班族")) {%>
                <div id="officeLady1">
                    <img src="images/上班族穿搭封面圖.jpg" style="width:1048px;height:448px" usemap="#image1-map">

                    <map name="image1-map">
                        <area id="cloth1-1" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=AB9064" coords="796,74,768,120,765,162,833,163,858,158,845,74" shape="poly">
                        <div id="tag1-1" class="tag">點我選購</div>
                        <area id="pants1-1" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=BA4812" coords="862,373,856,390,818,382,781,373,775,279,767,215,775,182,784,164,837,162,843,209,845,289" shape="poly">
                        <div id="tag2-1" class="tag">點我選購</div>
                        <area id="cloth2-1" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=AB7745" coords="560,151,579,141,609,155,635,155,645,192,647,237,653,281,612,288,565,284" shape="poly">
                        <div id="tag3-1" class="tag">點我選購</div>
                        <area id="pants2-1" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=BA4297" coords="544,290,563,417,704,415,669,280" shape="poly">
                        <div id="tag4-1" class="tag">點我選購</div>
                        <area id="cloth3-1" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=AB9146" coords="239,140,203,150,164,201,156,253,189,271,266,242,269,204,285,167,274,146" shape="poly">
                        <div id="tag5-1" class="tag">點我選購</div>
                        <area id="pants3-1" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=CA1250" coords="157,261,151,300,173,360,193,371,229,429,276,447,313,440,334,401,387,365,433,327,411,302,347,228,324,220,237,257,189,263" shape="poly">
                        <div id="tag6-1" class="tag">點我選購</div>
                    </map>
                </div>
                <div id="officeLady2">
                    <map name="image2-map">
                        <img src="images/上班族穿搭02.jpg" style="width:1048px;margin:50px 0" usemap="#image2-map">
                        <area id="cloth1-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=DA6335" coords="148,175,178,170,207,170,239,188,243,281,236,297,222,300,232,369,228,380,128,376,128,337,150,264,116,258,109,232"" shape="poly">
                        <div id="tag1-2" class="tag">點我選購</div>
                        <area id="cloth2-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=AB9062" coords="307,181,355,167,403,181,413,256,385,272,332,273,319,258,293,249" shape="poly">
                        <div id="tag2-2" class="tag">點我選購</div>
                        <area id="pants2-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=BA4751" coords="320,265,388,271,398,328,397,520,346,520,270,516,289,438,308,293" shape="poly">
                        <div id="tag3-2" class="tag">點我選購</div>
                        <area id="cloth3-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=AB7865" coords="468,159,454,227,441,280,468,285,481,253,513,250,525,205,499,165" shape="poly">
                        <div id="tag4-2" class="tag">點我選購</div>
                        <area id="pants3-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=CA1446" coords="474,248,515,248,528,319,549,424,462,434,450,425,463,287" shape="poly">
                        <div id="tag5-2" class="tag">點我選購</div>
                        <area id="cloth4-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=EA2652" coords="628,165,610,177,606,272,619,295,670,289,660,210" shape="poly">
                        <div id="tag6-2" class="tag">點我選購</div>
                        <area id="pants4-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=BA4886" coords="634,279,691,274,694,320,675,484,616,453" shape="poly">
                        <div id="tag7-2" class="tag">點我選購</div>
                        <area id="cloth5-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=AB9207" coords="787,186,768,292,792,294,799,259,819,268,878,268,890,250,879,205,858,183,818,168" shape="poly">
                        <div id="tag8-2" class="tag">點我選購</div>
                        <area id="pants5-2" target="" alt="" title="" href="<%=request.getContextPath()%>/product.jsp?productId=BA4761" coords="871,268,877,297,855,405,862,496,798,460,825,397,796,305,806,262" shape="poly">
                        <div id="tag9-2" class="tag">點我選購</div>
                        
                    </map>
                </div>
                <div style="width: 1048px;height:100px"></div>
                <%} else if (outfit != null && outfit.equals("約會")) {%>
                <div style="width: 1048px;height:448px ;background-image: url(images/約會穿搭封面圖.jpg);background-size:contain;background-repeat:no-repeat"></div>
                <div style="margin:50px 0;width: 1048px;height:448px ;background-image: url(images/約會穿搭02.jpg);background-size:contain;background-repeat:no-repeat"></div>
                <%} else if (outfit != null && outfit.equals("春日出遊")) {%>
                <div style="width: 1048px;height:488px ;background-image: url(images/春日出遊穿搭封面圖.jpg);background-size:cover"></div>
                <div style="margin:100px 0;width: 1048px;height:655px ;background-image: url(images/春日出遊穿搭02.jpg);background-size:cover"></div>
                <%}%>
                <section class="p-list-title">
<!--                    <h1>我的穿搭日記</h1>-->
                    <%%>
                    <form id="order_form"> 
                        <select id="order_select" selected onchange="getOrderList('<%= type%>')">
                            <option value="">--請選擇--</option>
                            <option value="launch_dateDESC" <%= order != null && order.equals("launch_dateDESC") ? "selected" : ""%> >最新到貨</option>
                            <option value="unitPriceDESC" <%= order != null && order.equals("unitPriceDESC") ? "selected" : ""%> >價格 > 由高到低</option>
                            <option value="unitPriceASC" <%= order != null && order.equals("unitPriceASC") ? "selected" : ""%> >價格 > 由低到高</option>
                        </select>
                    </form>
                    <!--<form id="order_form">
                        <select onChange="location = this.options[this.selectedIndex].value;" tabindex="3" name="order" id="order">
                        <option value="">--請選擇--</option>
                        <option value="product_list.jsp?orderBydate=DESC">最新到貨</option>
                        <option value="product_list.jsp?orderByprice=DESC">價格 > 由高到低</option>
                        <option value="product_list.jsp?orderByprice=ASC" >價格 > 由低到高</option>TODO:search的值是空的
                        </select>
                    </form>-->
                </section>
                <%
                    if (list != null && list.size() > 0) {
                %>
                <div class="p-list-container">
                    <%
                        for (int i = 0; i < list.size(); i++) {
                            Product p = list.get(i);
                    %>
                    <figure>         
                        <a href="product.jsp?productId=<%= p.getId()%>"><%--用超連結送同步GET請求和參數productId和值p.getId()--%>
                            <div class="p-item-img"><img src="<%= p.getColor() != null ? p.getColor().getMain_photoUrl() : ""%>"></div>
                        </a>
                        <figcaption>
                            <div class="p-item-title"><%= p.getName()%></div>
                            <div class="p-item-size"><%= p.getSizeList()%></div>
                            <div class="p-item-price">
                                <% if (p instanceof Outlet) {%>
                                <del>NT$ <%= ((Outlet) p).getListPrice()%></del>
                                <%}%>
                                <span class="sale">NT$ <%= p.getUnitPrice()%></span>
                            </div>
                        </figcaption>
                    </figure>
                    <% } %>
                </div>
                <% } else {%>
                <p>查無符合 <span style="color:pink"><%= search%></span> 的資料</p>
                <% }%>
            </section>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <!----------------------------------------------Footer------------------------------------------------------->
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
