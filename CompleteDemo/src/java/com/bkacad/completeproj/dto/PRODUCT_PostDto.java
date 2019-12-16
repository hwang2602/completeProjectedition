package com.bkacad.completeproj.dto;

import com.bkacad.completeproj.util.Util;
import com.bkacad.completeproj.dto.PostDTO;

public class PRODUCT_PostDto extends PostDTO{

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
