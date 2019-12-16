package com.bkacad.completeproj.filter;
 
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.bkacad.completeproj.jdbc.DBUtil;
import com.bkacad.completeproj.util.Util;
 
@WebFilter(filterName="jdbcFilter", urlPatterns = { "/*" })
public class JDBCFilter implements Filter {
   public JDBCFilter() {
   }
 
   @Override
   public void init(FilterConfig fConfig) throws ServletException {
 
   }
 
   @Override
   public void destroy() {
 
   }
 
   @Override
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
           throws IOException, ServletException {
 
       HttpServletRequest req = (HttpServletRequest) request;
 
       //
       // Chỉ mở kết nối đối với các request có đường dẫn đặc biệt cần
       // connection. (Chẳng hạn đường dẫn tới các servlet, jsp, ..)
       //
       // Tránh tình trạng mở connection với các yêu cầu thông thường
       // (chẳng hạn image, css, javascript,... )
       //
		if (Util.isValidPathServlet(req)) {
			System.out.println("Open Connection for: " + req.getServletPath());

			Connection conn = null;
			try {
				// Tạo đối tượng Connection kết nối database.
				conn = DBUtil.getSqlConn();
				// Sét tự động commit false, để chủ động điều khiển.
				conn.setAutoCommit(false);

				// Lưu trữ vào attribute của request.
				Util.storeConnection(request, conn);
				
				// Cho phép request đi tiếp.
				chain.doFilter(request, response);

				// Gọi commit() để commit giao dịch với DB.
				conn.commit();
			} catch (SQLException ex) {
				ex.printStackTrace();
				DBUtil.rollbackQuietly(conn);
				RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/jsp/common/Login.jsp");
				request.setAttribute("errorString", "Không hết nối được CSDL!");
				dispatcher.forward(request, response);
			}catch (Exception e) {
				e.printStackTrace();
				DBUtil.rollbackQuietly(conn);
			} finally {
				DBUtil.closeQuietly(conn);
			}
		}
       // Với các request thông thường (image,css,html,..)
       // không cần mở connection, cho tiếp tục.
       else {
           // Cho phép request đi tiếp.
           chain.doFilter(request, response);
       }
 
   }
 
}