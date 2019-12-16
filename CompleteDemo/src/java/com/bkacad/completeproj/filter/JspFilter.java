package com.bkacad.completeproj.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.bkacad.completeproj.dto.UserDTO;
import com.bkacad.completeproj.util.Util;

@WebFilter(filterName = "jspFilter", urlPatterns = { "/*" })
public class JspFilter implements Filter {

	public JspFilter() {
		super();
	}

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		UserDTO userInSession = Util.getLoginedUser(session);
		String servletPath = req.getServletPath();
		if ((servletPath.indexOf(".jsp") > 1) && (userInSession == null)) {
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/jsp/common/Login.jsp");
			dispatcher.forward(request, response);
		}
		request.setCharacterEncoding("UTF-8");
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
	}
}
