<%-- 
    Document   : member_update
    Created on : 2019/4/7, 下午 3:52:00
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>會員修改</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入top-button.css-->
        <link href="<%= request.getContextPath()%>/style/top-button.css" rel="stylesheet" type="text/css"/>
        <style>
            article {
                height: 550px;
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
                margin-left: 60px;
                padding:10px;
                border:1px dashed #666;
                width: 400px;
            }
            .myLegend{
                margin-left: 45px;
                width:280px;
                font-size: 1.17em;
                font-family: 'Playfair Display',Georgia,'PingFang TC','Hiragino Sans GB','Microsoft JhengHei','Helvetica Neue',icomoon,serif,sans-serif;
                font-weight: 300;
            }
            input{
                width: 230px;
                height: 35px;
                border-radius : 3px;
                border: 0.5px solid #ccc;
                padding: 0 5px;
                font-size: 14px;
                letter-spacing: 0.1em;
            }
            label{
                margin-right:6px;
                font-weight: 300;
                letter-spacing: 0.1em;
            }
            .main{
                width: 1000px;
                margin: 30px auto;
                margin-left: 50px;
            }
            .btn{
                padding: 0 1.5em;
                line-height: 37px;
                color: #3c3d41;
                background-color: transparent;
                border: 1px solid #5b5b5b;
                border-radius: 4px;
                width: 98px;
                height: 37px;
                font-size: 13px;
                margin-bottom: 10px;
                transition: all 0.5s;
            }
            .btn:hover{
                background-color: #444;
                color: #FFF;
            }
        </style>
    </head>
    <body>
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
            <%
                Customer member = (Customer) session.getAttribute("member");
            %>   
            <section class="main">
                <%
                    if (member != null) {
                %>   
                <div>
                    ${requestScope.info_errors}
                    <form action='update.do?method=infoUpdate' method="POST" id="infoUpdate">
                        <fieldset style="float:left" class="myTest">
                            <legend class="myLegend">Edit Account&nbsp;&nbsp;修改會員資料</legend>
                            <label style="margin-top: 10px">會員帳號</label><br>
                            <input style="background:#fcfcfc;color:#96866F" type="text" name="email" readonly value="${sessionScope.member.email}"><br>
                            <label style="margin-top: 20px">姓名</label><br>
                            <input type="text" name="name" value="${empty param.name?sessionScope.member.name:param.name}"><br>
                            <label style="margin-top: 20px">出生日期</label><br>
                            <input style="margin-bottom: 50px" type="date" name="birthday" value="${empty param.birthday?sessionScope.member.birthday:param.birthday}"><br>
                            <input class="btn" type="submit" name="info-submit" value="確認修改">
                        </fieldset>
                    </form>
                </div>
                <div>
                    ${requestScope.pwd_errors}
                    <form action='update.do?method=pwdUpdate' method="POST" id="pwdUpdate">
                        <fieldset class="myTest">
                            <legend class="myLegend">Change Password&nbsp;&nbsp;修改密碼</legend>
                            <label style="margin-top: 10px">請輸入舊密碼</label><br>
                            <input type="text" name="oldPwd" ><br>
                            <label style="margin-top: 20px">請輸入新密碼</label><br>
                            <input type="text" name="pwd1"><br>
                            <label style="margin-top: 20px">新密碼再確認</label><br>
                            <input style="margin-bottom: 50px" type="text" name="pwd2"><br>
                            <input class="btn" type="submit" name="pwd-submit" value="確認修改">
                        </fieldset>
                    </form>
                </div>
            </section>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
              <%} else {%>
            <p>請登入後才可以修改會員</p>
            <%}%>
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</html>
