package com.bkacad.completeproj.servlet;
 
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bkacad.completeproj.dto.UserDTO;
import com.bkacad.completeproj.util.Util;
 
@WebServlet(urlPatterns = { "/home"})
public class HomeServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
 
   public HomeServlet() {
       super();
   }
 
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
	   /*HttpSession session = request.getSession();
	   UserDTO logedUser = (UserDTO) Util.getLoginedUser(session);
	   if(logedUser == null) {
		   RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/jsp/Login.jsp");
	       dispatcher.forward(request, response);
	   } else {*/
	       RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/jsp/common/index.jsp");
	       dispatcher.forward(request, response);
	   /*}*/
   }
 
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       doGet(request, response);
   }
 
}