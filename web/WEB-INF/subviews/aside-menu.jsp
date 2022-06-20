<%-- 
    Document   : aside-menu
    Created on : 2019/3/23, 下午 05:56:57
    Author     : fiber
--%>
<!-- aside-menu-start -->
<%@page  pageEncoding="UTF-8"%>
<aside class="aside-menu">
    <section class="first">
        <ul>
            <h3>ON SALE</h3>
            <span>活動</span>
            <li><a href=#>早春特惠新品8折</a></li>
            <li><a href=#>HOT熱賣現折220</a></li>
            <li><a href=#>熱賣商品✪補貨到！</a></li>
            <li><a href=#>小編精選均一價$290</a></li>
        </ul>
    </section>
    <section>
        <ul>
            <span>最新商品</span>
            <li><a href=#>2019春新品登場</a></li>
            <li><a href=#>上週新品</a></li>
        </ul>
    </section>
    <section>
        <ul>
            <span>特別企劃</span>
            <li><a href=#>婚禮女神look</a></li>
            <li><a href=#>一周洋裝穿搭日記</a></li>
            <li><a href=#>經典不敗百搭背心</a></li>
            <li><a href=#>基本配色穿搭術</a></li>
        </ul>
    </section>
    <section>
        <ul>
            <li><a href="<%=request.getContextPath()%>/product_list.jsp?launch_date=today"><span>新品上市</span></a></li>
            <li><a href=#><span>熱銷排行</span></a></li>
            <li><a href=#><span>直播精選</span></a></li>
            <li><a href="<%=request.getContextPath()%>/product_list.jsp?type=上衣"><span>上衣</span></a></li>
            <li><a href="<%=request.getContextPath()%>/product_list.jsp?type=洋裝"><span>洋裝</span></a></li>
            <li><a href="<%=request.getContextPath()%>/product_list.jsp?type=褲子"><span>褲子</span></a></li>
            <li><a href="<%=request.getContextPath()%>/product_list.jsp?type=裙子"><span>裙子</span></a></li>
            <li><a href="<%=request.getContextPath()%>/product_list.jsp?type=外套"><span>外套</span></a></li>
        </ul>
    </section>
</aside>
<!-- aside-menu-end -->