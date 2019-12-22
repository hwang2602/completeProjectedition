/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.hopdonglaodong_GetDto;
import com.bkacad.completeproj.dto.hopdonglaodong_PostDto;

/**
 *
 * @author Admin
 */
public interface hopdonglaodong_Dao {
    public String getXML(hopdonglaodong_GetDto getDTO);
    public String insert(hopdonglaodong_PostDto postDTO);
    public String delete(hopdonglaodong_PostDto postDTO);
    public String update(hopdonglaodong_PostDto postDTO);
}
