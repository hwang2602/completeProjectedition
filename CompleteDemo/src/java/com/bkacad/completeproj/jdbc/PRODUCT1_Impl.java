
package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.dao.SINHVIEN_Dao;
import com.bkacad.completeproj.dao.PRODUCT1_Dao;
import com.bkacad.completeproj.dto.PRODUCT1_GetDto;
import com.bkacad.completeproj.dto.PRODUCT1_PostDto;
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
public class PRODUCT1_Impl implements PRODUCT1_Dao{
    private Connection conn;
    public PRODUCT1_Impl(Connection conn) {
		this.conn = conn;
	}
    
    @Override
    public String getXML(PRODUCT1_GetDto getDTO) {
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


            String sqlCall = "{ CALL SP_PRODUCT_Update(?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if(getDTO.CODE == null || getDTO.CODE.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, getDTO.CODE);
            if(getDTO.NAME == null || getDTO.NAME.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, getDTO.NAME);
            if(getDTO.PRICE == null || getDTO.PRICE.trim().equals(""))
            	cs.setNull(7, java.sql.Types.FLOAT);
            else
            	cs.setFloat(7, Float.parseFloat(getDTO.PRICE));
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
            l.add("CODE");
            l.add("NAME");
            l.add("PRICE");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>"+getDTO.getPage()+"</page><total>"+String.valueOf(iTotalPage)+"</total><records>"+String.valueOf(count)+"</records>"+sb.toString()+"</rows>";
        }
        catch(Exception ex){
       	 	System.out.println("PRODUCT1_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    
    }

    @Override
    public String insert(PRODUCT1_PostDto postDTO) {
        try{
        	return CallIUP(1, postDTO);
        }
        catch(Exception ex){
            System.out.println("PRODUCT1.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }
     public String CallIUP(int action, PRODUCT1_PostDto postDTO){ // action = 1: Insert, 2: Update, 3: Delete
        try{
            String sqlCall = "{ CALL SP_PRODUCT_Update(?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if(postDTO.CODE == null || postDTO.CODE.trim().equals(""))
            	cs.setNull(1, java.sql.Types.VARCHAR);
            else
            	cs.setString(1, postDTO.CODE);
            if(postDTO.NAME == null || postDTO.NAME.trim().equals(""))
            	cs.setNull(2, java.sql.Types.VARCHAR);
            else
            	cs.setString(2, postDTO.NAME);
            if(postDTO.PRICE == null || postDTO.PRICE.trim().equals(""))
            	cs.setNull(3, java.sql.Types.VARCHAR);
            else
            	cs.setString(3, postDTO.PRICE);
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
            System.out.println("PRODUCT1.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }


    @Override
    public String delete(PRODUCT1_PostDto postDTO) {
        try{
        	return CallIUP(3, postDTO);
        }
        catch(Exception ex){
           // Luu y check dieu kien FK Contraint neu can!
           System.out.println("PRODUCT1.delete() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
        }
    }

    @Override
    public String update(PRODUCT1_PostDto postDTO) {
       try{
        	return CallIUP(2, postDTO);
       }
       catch(Exception ex){
           System.out.println("PRODUCT1.update() error : " + ex.toString());
            ex.printStackTrace();
           return ex.toString();
       }
    }
    
}
