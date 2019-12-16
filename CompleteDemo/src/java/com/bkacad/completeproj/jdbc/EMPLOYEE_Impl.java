package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.util.*;
import com.bkacad.completeproj.dao.EMPLOYEE_Dao;
import com.bkacad.completeproj.dto.EMPLOYEE_GetDto;
import com.bkacad.completeproj.dto.EMPLOYEE_PostDto;
import java.util.List;
import java.util.Vector;
import java.util.ArrayList;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class EMPLOYEE_Impl implements EMPLOYEE_Dao {
	private Connection conn;
	public EMPLOYEE_Impl(Connection conn) {
		this.conn = conn;
	}
    public String  getXML(EMPLOYEE_GetDto getDTO) {
        try{
            String orderby = getDTO.getSidx();
            String sord = getDTO.getSord();
            int Start = 1, End = 50;
            if (!getDTO.getStart().equals("")) {
                try { Start = Integer.parseInt(getDTO.getStart()); } catch(Exception e){ }
            }
            if (!getDTO.getEnd().equals("")) {
                try { End = Integer.parseInt(getDTO.getEnd()); } catch(Exception e){ }
            }


            String sqlCall = "{ CALL SP_EMPLOYEE_Select(?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if(getDTO.EMP_ID == null || getDTO.EMP_ID.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, getDTO.EMP_ID);
            if(getDTO.NAME == null || getDTO.NAME.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, getDTO.NAME);
            if(getDTO.HIDE_DATE == null || getDTO.HIDE_DATE.trim().equals(""))
            	cs.setNull(7, java.sql.Types.FLOAT);
            else
            	cs.setFloat(7, Float.parseFloat(getDTO.HIDE_DATE));
            cs.setInt(3, 1);
            cs.setInt(4, 999999);
            cs.setString(5, orderby);
            cs.setString(6, sord);

            ResultSet rs = cs.executeQuery();

            long ilimit = Integer.parseInt(getDTO.getLimit());
            long count = 0;
            while (rs.next()) {
              count++; }
            long iTotalPage = count/ilimit;
            long acCount = iTotalPage * ilimit;
            if (acCount<count) iTotalPage++ ;

            cs.setInt(3, Start);
            cs.setInt(4, End);
            rs = cs.executeQuery();

            List<String> l = new Vector<String>();
            l.add("STT");
            l.add("EMP_ID");
            l.add("POSITION");
            l.add("NAME");
            l.add("HIRE_DATE");
            l.add("SALARY");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>"+getDTO.getPage()+"</page><total>"+String.valueOf(iTotalPage)+"</total><records>"+String.valueOf(count)+"</records>"+sb.toString()+"</rows>";
        }
        catch(Exception ex){
       	 	System.out.println("EMPLOYEE_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }


    public String CallIUP(int action, EMPLOYEE_PostDto postDTO){ // action = 1: Insert, 2: Update, 3: Delete
        try{
            String sqlCall = "{ CALL SP_EMPLOYEE_Update(?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if(postDTO.EMP_ID == null || postDTO.EMP_ID.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, postDTO.EMP_ID);
            if(postDTO.NAME == null || postDTO.NAME.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, postDTO.NAME);
            if(postDTO.HIRE_DATE == null || postDTO.HIRE_DATE.trim().equals(""))
            	cs.setNull(3, java.sql.Types.VARCHAR);
            else
            	cs.setString(3, postDTO.HIRE_DATE);
            cs.setInt(4, action);
            cs.registerOutParameter(5, java.sql.Types.INTEGER);
            cs.registerOutParameter(6, java.sql.Types.VARCHAR);

            cs.execute();

            int count = cs.getInt(5);
            String error = cs.getString(6);

            if(count == 0){
            	return "success";
            }
            else if(count == 2627){
            	return "duplicate";
            }
            else
            	return error;
        }
        catch(Exception ex){
            System.out.println("EMPLOYEE.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }


    public String insert(EMPLOYEE_PostDto postDTO){
        try{
        	return CallIUP(1, postDTO);
        }
        catch(Exception ex){
            System.out.println("EMPLOYEE.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }


    public String update(EMPLOYEE_PostDto postDTO){
       try{
        	return CallIUP(2, postDTO);
       }
       catch(Exception ex){
           System.out.println("EMPLOYEE.update() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
       }
    }

    public String delete(EMPLOYEE_PostDto postDTO){
        try{
        	return CallIUP(3, postDTO);
        }
        catch(Exception ex){
           // Luu y check dieu kien FK Contraint neu can!
           System.out.println("EMPLOYEE.delete() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
        }
    }


}
