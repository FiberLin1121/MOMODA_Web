/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.mmd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.mmd.entity.Customer;
import uuu.mmd.entity.MMDException;
import uuu.mmd.model.CustomerService;

/**
 *
 * @author fiber
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register.do"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //0.建立錯誤清單
        List<String> register_errors = new ArrayList<>();

        //設定request傳來資料的編碼方式
        //request.setCharacterEncoding("UTF-8");

        //1. 讀取request中的表單資料並檢查
        String email = request.getParameter("register_email");
        String pwd1 = request.getParameter("pwd1");
        String pwd2 = request.getParameter("pwd2");
        String name = request.getParameter("name");
        String birthday = request.getParameter("birthday");
        String captcha = request.getParameter("captcha");

        if (email == null || email.length() == 0) {
            register_errors.add("必須輸入帳號");
        }

        if (pwd1 == null || pwd1.length() < 6 || pwd1.length() > 20) {
            register_errors.add("密碼需為6~20個英數字！");
        } else if (!pwd1.equals(pwd2)) {
            register_errors.add("密碼與密碼檢查資料不一樣，請重新輸入");
        }

        if (name == null || name.length() == 0) {
            register_errors.add("必須輸入名字");
        }
        HttpSession session = request.getSession();
        if (captcha == null || captcha.length() == 0) {
            register_errors.add("必須輸入驗證碼");
        } else {
            String oldCaptcha = (String) session.getAttribute("RegisterCaptchaServlet");//Object轉型成String
            if (!captcha.equalsIgnoreCase(oldCaptcha)) {
                register_errors.add("驗證碼不正確");
            }
        }
        session.removeAttribute("RegisterCaptchaServlet");
        
        
        //2. 當錯誤清單register_errors是空的，呼叫CustomerService的register方法
        if (register_errors.isEmpty()) {
            try {
                //建立客戶物件
                Customer c = new Customer();
                
                //將取得的欄位資料塞到客戶物件對應的屬性
                c.setEmail(email);
                c.setPassword(pwd1);
                c.setName(name);
                c.setBirthday(birthday);

                //呼叫CustomerService的register方法
                CustomerService service = new CustomerService();
                service.register(c);
                //印出檢查(測試用)
                System.out.println("email = " + email);
                System.out.println("pwd1 = " + pwd1);
                System.out.println("name = " + name);
                System.out.println("birthday = " + birthday);

                //3.1 註冊成功時轉交register_ok.jsp
                request.setAttribute("customer", c);
                RequestDispatcher dispatcher = request.getRequestDispatcher("register_ok.jsp");
                dispatcher.forward(request, response);
                return;
            } catch (MMDException ex) {
                this.log("會員註冊發生錯誤", ex);
                register_errors.add(ex.getMessage());
            } catch (Exception ex) {
                this.log("會員註冊發生非預期錯誤", ex);
                register_errors.add("會員註冊發生非預期錯誤" + ex);
            }
        }
        System.out.println(register_errors);
        //3.2 發生錯誤時轉交register.jsp
        request.setAttribute("register_errors", register_errors);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/login_register.jsp");
        dispatcher.forward(request, response);
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
