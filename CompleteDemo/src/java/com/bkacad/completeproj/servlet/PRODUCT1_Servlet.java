/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.servlet;

import com.bkacad.completeproj.dao.PRODUCT1_Dao;
import com.bkacad.completeproj.dto.PRODUCT1_GetDto;
import com.bkacad.completeproj.dto.PRODUCT1_PostDto;
import com.bkacad.completeproj.jdbc.PRODUCT1_Impl;
import com.bkacad.completeproj.util.Constant;
import com.bkacad.completeproj.util.Util;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PRODUCT1_Servlet")
public class PRODUCT1_Servlet extends AbstractServlet {
    private static final long serialVersionUID = 1L;

    public PRODUCT1_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = Util.getStoredConnection(request);
		PRODUCT1_Dao daoPRODUCT= new PRODUCT1_Impl(conn);
		PRODUCT1_GetDto getDTO = new PRODUCT1_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.CODE = Util.checkNull(request.getParameter("CODE"));
			getDTO.NAME = Util.checkNull(request.getParameter("NAME"));
			getDTO.PRICE = Util.checkNull(request.getParameter("PRICE"));
			strResult=daoPRODUCT.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("PRODUCT1_Servlet: doPost: begin");
			String s=request.getParameter("xml");
			System.out.println("PRODUCT_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			Connection conn = Util.getStoredConnection(request);
			PRODUCT1_Dao daoObj = new PRODUCT1_Impl(conn);
			PRODUCT1_PostDto dtoObj = new PRODUCT1_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("PRODUCT1_Servlet: doPost: Method=" + method);		
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
			System.out.println("PRODUCT1_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
}
