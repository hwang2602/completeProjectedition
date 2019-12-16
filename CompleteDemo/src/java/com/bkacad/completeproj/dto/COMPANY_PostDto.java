package com.bkacad.completeproj.dto;

import com.bkacad.completeproj.util.Util;
import com.bkacad.completeproj.dto.PostDTO;

public class COMPANY_PostDto extends PostDTO{

    public String CName;
    public String StockPrice;
    public String Country;
    public String xml;

    public void getDTO(){
        //xml = Util.toJAVA(xml);
        CName = Util.getTag(xml,"<CName>","</CName>");
        StockPrice = Util.getTag(xml,"<StockPrice>","</StockPrice>");
        Country = Util.getTag(xml,"<Country>","</Country>");
    }
}
