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
import javax.servlet.annotation.WebInitParam;

/**
 *
 * @author fiber
 */


//@WebFilter(filterName = "CharSetFilter", urlPatterns = {"*.do", "*.jsp"}, initParams = {
//    @WebInitParam(name = "charset", value = "UTF-8")})
public class CharSetFilter implements Filter { //1.實作Filter這個介面(Insert Code -> Implement Methods)
    private FilterConfig filterConfig; //2.宣告屬性
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig; //3.存取屬性
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
       
        String charset = filterConfig.getInitParameter("charset");
        if(charset==null)charset="UTF-8";
        //前置處理
        request.setCharacterEncoding(charset);
        request.getParameterNames();//用請求讀取鎖住請求的編碼(才不會被後來的設定蓋掉)  //選沒參數的那支
        
        response.setCharacterEncoding(charset);
        response.getWriter();//用回應輸出鎖住回應的編碼(才不會被後來的設定蓋掉)
        
        //交給下一棒
        chain.doFilter(request, response);
        
        //後續處理
    }

    @Override
    public void destroy() {
        this.filterConfig = null;  //清空，預防物件儲存池存到的是初始化後的版本
    }

}