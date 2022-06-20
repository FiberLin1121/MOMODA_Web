<%-- 
    Document   : index
    Created on : 2019/3/16, 下午 05:51:28
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.Color"%>
<%@page import="java.util.List"%>
<%@page import="uuu.mmd.model.ProductService"%>
<%@page import="uuu.mmd.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>首頁</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">    
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入top-button.css-->
        <link href="<%= request.getContextPath()%>/style/top-button.css" rel="stylesheet" type="text/css"/>
        <!--引入"slick-->
        <link href="slick/css/slick.css" rel="stylesheet" type="text/css"/>
        <link href="slick/css/slick-theme.css" rel="stylesheet" type="text/css"/>
        <style>
            .article-main{
                background: #fff;
                margin-top: -20px;
                width: 100%;
            }
            .item{
                margin: 0 auto;
                width: 100%;
                height: 600px;
            }
            .article-main .info{
                background: url("https://obcdn4.obdesign.com.tw/images/ObdesignBanner/WOMEN/images/190128-EarthTone_1544x180-belt-pc.jpg") no-repeat;
                background-size: 964px 112px,contain;
                margin: 0 auto;
                width: 1000px;
                height: 112px;
            }

            .article-main .image{
                background: url("https://obcdn4.obdesign.com.tw/OB_Images/120168/10226/8ecbe2e5-85f7-4a7f-b986-1167337957ea.jpg") no-repeat;
                background-size: 964px 362px,contain;
                margin: 0 auto;
                width: 1000px;
                height: 362px;
            }

            .type{
                display: flex;
                flex-direction: row;
                margin: 0 auto;
            }
            .type img{
                width: 306px;
                height: 233px;
            }
            .outfit{
                margin: 0 auto;
            }
            .container2{
                width: 1000px;
                margin: 0 auto;
            }
            .container2 img{
                width: 150px;
                max-height: 220px;
                margin: 0 auto;
            }
            .slick-prev:before, .slick-next:before {
                color: #d68a7d;
            }
            .container3 img{
                width: 130px;
            }
            .fixedBackground{
                margin: 0px;
                width: 100%;
                height: 975px;
                background-image: url("<%= request.getContextPath()%>/images/背景圖.jpg");
                background-attachment:fixed;
                background-size: contain;
                background-repeat: no-repeat;
            }
        </style>
        <script src="slick/js/slick.js" type="text/javascript"></script>
        <script>
            $(document).ready(init);
            function init() {

                $('#myCarousel').carousel({
                    interval: 3000
                })

                $('#container2').slick({
                    infinite: true,
                    speed: 500,
                    slidesToShow: 5,
                    slidesToScroll: 1,
//                    autoplay: true,
//                    autoplaySpeed: 2000,
                });

                $('#container3').slick({
                    infinite: true,
                    speed: 500,
                    slidesToShow: 5,
                    slidesToScroll: 1,
//                    autoplay: true,
//                    autoplaySpeed: 4000,
                });
            }

        </script>
        <%
            ProductService service = new ProductService();
            List<Color> list = null;
            list = service.searchClothPhotoAndProductIdByRand();
            List<Color> list2 = null;
            list2 = service.searchPantsOrSkirtPhotoAndProductIdByRand();
        %>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <!---------------------------------------------article------------------------------------------------------>
        <article class="article-main">
            <div id="myCarousel" class="carousel slide">
                <!--------------------------------------- 輪播（Carousel）指標 --------------------------------------------->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                    <li data-target="#myCarousel" data-slide-to="4"></li>
                    <li data-target="#myCarousel" data-slide-to="5"></li>
                </ol>   
                <!---------------------------------------- 輪播（Carousel）項目 -------------------------------------------->
                <div class="carousel-inner">
                    <div class="item active">
                        <a href="<%=request.getContextPath()%>/product_list.jsp?outfit=上班族"><img src="<%= request.getContextPath()%>/images/輪播圖1.jpg" alt="1 slide"></a>
                    </div>
                    <div class="item">
                        <img src="<%= request.getContextPath()%>/images/輪播圖2.jpg" alt="2 slide">
                    </div>
                    <div class="item">
                       <img src="<%= request.getContextPath()%>/images/輪播圖3.jpg" alt="3 slide">
                    </div>
                    <div class="item">
                        <a href="<%=request.getContextPath()%>/product.jsp?productId=AB9483"><img src="<%= request.getContextPath()%>/images/輪播圖4.jpg" alt="4 slide"></a>
                    </div>
                    <div class="item">
                        <img src="<%= request.getContextPath()%>/images/輪播圖5.jpg" alt="5 slide">
                    </div> 
                    <div class="item">
                        <a href="<%=request.getContextPath()%>/product_list.jsp?outfit=春日出遊"><img src="<%= request.getContextPath()%>/images/輪播圖6.jpg" alt="6 slide"></a>
                    </div>
                </div>
                <!--------------------------------------- 輪播（Carousel）導航 --------------------------------------------->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div> 
            <div class="type">
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=上衣"><img src="<%= request.getContextPath()%>/images/type1.jpg"></a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=褲子"><img src="<%= request.getContextPath()%>/images/type2.jpg"></a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=洋裝"><img src="<%= request.getContextPath()%>/images/type3.jpg"></a>
                <a href="<%=request.getContextPath()%>/product_list.jsp?type=外套"><img src="<%= request.getContextPath()%>/images/type4.jpg"></a>
            </div>
            <div class="outfit">
                <a href="<%=request.getContextPath()%>/product_list.jsp?outfit=春日出遊"><img style="width: 1220px" src="<%= request.getContextPath()%>/images/outfit.jpg"></a>
            </div>
             <div style="margin:30px auto 0">
                 <a href="<%= request.getContextPath()%>/product_list.jsp?outfit=上班族"><img style="width: 1220px" src="<%= request.getContextPath()%>/images/add.jpg"></a>
            </div>
            <div style="margin:30px auto">
                <a href="<%= request.getContextPath()%>/product_list.jsp?outfit=上班族"><img style="width: 1220px" src="<%= request.getContextPath()%>/images/ad3.jpg"></a>
            </div>
             <div style="margin:0 auto">
                 <img style="width: 1220px" src="<%= request.getContextPath()%>/images/ad2.gif">
            </div>
            <br>
            <br>
            <a href="<%= request.getContextPath()%>/product_list.jsp?search=格紋"><div class="fixedBackground"></div></a>
      
             
            <div style="margin:100px auto 50px auto">
                <img style="width: 1200px" src="<%= request.getContextPath()%>/images/title.jpg">
            </div>
            <div class="container2" id="container2" style="margin: 0px auto 0px auto">
                <%
                    for (int i = 0; i < list.size(); i++) {
                        Color top = list.get(i);
                %>
                <li><a href="product.jsp?productId=<%= top.getProduct_id()%>"><img src="<%= top.getPng_photoUrl()%>" alt=""/></a></li>
                        <%}%>
            </div>
            <div class="container2 container3" id="container3" style="margin: 0px auto 80px auto">
                <%
                    for (int i = 0; i < list2.size(); i++) {
                        Color under = list2.get(i);
                %>
                <li><a href="product.jsp?productId=<%= under.getProduct_id()%>"><img src="<%= under.getPng_photoUrl()%>" alt=""/></a></li>
                        <%}%>
            </div>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
