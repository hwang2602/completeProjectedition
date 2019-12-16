package com.bkacad.completeproj.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.bkacad.completeproj.dto.UserDTO;
import com.bkacad.completeproj.util.Util;

public class LoginImpl {
	public UserDTO getUserInfo(String username, String password, HttpServletRequest request) {
		Connection conn = null;
		PreparedStatement pstm;
		ResultSet rs = null;
		String strSQL = "select * from tblUser a inner join tblGroup b " + "on a.GroupId = b.GroupId "
				+ "where username=? and password = ?";
		UserDTO currUser = null;
		try {
			conn = Util.getStoredConnection(request);
			pstm = conn.prepareStatement(strSQL);
			pstm.setString(1, username);
			pstm.setString(2, password);
			rs = pstm.executeQuery();
			while (rs.next()) {
				currUser = new UserDTO();
				currUser.setUserName(rs.getString("UserName"));
				currUser.setFullName(rs.getString("FullName"));
				currUser.setGroupId(rs.getString("GroupId"));
				currUser.setRoleList(rs.getString("RoleList"));
			}

		} catch (SQLException sqlex) {
			System.out.println("getUserInfo() error DB: " + sqlex.toString());
			DBUtil.closeQuietly(conn);
		} catch (Exception ex) {
			System.out.println("getUserInfo() error: " + ex.toString());
			DBUtil.closeQuietly(conn);
		}
		return currUser;
	}
}
