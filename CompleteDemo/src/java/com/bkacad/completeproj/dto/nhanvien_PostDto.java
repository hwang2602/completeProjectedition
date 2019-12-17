/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dto;

import com.bkacad.completeproj.util.Util;

/**
 *
 * @author Admin
 */
public class nhanvien_PostDto extends PostDTO {

    public String manv;
    public String hoten;
    public String ngaysinh;
    public String gioitinh;
    public String diachi;
    public String sdt;
    public String mapb;
    public String macv;
    public String xml;
    public void getDTO(){
        //xml = Util.toJAVA(xml);
        manv = Util.getTag(xml,"<manv>","</manv>");
        hoten = Util.getTag(xml,"<hoten>","</hoten>");
        ngaysinh = Util.getTag(xml,"<ngaysinh>","</ngaysinh>");
        gioitinh = Util.getTag(xml,"<gioitinh>","</gioitinh>");
        diachi = Util.getTag(xml,"<diachi>","</diachi>");
        sdt = Util.getTag(xml,"<sdt>","</sdt>");
        mapb = Util.getTag(xml,"<mapb>","</mapb>");
        macv = Util.getTag(xml,"<macv>","</macv>");
    }
}
