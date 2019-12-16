/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.dao.phongban_Dao;
import com.bkacad.completeproj.dto.phongban_GetDto;
import com.bkacad.completeproj.dto.phongban_PostDto;
import com.bkacad.completeproj.util.Util;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;
import static org.hibernate.validator.internal.util.privilegedactions.ConstructorInstance.action;

/**
 *
 * @author Admin
 */
public class phongban_Impl implements phongban_Dao {

    private Connection conn;

    public phongban_Impl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public String getXML(phongban_GetDto getDTO) {
        try {
            String orderby = getDTO.getSidx();
            String sord = getDTO.getSord();
            int Start = 1, End = 50;
            if (!getDTO.getStart().equals("")) {
                try {
                    Start = Integer.parseInt(getDTO.getStart());
                } catch (Exception e) {
                }
            }
            if (!getDTO.getEnd().equals("")) {
                try {
                    End = Integer.parseInt(getDTO.getEnd());
                } catch (Exception e) {
                }
            }

            String sqlCall = "{ CALL SP_phongban1_Select(?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if (getDTO.mapb == null || getDTO.mapb.trim().equals("")) {
                cs.setNull(1, java.sql.Types.INTEGER);
            } else {
                cs.setInt(1,  Integer.parseInt(getDTO.mapb));
            }
            if (getDTO.tenpb == null || getDTO.tenpb.trim().equals("")) {
                cs.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                cs.setString(2, getDTO.tenpb);
            }
            if (getDTO.diachi == null || getDTO.diachi.trim().equals("")) {
                cs.setNull(7, java.sql.Types.NVARCHAR);
            } else {
                cs.setString(7, getDTO.diachi);
            }
            if (getDTO.sdt == null || getDTO.sdt.trim().equals("")) {
                cs.setNull(8, java.sql.Types.VARCHAR);
            } else {
                cs.setString(8, getDTO.sdt);
            }
            cs.setInt(3, 1);
            cs.setInt(4, 999999);
            cs.setString(5, orderby);
            cs.setString(6, sord);

            ResultSet rs = cs.executeQuery();

            long ilimit = Integer.parseInt(getDTO.getLimit());
            long count = 0;
            while (rs.next()) {
                count++;
            }
            long iTotalPage = count / ilimit;
            long acCount = iTotalPage * ilimit;
            if (acCount < count) {
                iTotalPage++;
            }

            cs.setInt(3, Start);
            cs.setInt(4, End);
            rs = cs.executeQuery();

            List<String> l = new Vector<String>();
            l.add("STT");
            l.add("mapb");
            l.add("tenpb");
            l.add("diachi");
            l.add("sdt");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>" + getDTO.getPage() + "</page><total>" + String.valueOf(iTotalPage) + "</total><records>" + String.valueOf(count) + "</records>" + sb.toString() + "</rows>";
        } catch (Exception ex) {
            System.out.println("phongban_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }

    public String CallIUP(int action, phongban_PostDto postDTO) { // action = 1: Insert, 2: Update, 3: Delete
        try {
            String sqlCall = "{ CALL SP_phongban_Update(?, ?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if (postDTO.mapb == null || postDTO.mapb.trim().equals("")) {
                cs.setNull(1, java.sql.Types.INTEGER);
            } else {
                cs.setString(1, postDTO.mapb);
            }
            if (postDTO.tenpb == null || postDTO.tenpb.trim().equals("")) {
                cs.setNull(2, java.sql.Types.NVARCHAR);
            } else {
                cs.setString(2, postDTO.tenpb);
            }
            if (postDTO.diachi == null || postDTO.diachi.trim().equals("")) {
                cs.setNull(4, java.sql.Types.NVARCHAR);
            } else {
                cs.setString(4, postDTO.diachi);
            }
            if (postDTO.sdt == null || postDTO.sdt.trim().equals("")) {
                cs.setNull(3, java.sql.Types.BIGINT);
            } else {
                cs.setString(3, postDTO.sdt);
            }
            cs.setInt(5, action);
            cs.registerOutParameter(6, java.sql.Types.INTEGER);
            cs.registerOutParameter(7, java.sql.Types.VARCHAR);

            cs.execute();

            int count = cs.getInt(6);
            String error = cs.getString(7);

            if (count == 0) {
                return "success";
            } else if (count == 2627) {
                return "duplicate";
            } else {
                return error;
            }
        } catch (Exception ex) {
            System.out.println("phongban.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }

    @Override
    public String insert(phongban_PostDto postDTO) {
        try {
            return CallIUP(1, postDTO);
        } catch (Exception ex) {
            System.out.println("phongban.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String delete(phongban_PostDto postDTO) {
        try {
            return CallIUP(3, postDTO);
        } catch (Exception ex) {
            // Luu y check dieu kien FK Contraint neu can!
            System.out.println("phongban.delete() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String update(phongban_PostDto postDTO) {
        try {
            return CallIUP(2, postDTO);
        } catch (Exception ex) {
            System.out.println("phongban.update() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

}
