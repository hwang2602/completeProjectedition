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
public class chamcong_PostDto extends PostDTO {

    public String machamcong;
    public String manv;
    public String ngaychamcong;
     public String trangthai;
    public String xml;

    public void getDTO() {
        //xml = Util.toJAVA(xml);
        machamcong = Util.getTag(xml, "<machamcong>", "</machamcong>");
        manv = Util.getTag(xml, "<manv>", "</manv>");
        ngaychamcong = Util.getTag(xml, "<ngaychamcong>", "</ngaychamcong>");
        trangthai = Util.getTag(xml, "<trangthai>", "</trangthai>");
    }
}
