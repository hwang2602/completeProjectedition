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

@WebServlet("/editProduct")
public class ViewProductEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewProductEdit() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = (String) request.getParameter("code");
		 
	       ProductDTO product = null;
	 
	       String errorString = null;
	 
	       try {
	    	   Connection conn = Util.getStoredConnection(request);
	           product = new ProductImpl(conn).findProduct(code);
	       } catch (SQLException e) {
	           e.printStackTrace();
	           errorString = e.getMessage();
	       }
	 
	       // Không có lỗi.
	       // Sản phẩm không tồn tại để edit.
	       // Redirect sang trang danh sách sản phẩm.
	       if (errorString != null && product == null) {
	           response.sendRedirect(request.getServletPath() + "/productList");
	           return;
	       }
	 
	       // Lưu thông tin vào request attribute trước khi forward sang views.
	       request.setAttribute("errorString", errorString);
	       request.setAttribute("product", product);
	 
	       RequestDispatcher dispatcher = request.getServletContext()
	               .getRequestDispatcher("/jsp/product/editProductView.jsp");
	       dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
