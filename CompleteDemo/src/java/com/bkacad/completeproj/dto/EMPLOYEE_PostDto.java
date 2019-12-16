package com.bkacad.completeproj.dto;

import com.bkacad.completeproj.util.Util;
import com.bkacad.completeproj.dto.PostDTO;

public class EMPLOYEE_PostDto extends PostDTO{

    public String EMP_ID;
    public String NAME;
    public String POSITION;
    public String HIRE_DATE;
    public String SALARY;
    public String BRANCH_CODE;
    public String DEPARTMENT;
    public String SUPERVISOR;

    public void getDTO(){
        //xml = Util.toJAVA(xml);
    	EMP_ID = Util.getTag(xml,"<EMP_ID>","</EMP_ID>");
    	NAME = Util.getTag(xml,"<NAME>","</NAME>");
    	POSITION = Util.getTag(xml,"<POSITION>","</POSITION>");
    	HIRE_DATE = Util.getTag(xml,"<HIRE_DATE>","</HIRE_DATE>");
    	SALARY = Util.getTag(xml,"<SALARY>","</SALARY>");
    	BRANCH_CODE = Util.getTag(xml,"<BRANCH_CODE>","</BRANCH_CODE>");
    	DEPARTMENT = Util.getTag(xml,"<DEPARTMENT>","</DEPARTMENT>");
    	SUPERVISOR = Util.getTag(xml,"<SUPERVISOR>","</SUPERVISOR>");
    }
}
