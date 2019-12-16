package com.bkacad.completeproj.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.bkacad.completeproj.jdbc.DBUtil;

@WebServlet("/SinhVienServlet")
public class SinhVienServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SinhVienServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ResultSet rs = getListStudent();
		response.setContentType("text/html; charset=UTF-8");
		// ServletOutputStream outStream = response.getOutputStream();
		PrintWriter outStream = response.getWriter();

		outStream.println("<html>");
		outStream.println("<body>");
		//outStream.println("<%@ include file = \"header.jsp\" %>");
		outStream.println("<table border=1 CELLSPACING = 0.5>");
		outStream.println("<thead>List all Students</thead>");
		try {
			int i = 1;
			while (rs.next()) {
				outStream.println("<tr>");
				outStream.println("<td>" + i + "</td>");
				outStream.println("<td>" + rs.getString("msv") + "</td>");
				outStream.println("<td>" + rs.getString("hoten") + "</td>");
				outStream.println("<td>" + rs.getString("gt") + "</td>");
				outStream.println("<td>" + rs.getString("ns") + "</td>");
				outStream.println("<td>" + rs.getString("que") + "</td>");
				outStream.println("<td>" + rs.getString("lop") + "</td>");
				outStream.println("</tr>");
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		outStream.println("</table>");
		//outStream.println("<%@ include file = \"footer.jsp\" %>");
		outStream.println("</body>");
		outStream.println("</html>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private java.sql.ResultSet getListStudent() {
		Connection conn = null;
		PreparedStatement pstm;
		ResultSet rs = null;
		String strSQL = "select msv, hoten, gt, CONVERT(VARCHAR, ns, 101) ns, que, lop from tblSV order by msv";
		try {
			conn = DBUtil.getSqlConn();
			pstm = conn.prepareStatement(strSQL);
			// pstm.setString(1, "svjp01");
			rs = pstm.executeQuery();
		} catch (SQLException sqlex) {
			System.out.println("getListStudent() error DB: " + sqlex.toString());
		} catch (Exception ex) {
			System.out.println("getListStudent() error: " + ex.toString());
		}

		return rs;
	}
}
