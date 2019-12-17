/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.nhanvien_GetDto;
import com.bkacad.completeproj.dto.nhanvien_PostDto;

/**
 *
 * @author Admin
 */
public interface nhanvien_Dao {
    public String getXML(nhanvien_GetDto getDTO);
    public String insert(nhanvien_PostDto postDTO);
    public String delete(nhanvien_PostDto postDTO);
    public String update(nhanvien_PostDto postDTO);
    
}
