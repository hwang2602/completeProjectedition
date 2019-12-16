package com.bkacad.completeproj.dao;

import com.bkacad.completeproj.dto.EMPLOYEE_GetDto;
import com.bkacad.completeproj.dto.EMPLOYEE_PostDto;

public interface EMPLOYEE_Dao {
	 public String getXML(EMPLOYEE_GetDto getDTO);
	    public String insert(EMPLOYEE_PostDto postDTO);
	    public String delete(EMPLOYEE_PostDto postDTO);
	    public String update(EMPLOYEE_PostDto postDTO);

}
