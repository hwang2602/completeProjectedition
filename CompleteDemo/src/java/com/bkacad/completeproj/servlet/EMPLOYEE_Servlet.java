package com.bkacad.completeproj.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkacad.completeproj.dao.EMPLOYEE_Dao;
import com.bkacad.completeproj.dao.PRODUCT_Dao;
import com.bkacad.completeproj.dto.EMPLOYEE_GetDto;
import com.bkacad.completeproj.dto.PRODUCT_PostDto;
import com.bkacad.completeproj.jdbc.EMPLOYEE_Impl;
import com.bkacad.completeproj.jdbc.PRODUCT_Impl;
import com.bkacad.completeproj.util.Constant;
import com.bkacad.completeproj.util.Util;


@WebServlet("/EMPLOYEE_Servlet")
public class EMPLOYEE_Servlet extends AbstractServlet {
	private static final long serialVersionUID = 1L;

    public EMPLOYEE_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = Util.getStoredConnection(request);
		EMPLOYEE_Dao daoEMPLOYEE= new EMPLOYEE_Impl(conn);
		EMPLOYEE_GetDto getDTO = new EMPLOYEE_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.EMP_ID = Util.checkNull(request.getParameter("EMP_ID"));
			getDTO.NAME = Util.checkNull(request.getParameter("NAME"));
			getDTO.HIDE_DATE = Util.checkNull(request.getParameter("HIDE_DATE"));
			
			strResult=daoEMPLOYEE.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		//System.out.println("EMPLOYEE_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("PRODUCT_Servlet: doPost: begin");
		String s=request.getParameter("xml");
		System.out.println("PRODUCT_Servlet: doPost: s=" + s);
		String method = Util.getTag(s,"<method>","</method>");

		Connection conn = Util.getStoredConnection(request);
		PRODUCT_Dao daoObj = new PRODUCT_Impl(conn);
		PRODUCT_PostDto dtoObj = new PRODUCT_PostDto();
		dtoObj.xml = s;
		dtoObj.getDTO();

		System.out.println("PRODUCT_Servlet: doPost: Method=" + method);		
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
		System.out.println("PRODUCT_Servlet: doPost: End");
	}

}
