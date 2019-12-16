package com.bkacad.completeproj.servlet;
 
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.bkacad.completeproj.jdbc.DBUtil;
import com.bkacad.completeproj.jdbc.ProductImpl;
import com.bkacad.completeproj.util.Util;
 
@WebServlet(urlPatterns = { "/doDeleteProduct" })
public class ProductDeleteServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
 
   public ProductDeleteServlet() {
       super();
   }
 
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       String code = (String) request.getParameter("code");
 
       String errorString = null;
 
       try {
    	   Connection conn = Util.getStoredConnection(request);
           new ProductImpl(conn).deleteProduct(code);
       } catch (SQLException e) {
           e.printStackTrace();
           errorString = e.getMessage();
       }
        
       // Nếu có lỗi forward sang trang báo lỗi.
       if (errorString != null) {
           // Lưu thông tin vào request attribute trước khi forward sang views.
           request.setAttribute("errorString", errorString);
           //
           RequestDispatcher dispatcher = request.getServletContext()
                   .getRequestDispatcher("/jsp/product/deleteProductErrorView.jsp");
           dispatcher.forward(request, response);
       }
       // Nếu m�?i thứ tốt đẹp.
       // Redirect sang trang danh sách sản phẩm.
       else {
           response.sendRedirect(request.getContextPath() + "/productList");
       }
 
   }
 
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       doGet(request, response);
   }
 
}