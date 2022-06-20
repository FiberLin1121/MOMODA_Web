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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.mmd.entity.MMDException;
import uuu.mmd.entity.Product;
import uuu.mmd.entity.ShoppingCart;
import uuu.mmd.model.ProductService;

/**
 *
 * @author fiber
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add_cart.do"})
public class AddToCartServlet extends HttpServlet {

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
        //1.取得request中的From的資料(id , color, size, quantity的 value)並檢查
        String productId = request.getParameter("productId");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String quantity = request.getParameter("quantity");
//        System.out.println("quantity = " + quantity);

        if (productId == null || !productId.matches("\\w{6}")) {
            errors.add("加入購物車時產品編號不正確");
        }
        if (size == null || !size.matches("[a-zA-Z]")) {
            errors.add("加入購物車時尺寸不正確");
        }
        if (quantity.equals("") || quantity == null || !quantity.matches("\\d+")) {// \d:0~9
            errors.add("加入購物車的時數量不正確" + quantity);
        }

        //2.若無誤,則呼叫商業邏輯
        if (errors.isEmpty()) {
            ProductService service = new ProductService();
            try {
                Product p = service.searchProductById(productId); //用畫面傳來的產品代號參數 查出產品
                
                if (p != null) { //如果有找到該產品
                    HttpSession session = request.getSession(); //建立session
                    //如果購物車不是null,加入購物車
                    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
                    if (cart == null) { //如果cart是空的
                        cart = new ShoppingCart();
                        session.setAttribute("cart", cart); //就建一台放進session
                    }
                    cart.addToCart(p, color, size, Integer.parseInt(quantity)); //quantity從畫面抓下來是字串,這裡要轉型成整數
                }

            } catch (MMDException ex) {
                this.log("加入購物車發生錯誤" + ex);
                errors.add("加入購物車發生錯誤" + ex);
            } catch(Exception ex){
                this.log("加入購物車發生錯誤" + ex);
                errors.add("加入購物車發生錯誤" + ex);
            }
        }
        if(errors.size()>0){
            this.log(errors.toString());
        }
        
        //3.切換畫面return to doGet/doPost
//        response.sendRedirect("product.jsp?productId="+productId);
        
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
        //3.1部分畫面更新(非同步請求)
        request.getRequestDispatcher("/cart_total_quantity.jsp").forward(request, response);
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
