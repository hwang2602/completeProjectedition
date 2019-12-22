/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.servlet;

import com.bkacad.completeproj.dao.chucvu_Dao;
import com.bkacad.completeproj.dto.chucvu_GetDto;
import com.bkacad.completeproj.dto.chucvu_PostDto;
import com.bkacad.completeproj.jdbc.chucvu_Impl;
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

@WebServlet("/chucvu_Servlet")
public class chucvu_Servlet extends AbstractServlet {

    private static final long serialVersionUID = 1L;

    public chucvu_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("chucvu_Servlet: doGet: begin");
		Connection conn = Util.getStoredConnection(request);
		chucvu_Dao daochucvu= new chucvu_Impl(conn);
		chucvu_GetDto getDTO = new chucvu_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.macv = Util.checkNull(request.getParameter("macv"));
			getDTO.tencv = Util.checkNull(request.getParameter("tencv"));
                        getDTO.mapb = Util.checkNull(request.getParameter("mapb"));
			strResult=daochucvu.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		//System.out.println("chucvu_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("chucvu_Servlet: doPost: begin");
			String s=request.getParameter("xml");
			System.out.println("chucvu_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			Connection conn = Util.getStoredConnection(request);
			chucvu_Dao daoObj = new chucvu_Impl(conn);
			chucvu_PostDto dtoObj = new chucvu_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("chucvu_Servlet: doPost: Method=" + method);		
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
			System.out.println("chucvu_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
    

}
