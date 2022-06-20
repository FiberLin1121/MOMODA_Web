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
@WebServlet(name = "LoginServlet", urlPatterns = {"/login.do"})
public class LoginServlet extends HttpServlet {

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
        List<String> errors = new ArrayList<>();

        //設定request傳來資料的編碼方式
        //request.setCharacterEncoding("UTF-8");
        
        //1. 讀取request中的表單資料並檢查
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String captcha = request.getParameter("captcha");

        if (email == null || email.length() == 0) {
            errors.add("必須輸入帳號");
        }

        if (pwd == null || pwd.length() < 6 || pwd.length() > 20) {
            errors.add("密碼需為6~20碼英數字");
        }

        HttpSession session = request.getSession();
        if (captcha == null || captcha.length() == 0) {
            errors.add("必須輸入驗證碼");
        } else {
            String oldCaptsha = (String) session.getAttribute("CaptchaServlet");//Object轉型成String
            if (!captcha.equalsIgnoreCase(oldCaptsha)) {
                errors.add("驗證碼不正確");
            }
        }
        session.removeAttribute("CaptchaServlet");
        

        //2. 當錯誤清單errors是空的，呼叫CustomerService的login
        if (errors.isEmpty()) {
            //建立CustomerService物件
            CustomerService service = new CustomerService();
            try {
                Customer c = service.login(email, pwd);
                
                //3.1 forward會員中心
                session.setAttribute("member", c); //兩個請求之間要共用同個資料用session

                RequestDispatcher dispatcher = request.getRequestDispatcher("/member/my_account.jsp");
                dispatcher.forward(request, response);
                return;//代表跳轉過去就不再執行下面的code

            } catch (MMDException ex) {//商業邏輯錯誤
                System.out.println("登入失敗:" + ex);
                errors.add(ex.getMessage());
                if (ex.getCause() != null) {
                    errors.add(ex.getMessage() + ",請聯絡系統管理人員");
                } else {
                    errors.add(ex.getMessage());
                }
            } catch (Exception ex) {
                this.log("登入發生非預期錯誤", ex);
                errors.add("登入發生非預期錯誤" + ex.toString());
            }
        }
        //3.2 產生登入失敗畫面
        request.setAttribute("errors", errors);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login_register.jsp");
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
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
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
