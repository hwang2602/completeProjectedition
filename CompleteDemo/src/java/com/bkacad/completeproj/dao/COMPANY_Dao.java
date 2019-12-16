package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.COMPANY_GetDto;
import com.bkacad.completeproj.dto.COMPANY_PostDto;

public interface COMPANY_Dao {
    public String getXML(COMPANY_GetDto getDTO);
    public String insert(COMPANY_PostDto postDTO);
    public String delete(COMPANY_PostDto postDTO);
    public String update(COMPANY_PostDto postDTO);
}
