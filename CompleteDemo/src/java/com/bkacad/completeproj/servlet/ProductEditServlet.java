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
 
import com.bkacad.completeproj.dto.ProductDTO;
import com.bkacad.completeproj.jdbc.ProductImpl;
import com.bkacad.completeproj.util.Util;
 
@WebServlet(urlPatterns = { "/doEditProduct" })
public class ProductEditServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
 
   public ProductEditServlet() {
       super();
   }
 
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       String code = (String) request.getParameter("code");
       String name = (String) request.getParameter("name");
       String priceStr = (String) request.getParameter("price");
       float price = 0;
       try {
           price = Float.parseFloat(priceStr);
       } catch (Exception e) {
       }
       ProductDTO product = new ProductDTO(code, name, price);
 
       String errorString = null;
 
       try {
    	   Connection conn = Util.getStoredConnection(request);
           new ProductImpl(conn).updateProduct(product);
       } catch (SQLException e) {
           e.printStackTrace();
           errorString = e.getMessage();
       }
       // Lưu thông tin vào request attribute trước khi forward sang views.
       request.setAttribute("errorString", errorString);
       request.setAttribute("product", product);
 
       // Nếu có lỗi forward sang trang edit
       if (errorString != null) {
           RequestDispatcher dispatcher = request.getServletContext()
                   .getRequestDispatcher("/jsp/product/editProductView.jsp");
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