/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.phongban_GetDto;
import com.bkacad.completeproj.dto.phongban_PostDto;

/**
 *
 * @author Admin
 */
public interface phongban_Dao {
    public String getXML(phongban_GetDto getDTO);
    public String insert(phongban_PostDto postDTO);
    public String delete(phongban_PostDto postDTO);
    public String update(phongban_PostDto postDTO);
}
