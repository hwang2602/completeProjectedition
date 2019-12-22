/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.dao.hopdonglaodong_Dao;
import com.bkacad.completeproj.dto.hopdonglaodong_GetDto;
import com.bkacad.completeproj.dto.hopdonglaodong_PostDto;
import com.bkacad.completeproj.util.Util;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class hopdonglaodong_Impl implements hopdonglaodong_Dao{
    
    private Connection conn;
	public hopdonglaodong_Impl(Connection conn) {
		this.conn = conn;
	}
    @Override
    public String getXML(hopdonglaodong_GetDto getDTO) {
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


            String sqlCall = "{ CALL SP_hopdonglaodong_Select(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if(getDTO.mahd == null || getDTO.mahd.trim().equals(""))
            	cs.setNull(1, java.sql.Types.INTEGER);
            else
            	cs.setString(1, getDTO.mahd);
            if(getDTO.manv == null || getDTO.manv.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, getDTO.manv);
            if(getDTO.loaihd == null || getDTO.loaihd.trim().equals(""))
            	cs.setNull(7, java.sql.Types.NVARCHAR);
            else
            	cs.setString(7, getDTO.loaihd);
            if(getDTO.tungay == null || getDTO.tungay.trim().equals(""))
            	cs.setNull(8, java.sql.Types.DATE);
            else
            	cs.setString(8, getDTO.tungay);
            if(getDTO.denngay == null || getDTO.denngay.trim().equals(""))
            	cs.setNull(9, java.sql.Types.DATE);
            else
            	cs.setString(9, getDTO.denngay);
            if(getDTO.ghichu == null || getDTO.ghichu.trim().equals(""))
            	cs.setNull(10, java.sql.Types.NVARCHAR);
            else
            	cs.setString(10, getDTO.ghichu);
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
            l.add("mahd");
            l.add("manv");
            l.add("loaihd");
            l.add("tungay");
            l.add("denngay");
            l.add("ghichu");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>"+getDTO.getPage()+"</page><total>"+String.valueOf(iTotalPage)+"</total><records>"+String.valueOf(count)+"</records>"+sb.toString()+"</rows>";
        }
        catch(Exception ex){
       	 	System.out.println("hopdonglaodong_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }
    
    public String CallIUP(int action, hopdonglaodong_PostDto postDTO){ // action = 1: Insert, 2: Update, 3: Delete
        try{
            String sqlCall = "{ CALL SP_hopdonglaodong_Update(?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if(postDTO.mahd == null || postDTO.mahd.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, postDTO.mahd);
            if(postDTO.manv == null || postDTO.manv.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, postDTO.manv);
            if(postDTO.loaihd == null || postDTO.loaihd.trim().equals(""))
            	cs.setNull(3, java.sql.Types.VARCHAR);
            else
            	cs.setString(3, postDTO.loaihd);
            if(postDTO.tungay == null || postDTO.tungay.trim().equals(""))
            	cs.setNull(4, java.sql.Types.VARCHAR);
            else
            	cs.setString(4, postDTO.tungay);
            if(postDTO.denngay == null || postDTO.denngay.trim().equals(""))
            	cs.setNull(5, java.sql.Types.VARCHAR);
            else
            	cs.setString(5, postDTO.denngay);
            if(postDTO.denngay == null || postDTO.denngay.trim().equals(""))
            	cs.setNull(6, java.sql.Types.VARCHAR);
            else
            	cs.setString(6, postDTO.denngay);
            cs.setInt(7, action);
            cs.registerOutParameter(8, java.sql.Types.INTEGER);
            cs.registerOutParameter(9, java.sql.Types.VARCHAR);

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
            System.out.println("hopdonglaodong.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }
    @Override
    public String insert(hopdonglaodong_PostDto postDTO) {
         try{
        	return CallIUP(1, postDTO);
        }
        catch(Exception ex){
            System.out.println("hopdonglaodong.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String delete(hopdonglaodong_PostDto postDTO) {
        try{
        	return CallIUP(2, postDTO);
       }
       catch(Exception ex){
           System.out.println("hopdonglaodong.update() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
       }
    }

    @Override
    public String update(hopdonglaodong_PostDto postDTO) {
        try{
        	return CallIUP(3, postDTO);
        }
        catch(Exception ex){
           // Luu y check dieu kien FK Contraint neu can!
           System.out.println("hopdonglaodong.delete() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
        }
    }
    
}
