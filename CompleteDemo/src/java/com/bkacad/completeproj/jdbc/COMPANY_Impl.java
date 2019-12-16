package com.bkacad.completeproj.jdbc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import com.bkacad.completeproj.dao.COMPANY_Dao;
import com.bkacad.completeproj.dto.COMPANY_GetDto;
import com.bkacad.completeproj.dto.COMPANY_PostDto;
import com.bkacad.completeproj.util.Util;

public class COMPANY_Impl implements COMPANY_Dao {
	private Connection conn;
	public COMPANY_Impl(Connection conn) {
		this.conn = conn;
	}
    public String  getXML(COMPANY_GetDto getDTO) {
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


            String sqlCall = "{ CALL SP_COMPANY_Select(?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if(getDTO.CName == null || getDTO.CName.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, getDTO.CName);
            if(getDTO.StockPrice == null || getDTO.StockPrice.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, getDTO.StockPrice);
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
            l.add("CName");
            l.add("StockPrice");
            l.add("Country");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>"+getDTO.getPage()+"</page><total>"+String.valueOf(iTotalPage)+"</total><records>"+String.valueOf(count)+"</records>"+sb.toString()+"</rows>";
        }
        catch(Exception ex){
       	 	System.out.println("COMPANY_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }


    public String CallIUP(int action, COMPANY_PostDto postDTO){ // action = 1: Insert, 2: Update, 3: Delete
        try{
            String sqlCall = "{ CALL SP_COMPANY_Update(?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if(postDTO.CName == null || postDTO.CName.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, postDTO.CName);
            if(postDTO.StockPrice == null || postDTO.StockPrice.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, postDTO.StockPrice);
            if(postDTO.Country == null || postDTO.Country.trim().equals(""))
            	cs.setNull(3, java.sql.Types.VARCHAR);
            else
            	cs.setString(3, postDTO.Country);
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
            System.out.println("COMPANY.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }


    public String insert(COMPANY_PostDto postDTO){
        try{
        	return CallIUP(1, postDTO);
        }
        catch(Exception ex){
            System.out.println("COMPANY.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }


    public String update(COMPANY_PostDto postDTO){
       try{
        	return CallIUP(2, postDTO);
       }
       catch(Exception ex){
           System.out.println("COMPANY.update() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
       }
    }

    public String delete(COMPANY_PostDto postDTO){
        try{
        	return CallIUP(3, postDTO);
        }
        catch(Exception ex){
           // Luu y check dieu kien FK Contraint neu can!
           System.out.println("COMPANY.delete() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
        }
    }


}
