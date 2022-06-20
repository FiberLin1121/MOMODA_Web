/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.mmd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "UpdateServlet", urlPatterns = {"/member/update.do"})
public class UpdateServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("update.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //從session 取得 member
        HttpSession session = request.getSession();
        Customer member = (Customer) session.getAttribute("member");
        if (member == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        //判斷要處理哪支form
        String method = request.getParameter("method");
        if (method.equals("infoUpdate")) {
            //0.建立錯誤清單
            List<String> info_errors = new ArrayList<>();

            //1.取得表單資料並檢查
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String birthday = request.getParameter("birthday");

            if (email == null || (!email.equals(member.getEmail()))) {
                info_errors.add("會員帳號不正確");
            }
            if (name == null || (name = name.trim()).length() == 0) {
                info_errors.add("必須輸入姓名");
            }
            if (birthday == null || birthday.length() == 0) {
                info_errors.add("必須輸入生日");
            }

            //2.若檢查無誤則呼叫商業邏輯
            if (info_errors.isEmpty()) {
                try {
                    Customer c1 = member.getClass().newInstance();
                    c1.setEmail(member.getEmail());
                    c1.setPassword(member.getPassword());
                    c1.setName(name);
                    c1.setBirthday(birthday);

                    CustomerService service = new CustomerService();
                    service.update(c1);

                    //3.1 success: Redirect to HOME page
                    session.setAttribute("member", c1);
                    response.sendRedirect(request.getContextPath()+"/member/my_account.jsp");
                    return;
                } catch (MMDException ex) {
                    this.log("會員修改發生錯誤", ex);
                    info_errors.add(ex.getMessage());
                } catch (Exception ex) {
                    this.log("會員修改發生非預期錯誤", ex);
                    info_errors.add("發生非預期錯誤" + ex);
                }
            }
            //3.2 檢查有誤或商業邏輯執行失敗: forward to /update.jsp
            request.setAttribute("info_errors", info_errors);
            request.getRequestDispatcher("update.jsp").forward(request, response);

        } else if (method.equals("pwdUpdate")) {
            //0.建立錯誤清單
            List<String> pwd_errors = new ArrayList<>();

            //1.取得表單資料並檢查
            String oldPwd = request.getParameter("oldPwd");
            String pwd1 = request.getParameter("pwd1");
            String pwd2 = request.getParameter("pwd2");

            if (oldPwd == null || (!oldPwd.equals(member.getPassword()))) {
                pwd_errors.add("會員密碼不正確");
            }
            if (pwd1 == null || pwd1.length() < 6 || pwd1.length() > 20) {
                pwd_errors.add("必須輸入6~20字元密碼");
            } else if (!pwd1.equals(pwd2)) {
                pwd_errors.add("必須輸入6~20字元且一致的密碼與確認密碼");
            }
            if (pwd_errors.isEmpty()) {
                try {
                    Customer c2 = member.getClass().newInstance();
                    c2.setEmail(member.getEmail());
                    c2.setPassword(pwd1);
                    c2.setName(member.getName());
                    c2.setBirthday(member.getBirthday());

                    CustomerService service = new CustomerService();
                    service.update(c2);

                    //3.1 success: Redirect to HOME page
                    session.setAttribute("member", c2);
                    response.sendRedirect(request.getContextPath()+"/member/my_account.jsp");
                    return;
                } catch (MMDException ex) {
                    this.log("會員修改發生錯誤", ex);
                    pwd_errors.add(ex.getMessage());
                } catch (Exception ex) {
                    this.log("會員修改發生非預期錯誤", ex);
                    pwd_errors.add("發生非預期錯誤" + ex);
                }
            }
            //3.2 檢查有誤或商業邏輯執行失敗: forward to /update.jsp
            request.setAttribute("pwd_errors", pwd_errors);
            request.getRequestDispatcher("update.jsp").forward(request, response);
        }
    }
}
