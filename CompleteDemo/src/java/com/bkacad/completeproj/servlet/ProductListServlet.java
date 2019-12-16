package com.bkacad.completeproj.servlet;
 
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkacad.completeproj.dto.ProductDTO;
import com.bkacad.completeproj.jdbc.ProductImpl;
import com.bkacad.completeproj.util.Util;
 
@WebServlet(urlPatterns = { "/productList" })
public class ProductListServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
 
   public ProductListServlet() {
       super();
   }
 
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
 
       String errorString = null;
       List<ProductDTO> list = null;
       try {
    	   Connection conn = Util.getStoredConnection(request);
           list = new ProductImpl(conn).queryProduct();
       } catch (SQLException e) {
           e.printStackTrace();
           errorString = e.getMessage();
       }
       // Lưu thông tin vào request attribute trước khi forward sang views.
       request.setAttribute("errorString", errorString);
       request.setAttribute("productList", list);
        
       // Forward sang /views/productListView.jsp
       RequestDispatcher dispatcher = request.getServletContext()
               .getRequestDispatcher("/jsp/product/productListView.jsp");
       dispatcher.forward(request, response);
   }
 
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       doGet(request, response);
   }
 
}