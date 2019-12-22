
package com.bkacad.completeproj.dto;

import com.bkacad.completeproj.util.Util;


public class chucvu_PostDto extends PostDTO{
    public String macv;
    public String tencv;
    public String congviec;
    public String mapb;
    public String xml;
     public void getDTO(){
        //xml = Util.toJAVA(xml);
        macv = Util.getTag(xml,"<macv>","</macv>");
        tencv = Util.getTag(xml,"<tencv>","</tencv>");
        congviec = Util.getTag(xml,"<congviec>","</congviec>");
        mapb = Util.getTag(xml,"<mapb>","</mapb>");
        
    }
}
