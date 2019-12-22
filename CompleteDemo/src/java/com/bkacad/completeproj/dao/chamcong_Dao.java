/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.chamcong_GetDto;
import com.bkacad.completeproj.dto.chamcong_PostDto;

/**
 *
 * @author Admin
 */
public interface chamcong_Dao {
    public String getXML(chamcong_GetDto getDTO);
    public String insert(chamcong_PostDto postDTO);
    public String delete(chamcong_PostDto postDTO);
    public String update(chamcong_PostDto postDTO);
    public int getNgayNghi(chamcong_GetDto getDTO);
}
