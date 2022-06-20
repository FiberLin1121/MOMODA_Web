/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.mmd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.mmd.entity.CartItem;
import uuu.mmd.entity.ShoppingCart;

/**
 *
 * @author fiber
 */
@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/member/update_cart.do"})
public class UpdateCartServlet extends HttpServlet {

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

        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        //如果購物車不是空的且大小大於0
        if (cart != null && cart.size() > 0) {

            //先放到垃圾桶,待會再來刪掉(避免指位器Iterator的next()發生 java.util.concurrentmodificationexception)
            Set<CartItem> trashSet = new HashSet<>();
            for (CartItem item : cart.getCartItemSet()) {//從cart的ketSet取得key -> 也就是item

                //1.取得Request中form的Parameter ( quantity_<%= item.hashCode()%>,delete_<%= item.hashCode()%>)
                String quantity = request.getParameter("quantity_" + item.hashCode());
                String delete = request.getParameter("delete_" + item.hashCode());

                //2.呼叫商業邏輯(檢查)
                if (delete == null && quantity != null && quantity.matches("\\d+")) {  // \d:任何數字字元[0-9] // +: 出現一次以上
                    //2.1呼叫修改購買明細的數量
                    cart.update(item, Integer.parseInt(quantity)); //因為從畫面抓下來的quantity是字串
                } else if (delete != null) {
                    //錯誤寫法:直接刪除那筆購買明細
                    //cart.remove(item);
                    //2.2.1正確寫法:把要刪除的那筆購買明細先加進trashSet
                    trashSet.add(item);
                }
            }
            //2.2.2依據trashSet中的待刪除item到購物明細集合中執行刪除
            for(CartItem item:trashSet){
                cart.remove(item);
            }
        }
        //3.切換畫面
        String submit = request.getParameter("submit");
        if("NEXT  下一步".equals(submit)){
            response.sendRedirect(request.getContextPath()+"/member/check_out.jsp");
        }else{
            response.sendRedirect(request.getContextPath()+"/member/cart.jsp");
        }
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
