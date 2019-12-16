package com.bkacad.completeproj.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkacad.completeproj.util.*;
import com.bkacad.completeproj.dao.SINHVIEN_Dao;
import com.bkacad.completeproj.jdbc.SINHVIEN_Impl;
import com.bkacad.completeproj.dto.SINHVIEN_PostDto;
import com.bkacad.completeproj.dto.SINHVIEN_GetDto;
import com.bkacad.completeproj.servlet.AbstractServlet;

@WebServlet("/SINHVIEN_Servlet")
public class SINHVIEN_Servlet extends AbstractServlet {
	private static final long serialVersionUID = 1L;

    public SINHVIEN_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = Util.getStoredConnection(request);
		SINHVIEN_Dao daoObj= new SINHVIEN_Impl(conn);
		SINHVIEN_GetDto getDTO = new SINHVIEN_GetDto();
		initGetDTO(getDTO,request);

//		if (getDTO.getCurrentUser() == null || getDTO.getCurrentUser().get_UserName() == null) {
//			response.getWriter().println(Util.toHTML("Hết phiên làm việc, hãy đăng nhập lại để thực hiện!"));
//			return;
//		}

		String method = request.getParameter("method");
		String cbbName = request.getParameter("cbbName");

		String strResult = "";
		if(method!= null && cbbName!= null && method.equals("getCbbData")){
			SINHVIEN_PostDto dtoObj = new SINHVIEN_PostDto();
			if(cbbName.equals("Que"))
				strResult = daoObj.getCbbQue();
		} else {
			getDTO.MSV = Util.checkNull(request.getParameter("MSV"));
			getDTO.Hoten = Util.checkNull(request.getParameter("Hoten"));
			strResult=daoObj.getXML(getDTO);
		}

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getWriter().print(strResult);		
		System.out.println("SINHVIEN_Servlet: doGet: end");
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		CurrentUser cu = (CurrentUser)request.getSession().getAttribute("CurrentUser");
//		if (cu != null)
//		{
//			System.out.println("SINHVIEN_Servlet: doPost: begin");
//			byte[] b = new byte[request.getContentLength()];
//			request.getInputStream().read(b);
			Connection conn = Util.getStoredConnection(request);
			String s=request.getParameter("xml");
			System.out.println("SINHVIEN_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			SINHVIEN_Dao daoObj = new SINHVIEN_Impl(conn);
			SINHVIEN_PostDto dtoObj = new SINHVIEN_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("SINHVIEN_Servlet: doPost: Method=" + method);		
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
			System.out.println("SINHVIEN_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
}
