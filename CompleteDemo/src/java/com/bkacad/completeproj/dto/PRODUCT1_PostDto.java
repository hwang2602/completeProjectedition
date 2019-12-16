/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dto;

import com.bkacad.completeproj.util.Util;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Admin
 */
public class PRODUCT1_PostDto extends PostDTO {

    public String CODE;
    public String NAME;
    public String PRICE;
    public String xml;
    public void getDTO(){
        //xml = Util.toJAVA(xml);
        CODE = Util.getTag(xml,"<CODE>","</CODE>");
        NAME = Util.getTag(xml,"<NAME>","</NAME>");
        PRICE = Util.getTag(xml,"<PRICE>","</PRICE>");
        
    }

    
}
