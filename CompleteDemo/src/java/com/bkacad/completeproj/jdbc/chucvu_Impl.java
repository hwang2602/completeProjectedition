/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.dao.chucvu_Dao;
import com.bkacad.completeproj.dto.chucvu_GetDto;
import com.bkacad.completeproj.dto.chucvu_PostDto;
import com.bkacad.completeproj.util.Util;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;


public class chucvu_Impl implements chucvu_Dao {
    private Connection conn;
	public chucvu_Impl(Connection conn) {
		this.conn = conn;
	}
    @Override
    public String getXML(chucvu_GetDto getDTO) {
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


            String sqlCall = "{ CALL SP_chucvu_Select(?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if(getDTO.macv == null || getDTO.macv.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, getDTO.macv);
            if(getDTO.tencv == null || getDTO.tencv.trim().equals(""))
            	cs.setNull(2, java.sql.Types.NVARCHAR);
            else
            	cs.setString(2, getDTO.tencv);
            if(getDTO.mapb == null || getDTO.mapb.trim().equals(""))
            	cs.setNull(7, java.sql.Types.VARCHAR);
            else
            	cs.setString(7, getDTO.mapb);
            if(getDTO.congviec == null || getDTO.congviec.trim().equals(""))
            	cs.setNull(8, java.sql.Types.NVARCHAR);
            else
            	cs.setString(8, getDTO.congviec);
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
            l.add("macv");
            l.add("tencv");
            l.add("mapb");
            l.add("congviec");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>"+getDTO.getPage()+"</page><total>"+String.valueOf(iTotalPage)+"</total><records>"+String.valueOf(count)+"</records>"+sb.toString()+"</rows>";
        }
        catch(Exception ex){
       	 	System.out.println("chucvu_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }
    public String CallIUP(int action, chucvu_PostDto postDTO){ // action = 1: Insert, 2: Update, 3: Delete
        try{
            String sqlCall = "{ CALL SP_chucvu_Update(?, ?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if(postDTO.macv == null || postDTO.macv.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, postDTO.macv);
            if(postDTO.tencv == null || postDTO.tencv.trim().equals(""))
            	cs.setNull(2, java.sql.Types.NVARCHAR);
            else
            	cs.setString(2, postDTO.tencv);
            if(postDTO.mapb == null || postDTO.mapb.trim().equals(""))
            	cs.setNull(4, java.sql.Types.VARCHAR);
            else
            	cs.setString(4, postDTO.mapb);
            if(postDTO.congviec == null || postDTO.congviec.trim().equals(""))
            	cs.setNull(3, java.sql.Types.NVARCHAR);
            else
            	cs.setString(3, postDTO.congviec);
            cs.setInt(5, action);
            cs.registerOutParameter(6, java.sql.Types.INTEGER);
            cs.registerOutParameter(7, java.sql.Types.VARCHAR);

            cs.execute();

            int count = cs.getInt(6);
            String error = cs.getString(7);

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
            System.out.println("chucvu.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }

    @Override
    public String insert(chucvu_PostDto postDTO) {
        try{
        	return CallIUP(1, postDTO);
        }
        catch(Exception ex){
            System.out.println("chucvu.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String delete(chucvu_PostDto postDTO) {
       try{
        	return CallIUP(3, postDTO);
        }
        catch(Exception ex){
           // Luu y check dieu kien FK Contraint neu can!
           System.out.println("chucvu.delete() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
        }
    }

    @Override
    public String update(chucvu_PostDto postDTO) {
        try {
            return CallIUP(2, postDTO);
        } catch (Exception ex) {
            System.out.println("chucvu.update() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }
    
}
