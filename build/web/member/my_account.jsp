<%-- 
    Document   : my_account
    Created on : 2019/4/6, 下午 10:17:00
    Author     : fiber
--%>

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
                height: 500px;
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
                margin-top: 150px;
                margin-left: 300px;
                padding: .1em;
                color: #666;
                line-height: 1.5em;
                text-align: center;
                font-family: Lato,'PingFang TC', 'Hiragino Sans GB', 'Microsoft JhengHei', 'Helvetica Neue', icomoon, serif,sans-serif;
            }
            #index-a{
               font-family: Roboto,'Hiragino Sans GB','PingFang TC','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 400;
                color: #E6B0AA;
                text-decoration:none;
            }
            #index-a:hover{
                color: #ddd;
            }
        </style>
    </head>
    <body>
        <%
            Customer member = (Customer) session.getAttribute("member");
        %>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <!---------------------------------------------article------------------------------------------------------>
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
                        <p class="welcome"><span style="color:#96866F"><%=member.getName() %></span>&nbsp;&nbsp;您好，感謝您再次光臨<a id="index-a" href="<%= request.getContextPath() %>">MOMODA</a>&nbsp;&nbsp;祝您購物愉快。
                <img style="width: 60px;margin-top: -20px" src="/mmd/images/愛心.png" alt=""/><br>
                <img style="width: 100px;margin-top: 50px;margin-left: -10px" src="/mmd/images/小朋友.gif" alt=""/>
            </p>
            
           
            
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
