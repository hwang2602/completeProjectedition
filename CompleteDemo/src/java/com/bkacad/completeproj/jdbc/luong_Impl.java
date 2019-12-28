/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.dao.luong_Dao;
import com.bkacad.completeproj.dto.luong_GetDto;
import com.bkacad.completeproj.dto.luong_PostDto;
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
public class luong_Impl implements luong_Dao{
    private Connection conn;
	public luong_Impl(Connection conn) {
		this.conn = conn;
	}
    @Override
    public String getXML(luong_GetDto getDTO) {
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


            String sqlCall = "{ CALL SP_luong_Select(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if(getDTO.ma == null || getDTO.ma.trim().equals(""))
            	cs.setNull(1, java.sql.Types.INTEGER);
            else
            	cs.setInt(1,  Integer.parseInt(getDTO.ma));
            if(getDTO.manv == null || getDTO.manv.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, getDTO.manv);
            if(getDTO.luongcoban == null || getDTO.luongcoban.trim().equals(""))
            	cs.setNull(7, java.sql.Types.DECIMAL);
            else
            	cs.setFloat(7, Float.parseFloat(getDTO.luongcoban));
            if(getDTO.phucap == null || getDTO.phucap.trim().equals(""))
            	cs.setNull(8, java.sql.Types.DECIMAL);
            else
            	cs.setFloat(8, Float.parseFloat(getDTO.phucap));
            if(getDTO.tienthuong == null || getDTO.tienthuong.trim().equals(""))
            	cs.setNull(9, java.sql.Types.DECIMAL);
            else
            	cs.setFloat(9, Float.parseFloat(getDTO.tienthuong));
            if(getDTO.baohiem == null || getDTO.baohiem.trim().equals(""))
            	cs.setNull(10, java.sql.Types.DECIMAL);
            else
            	cs.setFloat(10, Float.parseFloat(getDTO.baohiem));
            if(getDTO.tong == null || getDTO.tong.trim().equals(""))
            	cs.setNull(11, java.sql.Types.DECIMAL);
            else
            	cs.setFloat(11, Float.parseFloat(getDTO.tong));
            if(getDTO.ngaylinh == null || getDTO.ngaylinh.trim().equals(""))
            	cs.setNull(12, java.sql.Types.DATE);
            else
            	cs.setString(12, getDTO.ngaylinh);
            if(getDTO.ghichu == null || getDTO.ghichu.trim().equals(""))
            	cs.setNull(13, java.sql.Types.NVARCHAR);
            else
            	cs.setString(13, getDTO.ghichu);
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
            l.add("ma");
            l.add("manv");
            l.add("luongcoban");
            l.add("phucap");
            l.add("tienthuong");
            l.add("baohiem");
            l.add("tong");
            l.add("ngaylinh");
            l.add("ghichu");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>"+getDTO.getPage()+"</page><total>"+String.valueOf(iTotalPage)+"</total><records>"+String.valueOf(count)+"</records>"+sb.toString()+"</rows>";
        }
        catch(Exception ex){
       	 	System.out.println("luong_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }

    public String CallIUP(int action, luong_PostDto postDTO){ // action = 1: Insert, 2: Update, 3: Delete
        try{
            String sqlCall = "{ CALL SP_luong_Update(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if(postDTO.ma == null || postDTO.ma.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, postDTO.ma);
            if(postDTO.manv == null || postDTO.manv.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, postDTO.manv);
            if(postDTO.luongcoban == null || postDTO.luongcoban.trim().equals(""))
            	cs.setNull(3, java.sql.Types.VARCHAR);
            else
            	cs.setString(3, postDTO.luongcoban);
            if(postDTO.phucap == null || postDTO.phucap.trim().equals(""))
            	cs.setNull(4, java.sql.Types.VARCHAR);
            else
            	cs.setString(4, postDTO.phucap);
            if(postDTO.tienthuong == null || postDTO.tienthuong.trim().equals(""))
            	cs.setNull(5, java.sql.Types.VARCHAR);
            else
            	cs.setString(5, postDTO.tienthuong);
            if(postDTO.baohiem == null || postDTO.baohiem.trim().equals(""))
            	cs.setNull(6, java.sql.Types.VARCHAR);
            else
            	cs.setString(6, postDTO.baohiem);
            if(postDTO.tong == null || postDTO.tong.trim().equals(""))
            	cs.setNull(7, java.sql.Types.VARCHAR);
            else
            	cs.setString(7, postDTO.tong);
            if(postDTO.ngaylinh == null || postDTO.ngaylinh.trim().equals(""))
            	cs.setNull(8, java.sql.Types.VARCHAR);
            else
            	cs.setString(8, postDTO.ngaylinh);
             if(postDTO.ghichu == null || postDTO.ghichu.trim().equals(""))
            	cs.setNull(9, java.sql.Types.VARCHAR);
            else
            	cs.setString(9, postDTO.ghichu);
            
            cs.setInt(10, action);
            cs.registerOutParameter(11, java.sql.Types.INTEGER);
            cs.registerOutParameter(12, java.sql.Types.VARCHAR);

            cs.execute();

            int count = cs.getInt(11);
            String error = cs.getString(12);

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
            System.out.println("luong.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }
    
    @Override
    public String insert(luong_PostDto postDTO) {
        try{
        	return CallIUP(1, postDTO);
        }
        catch(Exception ex){
            System.out.println("luong.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String delete(luong_PostDto postDTO) {
        try{
        	return CallIUP(3, postDTO);
        }
        catch(Exception ex){
           // Luu y check dieu kien FK Contraint neu can!
           System.out.println("luong.delete() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
        }
    }

    @Override
    public String update(luong_PostDto postDTO) {
        try{
        	return CallIUP(2, postDTO);
       }
       catch(Exception ex){
           System.out.println("luong.update() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
       }
    }
    
}
