/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.chucvu_GetDto;
import com.bkacad.completeproj.dto.chucvu_PostDto;

/**
 *
 * @author Admin
 */
public interface chucvu_Dao {
    public String getXML(chucvu_GetDto getDTO);
    public String insert(chucvu_PostDto postDTO);
    public String delete(chucvu_PostDto postDTO);
    public String update(chucvu_PostDto postDTO);
}
