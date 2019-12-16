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
public class phongban_PostDto extends PostDTO {

    public String mapb;
    public String tenpb;
    public String diachi;
    public String sdt;
    public String xml;
    public void getDTO(){
        //xml = Util.toJAVA(xml);
        mapb = Util.getTag(xml,"<mapb>","</mapb>");
        tenpb = Util.getTag(xml,"<tenpb>","</tenpb>");
        diachi = Util.getTag(xml,"<diachi>","</diachi>");
        sdt = Util.getTag(xml, "<sdt>","</sdt>");
        
    }
}
