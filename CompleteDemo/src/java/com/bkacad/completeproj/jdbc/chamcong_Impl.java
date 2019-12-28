/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bkacad.completeproj.jdbc;

import com.bkacad.completeproj.dao.chamcong_Dao;
import com.bkacad.completeproj.dto.chamcong_GetDto;
import com.bkacad.completeproj.dto.chamcong_PostDto;
import com.bkacad.completeproj.util.Util;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class chamcong_Impl implements chamcong_Dao {

    private Connection conn;

    public chamcong_Impl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public String getXML(chamcong_GetDto getDTO) {
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

            String sqlCall = "{ CALL SP_chamcong_Select(?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            System.out.println("sqlCall=" + sqlCall);
            if (getDTO.machamcong == null || getDTO.machamcong.trim().equals("")) {
                cs.setNull(1, java.sql.Types.INTEGER);
            } else {
                cs.setInt(1, Integer.parseInt(getDTO.machamcong));
            }
            if (getDTO.manv == null || getDTO.manv.trim().equals("")) {
                cs.setNull(2, java.sql.Types.VARCHAR);
            } else {
                cs.setString(2, getDTO.manv);
            }
            if (getDTO.ngaychamcong == null || getDTO.ngaychamcong.trim().equals("")) {
                cs.setNull(7, java.sql.Types.DATE);
            } else {
                cs.setString(7, getDTO.ngaychamcong);
            }
            if (getDTO.trangthai == null || getDTO.trangthai.trim().equals("")) {
                cs.setNull(8, java.sql.Types.NVARCHAR);
            } else {
                cs.setString(8, getDTO.trangthai);
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
            l.add("machamcong");
            l.add("manv");
            l.add("ngaychamcong");
            l.add("trangthai");
            StringBuilder sb = Util.buildDataGridXml(rs, l);

            return "<rows><page>" + getDTO.getPage() + "</page><total>" + String.valueOf(iTotalPage) + "</total><records>" + String.valueOf(count) + "</records>" + sb.toString() + "</rows>";
        } catch (Exception ex) {
            System.out.println("chamcong_Impl.getXML() error : " + ex.toString());
            ex.printStackTrace();
            return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
        }
    }

    public String CallIUP(int action, chamcong_PostDto postDTO) { // action = 1: Insert, 2: Update, 3: Delete, 4: getNgayNghi
        try {
            String sqlCall = "{ CALL SP_chamcong_Update(?, ?, ?, ?, ?, ?, ? )}";
            CallableStatement cs = conn.prepareCall(sqlCall);
            if (postDTO.machamcong == null || postDTO.machamcong.trim().equals("")) {
                cs.setNull(1, java.sql.Types.VARCHAR);
            } else {
                cs.setString(1, postDTO.machamcong);
            }
            if (postDTO.manv == null || postDTO.manv.trim().equals("")) {
                cs.setNull(2, java.sql.Types.VARCHAR);
            } else {
                cs.setString(2, postDTO.manv);
            }
            if (postDTO.ngaychamcong == null || postDTO.ngaychamcong.trim().equals("")) {
                cs.setNull(3, java.sql.Types.VARCHAR);
            } else {
                cs.setString(3, postDTO.ngaychamcong);
            }
            if (postDTO.trangthai == null || postDTO.trangthai.trim().equals("")) {
                cs.setNull(4, java.sql.Types.NVARCHAR);
            } else {
                cs.setString(4, postDTO.trangthai);
            }
            cs.setInt(5, action);
            cs.registerOutParameter(6, java.sql.Types.INTEGER);
            cs.registerOutParameter(7, java.sql.Types.VARCHAR);

            cs.execute();

            int count = cs.getInt(5);
            String error = cs.getString(6);

            if (count == 0) {
                return "success";
            } else if (count == 2627) {
                return "duplicate";
            } else {
                return error;
            }
        } catch (Exception ex) {
            System.out.println("chamcong.CallIUP() error : " + ex.toString());
            ex.printStackTrace();
            return ex.getMessage();
        }
    }

    @Override
    public String insert(chamcong_PostDto postDTO) {
        try {
            return CallIUP(1, postDTO);
        } catch (Exception ex) {
            System.out.println("chamcong.insert() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String delete(chamcong_PostDto postDTO) {
        try {
            return CallIUP(3, postDTO);
        } catch (Exception ex) {
            // Luu y check dieu kien FK Contraint neu can!
            System.out.println("chamcong.delete() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public String update(chamcong_PostDto postDTO) {
        try {
            return CallIUP(2, postDTO);
        } catch (Exception ex) {
            System.out.println("chamcong.update() error : " + ex.toString());
            ex.printStackTrace();
            return ex.toString();
        }
    }

    @Override
    public int getNgayNghi(chamcong_GetDto getDTO) {
        int a = 0;
        
        
        return a;
    }

    public int GetNghi(long manv, long thang, long nam) throws SQLException {
        int a = 0;

        String sql = "select count(trangthai) as dem from chamcong where manv = ? and month(ngaychamcong)= ? and year(ngaychamcong)= ? and trangthai= N'Nghỉ'";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, manv);
            ps.setLong(2, thang);
            ps.setLong(3, nam);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                a = rs.getInt("dem");
            }
        } catch (Exception ex) {
        } finally {
            conn.close();
        }
        return a;
    }
}
