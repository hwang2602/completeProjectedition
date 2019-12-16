package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.SINHVIEN_GetDto;
import com.bkacad.completeproj.dto.SINHVIEN_PostDto;

public interface SINHVIEN_Dao {
    public String getJSON(SINHVIEN_GetDto getDTO);
    public String getXML(SINHVIEN_GetDto getDTO);
    public String insert(SINHVIEN_PostDto postDTO);
    public String delete(SINHVIEN_PostDto postDTO);
    public String update(SINHVIEN_PostDto postDTO);
    public String getCbbQue();
    public String getCbbQue1();
}
