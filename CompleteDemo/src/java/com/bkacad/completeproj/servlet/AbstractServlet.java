package com.bkacad.completeproj.servlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import com.bkacad.completeproj.dto.GetDTO;
import com.bkacad.completeproj.util.Util;

public class AbstractServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void initGetDTO(GetDTO getDTO,HttpServletRequest request) {
    	try {
    		String page = Util.checkNull(request.getParameter("page"));
        	String limit = Util.checkNull(request.getParameter("rows"));
        	String sidx = Util.checkNull(request.getParameter("sidx"));
        	String sord = Util.checkNull(request.getParameter("sord"));
        	if(!page.equals(""))
        		getDTO.setPage(page);
        	else
        		getDTO.setPage("1");
        	if(!limit.equals(""))
        		getDTO.setLimit(limit);
        	else
        		getDTO.setLimit("10");
        	
        	if(!sidx.equals(""))
        		getDTO.setSidx(sidx);
        	else
        		getDTO.setSidx("id");
        	
        	if(!sord.equals(""))
        		getDTO.setSord(sord);
        	else
        		getDTO.setSord("asc");
        	
        	int ipage = Integer.parseInt(getDTO.getPage());
			int ilimit = Integer.parseInt(getDTO.getLimit());
			if (ipage>0){
				String Start =  String.valueOf((ipage-1)*ilimit + 1);
				String End = String.valueOf(ipage*ilimit);
				getDTO.setStart(Start);
				getDTO.setEnd(End);
			}
		} catch (Exception e) {
		}
    	
		try {
			String keyword = Util.checkNull(request.getParameter("keyword"));
			if(!keyword.equals(""))
	    		getDTO.setKeyword(keyword);
		} catch (Exception e) {
		}
    	
	}
	
}
