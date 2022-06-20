/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.mmd.web;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.mmd.entity.Customer;

/**
 *
 * @author fiber
 */
@WebFilter(filterName = "LoginCheckFilter", urlPatterns = {"/member/*"})
public class LoginCheckFilter implements Filter {

    private FilterConfig filterCog; //宣告屬性
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterCog = filterCog; //存取屬性
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request; //因為filter的request和response參數宣告的太上層((ServletRequest),所以要轉型HttpServletRequest才有HttpSession類別能用
        HttpServletResponse httpResponse =(HttpServletResponse) response ;
        
        HttpSession session = httpRequest.getSession();
        Customer member =(Customer) session.getAttribute("member");
        //強制登入寫法 作業:登入成功後回到他原本要去的頁面
        if(member!=null){
            chain.doFilter(request, response);
        }else{
            httpResponse.sendRedirect(httpRequest.getContextPath()+"/login_register.jsp");
        }
    }

    @Override
    public void destroy() {
    }

}
