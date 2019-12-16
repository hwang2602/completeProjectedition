package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.PRODUCT_GetDto;
import com.bkacad.completeproj.dto.PRODUCT_PostDto;

public interface PRODUCT_Dao {
    public String getXML(PRODUCT_GetDto getDTO);
    public String insert(PRODUCT_PostDto postDTO);
    public String delete(PRODUCT_PostDto postDTO);
    public String update(PRODUCT_PostDto postDTO);
}
