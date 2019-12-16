package com.bkacad.completeproj.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRegistration;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.bkacad.completeproj.dto.UserDTO;

public class Util {
	public static final String ATT_NAME_CONNECTION = "ATTRIBUTE_FOR_CONNECTION";
	private static final String ATT_NAME_USER_NAME = "ATTRIBUTE_FOR_STORE_USER_NAME_IN_COOKIE";

	// Lưu trữ Connection vào một thuộc tính của request.
	// Thông tin lưu trữ chỉ tồn tại trong thời gian yêu cầu (request)
	// cho tới khi dữ liệu được trả về trình duyệt người dùng.
	public static void storeConnection(ServletRequest request, Connection conn) {
		request.setAttribute(ATT_NAME_CONNECTION, conn);
	}

	// Lấy đối tượng Connection đã được lưu trữ trong 1 thuộc tính của request.
	public static Connection getStoredConnection(ServletRequest request) {
		Connection conn = (Connection) request.getAttribute(ATT_NAME_CONNECTION);
		return conn;
	}

	// Lưu trữ thông tin người dùng đã login vào Session
	public static void storeLoginedUser(HttpSession session, UserDTO loginedUser) {
		// Trên JSP có thể truy cập ${loginedUser}
		session.setAttribute("loginedUser", loginedUser);
	}

	// Lấy thông tin người dùng đã login trong session.
	public static UserDTO getLoginedUser(HttpSession session) {
		UserDTO loginedUser = (UserDTO) session.getAttribute("loginedUser");
		return loginedUser;
	}

	// Kiểm tra xem request hiện tại là 1 Servlet?
	public static boolean isValidPathServlet(HttpServletRequest request) {
		// => /spath
		String servletPath = request.getServletPath();
		// => /abc/mnp
		String pathInfo = request.getPathInfo();

		String urlPattern = servletPath;

		if (pathInfo != null) {
			// => /spath/*
			urlPattern = servletPath + "/*";
		}

		// Key: servletName.
		// Value: ServletRegistration
		Map<String, ? extends ServletRegistration> servletRegistrations = request.getServletContext()
				.getServletRegistrations();

		// Tập hợp tất cả các Servlet trong WebApp của bạn.
		Collection<? extends ServletRegistration> values = servletRegistrations.values();
		for (ServletRegistration sr : values) {
			Collection<String> mappings = sr.getMappings();
			if (mappings.contains(urlPattern)) {
				return true;
			}
		}
		return true;
	}

	public static String getTag(String source, String begin, String end) {
		try {
			String s[] = source.split(begin);
			s = s[1].split(end);
			if (s[0].equals(""))
				s[0] = " ";
			return s[0].trim();
		} catch (Exception ex) {
			// The XML khong ton tai
			return "";
		}
	}

	public static StringBuilder buildDataGridXml(ResultSet rs, List<String> l) {
		try {
			StringBuilder sb = new StringBuilder();
			while (rs.next()) {
				for (int i = 0; i < l.size(); i++) {
					if (i == 0) {
						sb.append("<row><cell>");
					} else {
						sb.append("</cell><cell>");
					}

					sb.append(Util.toHTML(Util.checkNull(rs.getString(l.get(i)))).trim());
					if (i == l.size() - 1) {
						sb.append("</cell></row>");
					}
				}
			}
			try {
				rs.close();
			} catch (Exception ex) {
			}
			return sb;
		} catch (Exception e) {
			try {
				rs.close();
			} catch (Exception ex) {
			}
			return null;
		}
	}

	public static JSONArray buildDataGridJson(ResultSet rs, List<String> l) {
		JSONArray array = new JSONArray();
		try {
			while (rs.next()) {
				JSONArray row = new JSONArray();
				for (int i = 0; i < l.size(); i++) {
					row.put(Util.checkNull(rs.getString(l.get(i))));
				}
				array.put(row);
			}
		} catch (Exception e) {
		} finally {
			try {
				rs.close();
			} catch (Exception ex) {
			}
		}
		return array;
	}
	
	public static JSONArray buildSelectJson(ResultSet rs) {
		JSONArray array = new JSONArray();
		try {
			while (rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("Value", rs.getString(1));
				obj.put("Text", rs.getString(2) + " - " + rs.getString(1));
				array.put(obj);
			}
		} catch (Exception e) {
		} finally {
			try {
				rs.close();
			} catch (Exception ex) {
			}
		}
		return array;
	}

	public static String checkNull(String value) {
		return (value == null ? "" : value.trim());
	}

	public static String toHTML(String unicode) {
		if (unicode == null)
			return " ";
		if (unicode.equals(""))
			return " ";
		String output = "";
		char[] charArray = unicode.toCharArray();

		for (int i = 0; i < charArray.length; ++i) {
			char a = charArray[i];
			if ((int) a > 128) {
				output += "&#" + (int) a + ";";
			} else {
				output += a;
			}
			// Special Characters
			if (a == '&')
				output = output.substring(0, output.length() - 1) + "&amp;";
			if (a == '<')
				output = output.substring(0, output.length() - 1) + "&lt;";
			if (a == '>')
				output = output.substring(0, output.length() - 1) + "&gt;";
			if (a == '"')
				output = output.substring(0, output.length() - 1) + "&quot;";
			if (a == '\'')
				output = output.substring(0, output.length() - 1) + "&#39;";
		}
		return output;
	}
}
