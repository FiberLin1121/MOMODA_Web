/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.mmd.controller;

import java.io.IOException;
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
import uuu.mmd.entity.Order;
import uuu.mmd.entity.PaymentType;
import uuu.mmd.entity.ShippingType;
import uuu.mmd.entity.ShoppingCart;
import uuu.mmd.model.OrderService;

/**
 *
 * @author fiber
 */
@WebServlet(name = "CheckOutServlet", urlPatterns = {"/member/check_out.do"})
public class CheckOutServlet extends HttpServlet {

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
        //1.讀取request中Form的Parameter: paymentType, shippingType, name, email, phone, address
        String paymentType = request.getParameter("paymentType");
        String shippingType = request.getParameter("shippingType");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String isfree = request.getParameter("isfree");
        
        //檢查
        if (paymentType == null || paymentType.length() == 0) {
            errors.add("請選擇付款方式");
        }
        if (shippingType == null || shippingType.length() == 0) {
            errors.add("請選擇貨運方式");
        }
        if (name == null || name.length() == 0) {
            errors.add("請輸入收件人姓名");
        }
        if (email == null || email.length() == 0) {
            errors.add("請輸入收件人email");
        }
        if (phone == null || phone.length() == 0) {
            errors.add("請輸入收件人電話");
        }
        if (address == null || address.length() == 0) {
            errors.add("請輸入收件人地址");
        }

        HttpSession session = request.getSession(); //從請求中取得session
        Customer member = (Customer) session.getAttribute("member");
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (member == null || cart == null) {
            response.sendRedirect("cart.jsp");
            return;//切換回購物車畫面後強制結束
        }

        //2.若無誤，則呼叫商業邏輯
        if (errors.isEmpty()) {
            Order order = new Order(); //建立訂單
            order.setMember(member);
            try {
                PaymentType pType = PaymentType.valueOf(paymentType);
                order.setPaymentType(pType);
                order.setPaymentFee(pType.getFee());

                ShippingType shType = ShippingType.valueOf(shippingType);
                order.setShippingType(shType);
                if(isfree.equals("true")){
                order.setShippingFee(0); 
                }else{
                order.setShippingFee(shType.getFee()); 
                }
            } catch (RuntimeException ex) {
                errors.add(ex.toString());
            }
            if (errors.isEmpty()) { //付款方式和貨運方式都對了才繼續
                order.setRecipientName(name);
                order.setRecipientEmail(email);
                order.setRecipientPhone(phone);
                order.setShippingAddress(address);

                order.add(cart);//屬性值存完後，記得加購物車進去! 才呼叫商業邏輯(order的service)
                try {
                    OrderService service = new OrderService();
                    service.insert(order);

                    session.removeAttribute("cart");//訂單送出後要把購物車清空
                    //3.1 結帳成功，內部轉交./order.jsp
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("order.jsp").forward(request, response);
                    return;
                } catch (MMDException ex) {
                    this.log("結帳作業建立訂單時發生非預期錯誤", ex); //給程式人員看的錯誤訊息
                    errors.add(ex.getMessage()); //給使用者看的錯誤訊息
                } catch (Exception ex) {
                    this.log("結帳作業建立訂單時發生非預期錯誤", ex); //給程式人員看的錯誤訊息
                    errors.add(ex.getMessage()); //給使用者看的錯誤訊息
                }
            }
        }
        
         //3.2 結帳失敗，內部轉交./check_out.jsp
        request.setAttribute("errors", errors);
        request.getRequestDispatcher("/member/check_out.jsp").forward(request, response);
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
