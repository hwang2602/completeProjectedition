
package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.PRODUCT1_GetDto;
import com.bkacad.completeproj.dto.PRODUCT1_PostDto;



public interface PRODUCT1_Dao {
    public String getXML(PRODUCT1_GetDto getDTO);
    public String insert(PRODUCT1_PostDto postDTO);
    public String delete(PRODUCT1_PostDto postDTO);
    public String update(PRODUCT1_PostDto postDTO);
}
