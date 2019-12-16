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
public class luong_PostDto extends PostDTO{
    public String ma;
    public String manv;
    public String luongcoban;
    public String phucap;
    public String tienthuong;
    public String baohiem;
    public String tong;
    public String ngaylinh;
    public String ghichu;
    public String xml;
    public void getDTO(){
        //xml = Util.toJAVA(xml);
        ma = Util.getTag(xml,"<ma>","</ma>");
        manv = Util.getTag(xml,"<manv>","</manv>");
        luongcoban = Util.getTag(xml,"<luongcoban>","</luongcoban>");
        phucap = Util.getTag(xml,"<phucap>","</phucap>");
        tienthuong = Util.getTag(xml,"<tienthuong>","</tienthuong>");
        baohiem = Util.getTag(xml,"<baohiem>","</baohiem>");
        tong = Util.getTag(xml,"<tong>","</tong>");
        ngaylinh = Util.getTag(xml,"<ngaylinh>","</ngaylinh>");
        ghichu = Util.getTag(xml,"<ghichu>","</ghichu>");
    }

}
