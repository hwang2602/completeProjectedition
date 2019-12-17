/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.servlet;

import com.bkacad.completeproj.dao.nhanvien_Dao;
import com.bkacad.completeproj.dto.nhanvien_GetDto;
import com.bkacad.completeproj.dto.nhanvien_PostDto;
import com.bkacad.completeproj.jdbc.nhanvien_Impl;
import com.bkacad.completeproj.util.Constant;
import com.bkacad.completeproj.util.Util;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet("/nhanvien_Servlet")
public class nhanvien_Servlet extends AbstractServlet {
    private static final long serialVersionUID = 1L;

    public nhanvien_Servlet() {
        super();
    }
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("nhanvien_Servlet: doGet: begin");
		Connection conn = Util.getStoredConnection(request);
		nhanvien_Dao daonhanvien= new nhanvien_Impl(conn);
		nhanvien_GetDto getDTO = new nhanvien_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.manv = Util.checkNull(request.getParameter("manv"));
			getDTO.hoten = Util.checkNull(request.getParameter("hoten"));
			getDTO.ngaysinh = Util.checkNull(request.getParameter("ngaysinh"));
                        getDTO.gioitinh = Util.checkNull(request.getParameter("gioitinh"));
			getDTO.diachi = Util.checkNull(request.getParameter("diachi"));
                        getDTO.sdt = Util.checkNull(request.getParameter("sdt"));
			getDTO.mapb = Util.checkNull(request.getParameter("mapb"));
                        getDTO.macv = Util.checkNull(request.getParameter("macv"));
			
			strResult=daonhanvien.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		//System.out.println("nhanvien_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("nhanvien_Servlet: doPost: begin");
			String s=request.getParameter("xml");
			System.out.println("nhanvien_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			Connection conn = Util.getStoredConnection(request);
			nhanvien_Dao daoObj = new nhanvien_Impl(conn);
			nhanvien_PostDto dtoObj = new nhanvien_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("nhanvien_Servlet: doPost: Method=" + method);		
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
			System.out.println("nhanvien_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
}
