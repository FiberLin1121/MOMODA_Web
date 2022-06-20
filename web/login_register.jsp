<%-- 
    Document   : login_register
    Created on : 2019/3/15, 上午 12:04:28
    Author     : fiber
--%>

<%@page import="uuu.mmd.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>登入/註冊</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">    
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <!--引入top-button.css-->
        <link href="<%= request.getContextPath() %>/style/top-button.css" rel="stylesheet" type="text/css"/>
        <style>
            body{
                background: #f2f2f2;
            }
            .member-login,.member-register{
                width: 450px;
                height: 550px;
                margin-top: 70px;
            }
            .member-register{
                border-left: 1px solid #BBB;
            }
            .title h3{
                font-family: Garamond;
                font-size: 40px;
                font-weight: bold;
                text-align: center;
                color: #82726d;
                line-height: 1.4;
                margin-bottom: 0px;     
                margin-top: 30px;
            }
            .title h4{
                font-size: 20px;
                margin: 0 auto;
                margin-bottom: 50px;
                color: #8b827f;
                font-family: "Josefin Slab", serif;
                text-align: center;
                line-height: 1.4;
                font-weight: 400;
            }
            fieldset{       
                border: none;
                height: 100px;
                text-align: center;
            }
            .member-login input,.member-register input{
                width: 250px;
                height: 25px;
                margin-bottom: 30px;
            }
            .member-login .button,.member-register .button{
                border: none;
                width: 40%;
                height: 40px;
                background-color: #f2f2f2;
                border: #444 1px solid;
                color: #333;
                line-height: 30px;
                font-size: 16px;
                margin-top: 50px;
                transition: background-color 0.6s;
            }
            .member-login .button:hover{
                background-color: #444;
                color: white;
            }
            .birthday-label{
                font-size: 12px;
                margin-right: 192px;
            }
            #birthday_input{
                max-width: 42%;
                margin-right: 80px;
            }
            .captcha_input{
                max-width: 42%;
                margin-left: 10px;
            }
            .register_captcha_input{
                max-width: 42%;
                margin-left: 38px;
            }
            .captcha_image{
                margin-left: 10px;
            }
            .member-register .button:hover{
                background-color: #444;
                color: white;
            }
        </style>
    </head>
    <script>
        function refreshCaptchaLogin() {
            $("#captchaImage1").attr("src", "images/captcha.jpeg?test=" + new Date());//變更網址，才會重新送請求，使用new Date()取的現在時間(秒)來refresh
        }
        function refreshCaptchaRegister() {
            $("#captchaImage2").attr("src", "images/register_captcha.jpeg?test=" + new Date());
        }
    </script>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <!---------------------------------------------article------------------------------------------------------>
        <article class="main">
            <section class="member-login">
                <div class="title">
                    <h3>SIGN IN</h3>
                    <h4>會員登錄</h4>
                </div>
                <!--------------------------------------------login-form---------------------------------------------------->
                <form method="POST" action="login.do" autocomplete="on">
                    <fieldset>
                        <label for="email"></label>
                        <input type="email" name="email" placeholder="會員帳號 E-MAIL*" value="<%= request.getParameter("email") == null ? "" : request.getParameter("email")%>" autofocus required><br>
                        <label for="pwd"></label>
                        <input type="password" name="pwd" placeholder="會員密碼 Password*" required><br>
                        <label for="captcha"></label>
                        <input type="text" name="captcha" class="captcha_input" placeholder="輸入驗證碼*" autocomplete="off" required>
                        <a href="javascript:refreshCaptchaLogin()" title="看不清楚?請點選更新驗證碼">
                            <img class="captcha_image" id="captchaImage1" src="images/captcha.jpeg"><br>
                        </a>
                        <p>
                            <%
                                List<String> errors = (List<String>) request.getAttribute("errors");
                                if (errors != null && errors.size() > 0) {
                                    out.println(errors);
                                }
                            %>
                        </p>
                        <br>
                        <input type="submit" name="login_submit" value="SIGN IN" class="button">
                    </fieldset>
                </form>

                <!-------------------------------------------register-form---------------------------------------------------->
            </section>
            <section class="member-register">
                <div class="title">
                    <h3>REGISTER</h3>
                    <h4>會員註冊</h4>
                </div>
                <form action="register.do" method="post" autocomplete="on">
                    <fieldset>
                        <label for="email"></label>
                        <input type="email" name="register_email" placeholder="會員帳號 E-MAIL *" value="<%= request.getParameter("register_email") == null ? "" : request.getParameter("register_email")%>" required><br>
                        <label for="password"></label>
                        <input type="password" name="pwd1" placeholder="輸入密碼 Password*" minlength="6" maxlength="20" required><br>
                        <label for="password"></label>
                        <input type="password" name="pwd2"  placeholder="密碼確認 Confirm Password*" minlength="6" maxlength="20" required><br>
                        <label for="name"></label>
                        <input type="text" name="name" placeholder="輸入姓名*" value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("name")%>" required><br>
                        <label class="birthday-label" for="age">出生日期 :</label><br>
                        <input type="date" name="birthday" id="birthday_input" min="1920-01-01" max="2020-04-15"><br>
                        <input type="text" name="captcha" class="register_captcha_input" placeholder="輸入驗證碼*" autocomplete="off" required>
                        <a href="javascript:refreshCaptchaRegister()" title="看不清楚?請點選更新驗證碼">
                            <img class="captcha_image" id="captchaImage2" src="images/register_captcha.jpeg"><br>
                        </a>
                        <p>
                            <%
                                List<String> register_errors = (List<String>) request.getAttribute("register_errors");
                                if (register_errors != null && register_errors.size() > 0) {
                                    out.println(register_errors);
                                }
                            %>
                        </p>
                        <br>
                        <input type="submit" name="register_submit" value="JOIN" class="button">
                    </fieldset>
                </form>
            </section>
            <%@include file="/WEB-INF/subviews/top-button.jsp" %>
        </article>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>