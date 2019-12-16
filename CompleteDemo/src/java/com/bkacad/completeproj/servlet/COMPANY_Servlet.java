package com.bkacad.completeproj.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkacad.completeproj.util.*;
import com.bkacad.completeproj.dao.COMPANY_Dao;
import com.bkacad.completeproj.jdbc.COMPANY_Impl;
import com.bkacad.completeproj.dto.COMPANY_PostDto;
import com.bkacad.completeproj.dto.COMPANY_GetDto;
import com.bkacad.completeproj.servlet.AbstractServlet;

@WebServlet("/COMPANY_Servlet")
public class COMPANY_Servlet extends AbstractServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public COMPANY_Servlet() {
        super();
    }


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("COMPANY_Servlet: doGet: begin");
		Connection conn = Util.getStoredConnection(request);
		COMPANY_Dao daoObj= new COMPANY_Impl(conn);
		COMPANY_GetDto getDTO = new COMPANY_GetDto();
		initGetDTO(getDTO,request);

//		if (getDTO.getCurrentUser() == null || getDTO.getCurrentUser().get_UserName() == null) {
//			response.getWriter().println(Util.toHTML("Hết phiên làm việc, hãy đăng nhập lại để thực hiện!"));
//			return;
//		}

		String method = request.getParameter("method");
		String cbbName = request.getParameter("cbbName");

		String strResult = "";
		if(method!= null && cbbName!= null && method.equals("getCbbData")){
			COMPANY_PostDto dtoObj = new COMPANY_PostDto();
		} else {
			getDTO.CName = Util.checkNull(request.getParameter("CName"));
			getDTO.StockPrice = Util.checkNull(request.getParameter("StockPrice"));
			strResult=daoObj.getXML(getDTO);
		}

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		System.out.println("COMPANY_Servlet: doGet: end");
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		CurrentUser cu = (CurrentUser)request.getSession().getAttribute("CurrentUser");
//		if (cu != null)
//		{
//			System.out.println("COMPANY_Servlet: doPost: begin");
			Connection conn = Util.getStoredConnection(request);
			byte[] b = new byte[request.getContentLength()];
			request.getInputStream().read(b);
			String s=request.getParameter("xml");
			System.out.println("COMPANY_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			COMPANY_Dao daoObj = new COMPANY_Impl(conn);
			COMPANY_PostDto dtoObj = new COMPANY_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("COMPANY_Servlet: doPost: Method=" + method);		
			String msg = "success";
			if (method.equals("update")){
				msg = daoObj.update(dtoObj);
			}
			else if (method.equals("delete")){
				msg = daoObj.delete(dtoObj);
			}
			else if (method.equals("create")){
				msg = daoObj.insert(dtoObj);
			}
			response.getWriter().println(msg);
			System.out.println("COMPANY_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
}
