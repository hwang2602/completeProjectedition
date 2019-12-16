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
import com.bkacad.completeproj.dto.EMPLOYEE_PostDto;
import com.bkacad.completeproj.dto.PRODUCT_PostDto;
import com.bkacad.completeproj.jdbc.EMPLOYEE_Impl;
import com.bkacad.completeproj.jdbc.PRODUCT_Impl;
import com.bkacad.completeproj.util.Constant;
import com.bkacad.completeproj.util.Util;

/**
 * Servlet implementation class PHEPTINHCONG
 */
@WebServlet("/PHEPTINHCONG")
public class PHEPTINHCONG extends AbstractServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PHEPTINHCONG() {
        super();
       

    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//lay giá trị các tham số đầu vào
		EMPLOYEE_GetDto empDto= new EMPLOYEE_GetDto();
		initGetDTO(empDto, request);
		empDto.EMP_ID=request.getParameter("manhanvien");
		empDto.NAME=request.getParameter("tennhanvien");
		//gọi jdbc de lay du lieu, format du lieu theo chuan xml cua Jqgrid
		Connection conn = Util.getStoredConnection(request);
		EMPLOYEE_Dao daoEMPLOYEE= new EMPLOYEE_Impl(conn);
		String strResult=daoEMPLOYEE.getXML(empDto);
		//tra kq ve cho jsp
		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());			
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String method=request.getParameter("method");
		EMPLOYEE_PostDto postDTO=new EMPLOYEE_PostDto();
		String empid=request.getParameter("EMPID");
		String name=request.getParameter("NAME");
		String salary=request.getParameter("SALARY");
     	postDTO.EMP_ID=empid;
     	postDTO.NAME=name;
     	postDTO.SALARY=salary;
     	EMPLOYEE_Impl jdbc=new EMPLOYEE_Impl(Util.getStoredConnection(request));
	
		String msg = "success";
		if (method.equals("update")){
			msg = jdbc.update(postDTO);
		}
		else if (method.equals("delete")){
			msg = jdbc.delete(postDTO);
		}
		else if (method.equals("create")){
			msg = jdbc.insert(postDTO);
		}
		response.setContentType(Constant.CONTENT_TYPE_TEXT);
		response.getOutputStream().write("".getBytes());
		
	}

}
