<%-- 
    Document   : global
    Created on : 2019/3/23, 下午 12:11:19
    Author     : fiber
--%>
<!-- global.jsp start -->
<%@page  pageEncoding="UTF-8"%>
<!--icon-文字圖標-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!--bootstrap Tooltip工具提示(小黑對話框)-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<!--引入momoda.css-->
<link href="<%=request.getContextPath()%>/style/momoda.css" rel="stylesheet" type="text/css">
<!--引入jQuery-->
<script src="https://code.jquery.com/jquery-3.0.0.js"
        integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo="
        crossorigin="anonymous">
</script>
<!--引入fancybox-->
<link href="<%=request.getContextPath()%>/fancybox/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
<script src="<%=request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>

<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>-->
<!--引入輪播套件-->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<script>
            $(document).ready(init);
            function init() {
                $('[data-toggle="tooltip"]').tooltip();
                $("#search").click(showHandler);
                $("#backtotop").click(scrollHandler);

                var returnTop = $("#backtotop");
                $(window).scroll(function () {
                    if ($(this).scrollTop() > $(window).height() * 0.4) {
                        returnTop.fadeIn(500);
                    } else {
                        returnTop.fadeOut(500);
                    }
                });
            }
            
            function showHandler() {
                $("#search-input").fadeToggle(800);
                $("#search-button").fadeToggle(800);
            }
            
            function scrollHandler() {
                window.scrollBy(0, -25);/*目標位置,一個單位的移動距離*/
                scrolldelay = setTimeout('scrollHandler()', 2);
                if (document.documentElement.scrollTop == 0)
                    clearTimeout(scrolldelay);/*需clear*/
            }
</script>
<!-- global.jsp end -->