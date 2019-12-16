/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.servlet;

import com.bkacad.completeproj.dao.luong_Dao;
import com.bkacad.completeproj.dto.luong_GetDto;
import com.bkacad.completeproj.dto.luong_PostDto;
import com.bkacad.completeproj.jdbc.luong_Impl;
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
@WebServlet("/luong_Servlet")
public class luong_Servlet extends AbstractServlet {

   private static final long serialVersionUID = 1L;

    
    public luong_Servlet(){
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("luong_Servlet: doGet: begin");
		Connection conn = Util.getStoredConnection(request);
		luong_Dao daoluong= new luong_Impl(conn);
		luong_GetDto getDTO = new luong_GetDto();
		initGetDTO(getDTO,request);

		String strResult = "";
			getDTO.ma = Util.checkNull(request.getParameter("ma"));
			getDTO.manv = Util.checkNull(request.getParameter("manv"));
			getDTO.luongcoban = Util.checkNull(request.getParameter("luongcoban"));
                        getDTO.phucap = Util.checkNull(request.getParameter("phucap"));
                        getDTO.tienthuong = Util.checkNull(request.getParameter("tienthuong"));
                        getDTO.baohiem = Util.checkNull(request.getParameter("baohiem"));
                        getDTO.tong = Util.checkNull(request.getParameter("tong"));
                        getDTO.ngaylinh = Util.checkNull(request.getParameter("ngaylinh"));
                        getDTO.ghichu = Util.checkNull(request.getParameter("ghichu"));
			strResult=daoluong.getXML(getDTO);

		response.setContentType(Constant.CONTENT_TYPE_XML);
		response.getOutputStream().write(strResult.getBytes());		
		//System.out.println("luong_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("luong_Servlet: doPost: begin");
			String s=request.getParameter("xml");
			System.out.println("luong_Servlet: doPost: s=" + s);
			String method = Util.getTag(s,"<method>","</method>");

			Connection conn = Util.getStoredConnection(request);
			luong_Dao daoObj = new luong_Impl(conn);
			luong_PostDto dtoObj = new luong_PostDto();
			dtoObj.xml = s;
			dtoObj.getDTO();

			System.out.println("luong_Servlet: doPost: Method=" + method);		
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
			System.out.println("luong_Servlet: doPost: End");
//		}
//		else{
//			response.getWriter().println(Util.toHTML("<ERRDESC>Hết phiên làm việc, hãy đăng nhập lại để thực hiện!<ERRDESC>"));
//		}

	}
    
}
