/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.luong_GetDto;
import com.bkacad.completeproj.dto.luong_PostDto;

/**
 *
 * @author Admin
 */
public interface luong_Dao {
    public String getXML(luong_GetDto getDTO);
    public String insert(luong_PostDto postDTO);
    public String delete(luong_PostDto postDTO);
    public String update(luong_PostDto postDTO);
}
