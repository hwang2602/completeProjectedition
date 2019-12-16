<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%-- <%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

</style>
</head>

<body>
<%@ include file = "common/header.jsp" %>

<div style="min-height: 600px; padding: 25px; background-color: #FFFFFF">
<font size="6">Request Information</font><br>
<font size="4">
	JSP Request Method: <%=request.getMethod()%><br>
	Static text: ${request.getMethod()}<br>
	Request URI: <%=request.getRequestURI()%><br> 
	Request Protocol: <%=request.getProtocol()%><br> 
	Servlet path: <%=request.getServletPath()%><br>
	Path info: <%=request.getPathInfo()%><br>
	Path translated: <%=request.getPathTranslated()%><br>
</font>
</div>
<%@ include file = "common/footer.jsp" %>
</body>
</html>