package com.bkacad.completeproj.dto;

import com.bkacad.completeproj.util.Util;

import javax.servlet.http.HttpServletRequest;

import com.bkacad.completeproj.dto.PostDTO;

public class SINHVIEN_PostDto extends PostDTO{

    public String MSV;
    public String Hoten;
    public String GT;
    public String NS;
    public String Que;
    public String Lop;
    public String xml;

    public void getDTO(){
        //xml = Util.toJAVA(xml);
        MSV = Util.getTag(xml,"<MSV>","</MSV>");
        Hoten = Util.getTag(xml,"<Hoten>","</Hoten>");
        GT = Util.getTag(xml,"<GT>","</GT>");
        NS = Util.getTag(xml,"<NS>","</NS>");
        Que = Util.getTag(xml,"<Que>","</Que>");
        Lop = Util.getTag(xml,"<Lop>","</Lop>");
    }
    public void getDTO(HttpServletRequest request){
        MSV = Util.checkNull(request.getParameter("MSV"));
        Hoten = Util.checkNull(request.getParameter("Hoten"));
        GT = Util.checkNull(request.getParameter("GT"));
        NS = Util.checkNull(request.getParameter("NS"));
        Que = Util.checkNull(request.getParameter("Que"));
        Lop = Util.checkNull(request.getParameter("Lop"));
    }
}
