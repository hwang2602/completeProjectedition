/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.servlet;

import com.bkacad.completeproj.dao.chamcong_Dao;
import com.bkacad.completeproj.dto.chamcong_GetDto;
import com.bkacad.completeproj.dto.chamcong_PostDto;
import com.bkacad.completeproj.jdbc.chamcong_Impl;
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
@WebServlet(name = "chamcong_Servlet", urlPatterns = {"/chamcong_Servlet"})
public class chamcong_Servlet extends AbstractServlet {
    private static final long serialVersionUID = 1L;

    public chamcong_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("chamcong_Servlet: doGet: begin");
		Connection conn = Util.getStoredConnection(request);
		chamcong_Dao daochamcong= new chamcong_Impl(conn);
		chamcong_GetDto getDTO = new chamcong_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.machamcong = Util.checkNull(request.getParameter("machamcong"));
			getDTO.manv = Util.checkNull(request.getParameter("manv"));
                        getDTO.ngaychamcong = Util.checkNull(request.getParameter("ngaychamcong"));
                        getDTO.trangthai = Util.checkNull(request.getParameter("trangthai"));
			strResult=daochamcong.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		//System.out.println("chamcong_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("chamcong_Servlet: doPost: begin");
			String s=request.getParameter("xml");
			System.out.println("chamcong_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			Connection conn = Util.getStoredConnection(request);
			chamcong_Dao daoObj = new chamcong_Impl(conn);
			chamcong_PostDto dtoObj = new chamcong_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("chamcong_Servlet: doPost: Method=" + method);		
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
			System.out.println("chamcong_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
   

}
