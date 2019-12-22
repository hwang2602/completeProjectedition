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
public class hopdonglaodong_PostDto extends PostDTO{
    public String mahd;
    public String manv;
    public String loaihd;
    public String tungay;
    public String denngay;
    public String ghichu;
    public String xml;
    public void getDTO(){
        //xml = Util.toJAVA(xml);
        mahd = Util.getTag(xml,"<mahd>","</mahd>");
        manv = Util.getTag(xml,"<manv>","</manv>");
        loaihd = Util.getTag(xml,"<loaihd>","</loaihd>");
        tungay = Util.getTag(xml,"<tungay>","</tungay>");
        denngay = Util.getTag(xml,"<denngay>","</denngay>");
        ghichu = Util.getTag(xml,"<ghichu>","</ghichu>");
    }
}
