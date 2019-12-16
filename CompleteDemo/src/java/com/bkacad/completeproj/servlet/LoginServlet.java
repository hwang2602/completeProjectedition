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
import com.bkacad.completeproj.jdbc.LoginImpl;
import com.bkacad.completeproj.util.Util;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDTO logedUser = (UserDTO) Util.getLoginedUser(session);
		if(logedUser != null) {
			Util.storeLoginedUser(session, null);
		}
		String site = new String(request.getContextPath() + "/jsp/common/Login.jsp");
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username, password;
		username = request.getParameter("username");
		password = request.getParameter("password");

		UserDTO currUser = new LoginImpl().getUserInfo(username, password, request);
		if (currUser != null) {
			response.setContentType("text/html");
			HttpSession session = request.getSession();
			Util.storeLoginedUser(session, currUser);

			// dùng cái này thì bị mất hết style css???
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/home");
			dispatcher.forward(request, response);

			// New location to be redirected
			/*String site = new String(request.getContextPath() + "/home");
			response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", site);*/
		} else {
			String site = new String(request.getContextPath() + "/login");
			response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", site);
		}
	}
}
