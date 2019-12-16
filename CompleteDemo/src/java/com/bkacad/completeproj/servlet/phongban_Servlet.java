/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.servlet;

import com.bkacad.completeproj.dao.phongban_Dao;
import com.bkacad.completeproj.dto.phongban_GetDto;
import com.bkacad.completeproj.dto.phongban_PostDto;
import com.bkacad.completeproj.jdbc.phongban_Impl;
import com.bkacad.completeproj.util.Constant;
import com.bkacad.completeproj.util.Util;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/phongban_Servlet")
public class phongban_Servlet extends AbstractServlet {

    private static final long serialVersionUID = 1L;

    public phongban_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("phongban_Servlet: doGet: begin");
		Connection conn = Util.getStoredConnection(request);
		phongban_Dao daophongban= new phongban_Impl(conn);
		phongban_GetDto getDTO = new phongban_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.mapb = Util.checkNull(request.getParameter("mapb"));
			getDTO.tenpb = Util.checkNull(request.getParameter("tenpb"));
                        getDTO.diachi = Util.checkNull(request.getParameter("diachi"));
			strResult=daophongban.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		//System.out.println("phongban_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("phongban_Servlet: doPost: begin");
			String s=request.getParameter("xml");
			System.out.println("phongban_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			Connection conn = Util.getStoredConnection(request);
			phongban_Dao daoObj = new phongban_Impl(conn);
			phongban_PostDto dtoObj = new phongban_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("phongban_Servlet: doPost: Method=" + method);		
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
			System.out.println("phongban_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
    
}
