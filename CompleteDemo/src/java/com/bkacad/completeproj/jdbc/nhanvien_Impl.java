/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.dao.nhanvien_Dao;
import com.bkacad.completeproj.dto.nhanvien_GetDto;
import com.bkacad.completeproj.dto.nhanvien_PostDto;
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
public class nhanvien_Impl implements nhanvien_Dao{
    private Connection conn;
	public nhanvien_Impl(Connection conn) {
		this.conn = conn;
	}
    @Override
    public String getXML(nhanvien_GetDto getDTO) {
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


            String sqlCall = "{ CALL SP_nhanvien_Select(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if(getDTO.manv == null || getDTO.manv.trim().equals(""))
            	cs.setNull(1, java.sql.Types.INTEGER);
            else
            	cs.setString(1, getDTO.manv);
            if(getDTO.hoten == null || getDTO.hoten.trim().equals(""))
            	cs.setNull(2, java.sql.Types.NVARCHAR);
            else
            	cs.setString(2, getDTO.hoten);
            if(getDTO.ngaysinh == null || getDTO.ngaysinh.trim().equals(""))
            	cs.setNull(7, java.sql.Types.DATE);
            else
            	cs.setString(7, getDTO.ngaysinh);
            if(getDTO.gioitinh == null || getDTO.gioitinh.trim().equals(""))
            	cs.setNull(8, java.sql.Types.NVARCHAR);
            else
            	cs.setString(8, getDTO.gioitinh);
            if(getDTO.diachi == null || getDTO.diachi.trim().equals(""))
            	cs.setNull(9, java.sql.Types.NVARCHAR);
            else
            	cs.setString(9, getDTO.diachi);
            if(getDTO.sdt == null || getDTO.sdt.trim().equals(""))
            	cs.setNull(10, java.sql.Types.BIGINT);
            else
            	cs.setString(10, getDTO.sdt);
            if(getDTO.mapb == null || getDTO.mapb.trim().equals(""))
            	cs.setNull(11, java.sql.Types.INTEGER);
            else
            	cs.setString(11, getDTO.mapb);
            if(getDTO.macv == null || getDTO.macv.trim().equals(""))
            	cs.setNull(12, java.sql.Types.INTEGER);
            else
            	cs.setString(12, getDTO.macv);
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
            l.add("manv");
            l.add("hoten");
            l.add("ngaysinh");
            l.add("gioitinh");
            l.add("diachi");
            l.add("sdt");
            l.add("mapb");
            l.add("macv");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>"+getDTO.getPage()+"</page><total>"+String.valueOf(iTotalPage)+"</total><records>"+String.valueOf(count)+"</records>"+sb.toString()+"</rows>";
        }
        catch(Exception ex){
       	 	System.out.println("nhanvien_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }
    
    public String CallIUP(int action, nhanvien_PostDto postDTO){ // action = 1: Insert, 2: Update, 3: Delete
        try{
            String sqlCall = "{ CALL SP_nhanvien_Update(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if(postDTO.manv == null || postDTO.manv.trim().equals(""))
            	cs.setNull(1, java.sql.Types.INTEGER);
            else
            	cs.setString(1, postDTO.manv);
            if(postDTO.hoten == null || postDTO.hoten.trim().equals(""))
            	cs.setNull(2, java.sql.Types.NVARCHAR);
            else
            	cs.setString(2, postDTO.hoten);
            if(postDTO.ngaysinh == null || postDTO.ngaysinh.trim().equals(""))
            	cs.setNull(3, java.sql.Types.DATE);
            else
            	cs.setString(3, postDTO.ngaysinh);
            if(postDTO.gioitinh == null || postDTO.gioitinh.trim().equals(""))
            	cs.setNull(4, java.sql.Types.NVARCHAR);
            else
            	cs.setString(4, postDTO.gioitinh);
            if(postDTO.diachi == null || postDTO.diachi.trim().equals(""))
            	cs.setNull(5, java.sql.Types.NVARCHAR);
            else
            	cs.setString(5, postDTO.diachi);
            if(postDTO.sdt == null || postDTO.sdt.trim().equals(""))
            	cs.setNull(6, java.sql.Types.BIGINT);
            else
            	cs.setString(6, postDTO.sdt);
            if(postDTO.mapb == null || postDTO.mapb.trim().equals(""))
            	cs.setNull(7, java.sql.Types.INTEGER);
            else
            	cs.setString(7, postDTO.mapb);
            if(postDTO.macv == null || postDTO.macv.trim().equals(""))
            	cs.setNull(8, java.sql.Types.INTEGER);
            else
            	cs.setString(8, postDTO.macv);
            cs.setInt(9, action);
            cs.registerOutParameter(10, java.sql.Types.INTEGER);
            cs.registerOutParameter(11, java.sql.Types.VARCHAR);

            cs.execute();

            int count = cs.getInt(10);
            String error = cs.getString(11);

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
            System.out.println("nhanvien.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }
    @Override
    public String insert(nhanvien_PostDto postDTO) {
         try{
        	return CallIUP(1, postDTO);
        }
        catch(Exception ex){
            System.out.println("nhanvien.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String delete(nhanvien_PostDto postDTO) {
        try{
        	return CallIUP(3, postDTO);
        }
        catch(Exception ex){
           // Luu y check dieu kien FK Contraint neu can!
           System.out.println("nhanvien.delete() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
        }
    }

    @Override
    public String update(nhanvien_PostDto postDTO) {
        try{
        	return CallIUP(2, postDTO);
       }
       catch(Exception ex){
           System.out.println("nhanvien.update() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
       }
    }
    
}
