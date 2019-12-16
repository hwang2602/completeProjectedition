package com.bkacad.completeproj.jdbc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import org.json.JSONArray;
import org.json.JSONObject;

import com.bkacad.completeproj.dao.SINHVIEN_Dao;
import com.bkacad.completeproj.dto.SINHVIEN_GetDto;
import com.bkacad.completeproj.dto.SINHVIEN_PostDto;
import com.bkacad.completeproj.util.Util;

public class SINHVIEN_Impl implements SINHVIEN_Dao {
	private Connection conn;

	public SINHVIEN_Impl(Connection conn) {
		this.conn = conn;
	}

	public String getXML(SINHVIEN_GetDto getDTO) {
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

			String sqlCall = "{ CALL SP_SINHVIEN_Select(?, ?, ?, ?, ?, ?, ? )}";
			CallableStatement cs = conn.prepareCall(sqlCall);
			System.out.println("sqlCall=" + sqlCall);
			if (getDTO.MSV == null || getDTO.MSV.trim().equals(""))
				cs.setNull(1, java.sql.Types.VARCHAR);
			else
				cs.setString(1, getDTO.MSV);
			if (getDTO.Hoten == null || getDTO.Hoten.trim().equals(""))
				cs.setNull(2, java.sql.Types.VARCHAR);
			else
				cs.setString(2, getDTO.Hoten);
			if (getDTO.Que == null || getDTO.Que.trim().equals(""))
				cs.setNull(3, java.sql.Types.VARCHAR);
			else
				cs.setString(3, getDTO.Que);
			cs.setInt(4, 1);
			cs.setInt(5, 999999);
			cs.setString(6, orderby);
			cs.setString(7, sord);

			ResultSet rs = cs.executeQuery();

			long ilimit = Integer.parseInt(getDTO.getLimit());
			long count = 0;
			while (rs.next()) {
				count++;
			}
			long iTotalPage = count / ilimit;
			long acCount = iTotalPage * ilimit;
			if (acCount < count)
				iTotalPage++;

			cs.setInt(4, Start);
			cs.setInt(5, End);
			rs = cs.executeQuery();

			List<String> l = new Vector<String>();
			l.add("STT");
			l.add("MSV");
			l.add("Hoten");
			l.add("GT");
			l.add("GT1");
			l.add("NS");
			l.add("Que");
			l.add("ten_tinh");
			l.add("Lop");
			StringBuilder sb = Util.buildDataGridXml(rs, l);

			return "<rows><page>" + getDTO.getPage() + "</page><total>" + String.valueOf(iTotalPage)
					+ "</total><records>" + String.valueOf(count) + "</records>" + sb.toString() + "</rows>";
		} catch (Exception ex) {
			System.out.println("SINHVIEN_Impl.getXML() error : " + ex.toString());
			ex.printStackTrace();
			return "<rows><page>0</page><total>0</total><records>0</records>0</rows>";
		}
	}

	public String getJSON(SINHVIEN_GetDto getDTO) {
		JSONObject obj = new JSONObject();
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

			String sqlCall = "{ CALL SP_SINHVIEN_Select(?, ?, ?, ?, ?, ?, ? )}";
			CallableStatement cs = conn.prepareCall(sqlCall);
			System.out.println("sqlCall=" + sqlCall);
			if (getDTO.MSV == null || getDTO.MSV.trim().equals(""))
				cs.setNull(1, java.sql.Types.VARCHAR);
			else
				cs.setString(1, getDTO.MSV);
			if (getDTO.Hoten == null || getDTO.Hoten.trim().equals(""))
				cs.setNull(2, java.sql.Types.VARCHAR);
			else
				cs.setString(2, getDTO.Hoten);
			if (getDTO.Que == null || getDTO.Que.trim().equals(""))
				cs.setNull(3, java.sql.Types.VARCHAR);
			else
				cs.setString(3, getDTO.Que);
			cs.setInt(4, 1);
			cs.setInt(5, 999999);
			cs.setString(6, orderby);
			cs.setString(7, sord);

			ResultSet rs = cs.executeQuery();

			long ilimit = Integer.parseInt(getDTO.getLimit());
			long count = 0;
			while (rs.next()) {
				count++;
			}
			long iTotalPage = count / ilimit;
			long acCount = iTotalPage * ilimit;
			if (acCount < count)
				iTotalPage++;

			cs.setInt(4, Start);
			cs.setInt(5, End);
			rs = cs.executeQuery();

			List<String> l = new Vector<String>();
			l.add("STT");
			l.add("MSV");
			l.add("Hoten");
			l.add("GT");
			l.add("GT1");
			l.add("NS");
			l.add("Que");
			l.add("ten_tinh");
			l.add("Lop");
			JSONArray array = Util.buildDataGridJson(rs, l);

			/*
			 * obj.put("page", getDTO.getPage()); obj.put("total",
			 * String.valueOf(iTotalPage)); obj.put("records",
			 * String.valueOf(count)); obj.put("rows", array);
			 */
			return String.format("{\"total\":%1$s, \"records\":%2$s, \"rows\":%3$s}", iTotalPage, count, array);
		} catch (Exception ex) {
			System.out.println("SINHVIEN_Impl.getJSON() error : " + ex.toString());
			return "{\"total\":0, \"records\":0, \"rows\":null}";
		}
	}

	public String CallIUP(int action, SINHVIEN_PostDto postDTO) { // action = 1: Insert,
																	// 2: Update,
																	// 3: Delete
		try {
			String sqlCall = "{ CALL SP_SINHVIEN_Update(?, ?, ?, ?, ?, ?, ?, ?, ? )}";
			CallableStatement cs = conn.prepareCall(sqlCall);
			if (postDTO.MSV == null || postDTO.MSV.trim().equals(""))
				cs.setNull(1, java.sql.Types.VARCHAR);
			else
				cs.setString(1, postDTO.MSV);
			if (postDTO.Hoten == null || postDTO.Hoten.trim().equals(""))
				cs.setNull(2, java.sql.Types.VARCHAR);
			else
				cs.setString(2, postDTO.Hoten);
			if (postDTO.GT == null || postDTO.GT.trim().equals(""))
				cs.setNull(3, java.sql.Types.VARCHAR);
			else
				cs.setString(3, postDTO.GT);
			if (postDTO.NS == null || postDTO.NS.trim().equals(""))
				cs.setNull(4, java.sql.Types.VARCHAR);
			else
				cs.setString(4, postDTO.NS);
			if (postDTO.Que == null || postDTO.Que.trim().equals(""))
				cs.setNull(5, java.sql.Types.VARCHAR);
			else
				cs.setString(5, postDTO.Que);
			if (postDTO.Lop == null || postDTO.Lop.trim().equals(""))
				cs.setNull(6, java.sql.Types.VARCHAR);
			else
				cs.setString(6, postDTO.Lop);
			cs.setInt(7, action);
			cs.registerOutParameter(8, java.sql.Types.INTEGER);
			cs.registerOutParameter(9, java.sql.Types.VARCHAR);

			cs.execute();

			int count = cs.getInt(8);
			String error = cs.getString(9);

			if (count == 0) {
				return "success";
			} else if (count == 2627) {
				return "duplicate";
			} else
				return error;
		} catch (Exception ex) {
			System.out.println("SINHVIEN.CallIUP() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; //ex.toString();
		}
	}

	public String insert(SINHVIEN_PostDto postDTO) {
		try {
			return CallIUP(1, postDTO);
		} catch (Exception ex) {
			System.out.println("SINHVIEN.insert() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; //ex.toString();
		}
	}

	public String update(SINHVIEN_PostDto postDTO) {
		try {
			return CallIUP(2, postDTO);
		} catch (Exception ex) {
			System.out.println("SINHVIEN.update() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; //ex.toString();
		}
	}

	public String delete(SINHVIEN_PostDto postDTO) {
		try {
			return CallIUP(3, postDTO);
		} catch (Exception ex) {
			// Luu y check dieu kien FK Contraint neu can!
			System.out.println("SINHVIEN.delete() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; //ex.toString();
		}
	}

	@Override
	public String getCbbQue() {
		try {
			StringBuilder xmlReturn = new StringBuilder();
			xmlReturn.append("<xml>");
			// Ket noi CSDL va lay thong tin tu bang
			String strComm = "select ma_tinh, ten_tinh from tbltinh order by ten_tinh ";
			PreparedStatement pstm = conn.prepareStatement(strComm);

			ResultSet rs = pstm.executeQuery();

			while (rs != null && rs.next()) {
				xmlReturn.append("<option>");
				xmlReturn.append("<value>");
				xmlReturn.append(rs.getString(1));
				xmlReturn.append("</value>");
				xmlReturn.append("<text>");
				xmlReturn.append(Util.toHTML(rs.getString(2)) + " - " + rs.getString(1));
				xmlReturn.append("</text>");
				xmlReturn.append("</option>");
			}
			xmlReturn.append("</xml>");

			return xmlReturn.toString();
		} catch (Exception ex) {
			System.out.println("SINHVIEN.getCbbQue() error : " + ex.toString());
			return "error"; // ex.getMessage();
		}
	}

	@Override
	public String getCbbQue1() {
		JSONArray array = new JSONArray();
		try {
			// Ket noi CSDL va lay thong tin tu bang
			String strComm = "select ma_tinh, ten_tinh from tbltinh order by ten_tinh ";
			PreparedStatement pstm = conn.prepareStatement(strComm);

			ResultSet rs = pstm.executeQuery();
			array = Util.buildSelectJson(rs);
		} catch (Exception ex) {
			System.out.println("SINHVIEN.getCbbQue1() error : " + ex.toString());
		}
		return array.toString();
	}
}
