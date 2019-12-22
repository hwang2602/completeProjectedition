/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.servlet;

import com.bkacad.completeproj.dao.hopdonglaodong_Dao;
import com.bkacad.completeproj.dto.hopdonglaodong_GetDto;
import com.bkacad.completeproj.dto.hopdonglaodong_PostDto;
import com.bkacad.completeproj.jdbc.hopdonglaodong_Impl;
import com.bkacad.completeproj.util.Constant;
import com.bkacad.completeproj.util.Util;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet("/hopdonglaodong_Servlet")
public class hopdonglaodong_Servlet extends AbstractServlet {

   private static final long serialVersionUID = 1L;

    public hopdonglaodong_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("hopdonglaodong_Servlet: doGet: begin");
		Connection conn = Util.getStoredConnection(request);
		hopdonglaodong_Dao daohopdonglaodong= new hopdonglaodong_Impl(conn);
		hopdonglaodong_GetDto getDTO = new hopdonglaodong_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.mahd = Util.checkNull(request.getParameter("mahd"));
			getDTO.manv = Util.checkNull(request.getParameter("manv"));
			getDTO.loaihd = Util.checkNull(request.getParameter("loaihd"));
                        getDTO.tungay = Util.checkNull(request.getParameter("tungay"));
                        getDTO.denngay = Util.checkNull(request.getParameter("denngay"));
                        getDTO.ghichu = Util.checkNull(request.getParameter("ghichu"));
			strResult=daohopdonglaodong.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		//System.out.println("hopdonglaodong_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("hopdonglaodong_Servlet: doPost: begin");
			String s=request.getParameter("xml");
			System.out.println("hopdonglaodong_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			Connection conn = Util.getStoredConnection(request);
			hopdonglaodong_Dao daoObj = new hopdonglaodong_Impl(conn);
			hopdonglaodong_PostDto dtoObj = new hopdonglaodong_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("hopdonglaodong_Servlet: doPost: Method=" + method);		
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
			System.out.println("hopdonglaodong_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}

 
}
