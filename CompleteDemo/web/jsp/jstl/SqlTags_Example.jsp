<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<html>
<head>
<title>JINSERT Operation</title>
</head>
<body>
 
<sql:setDataSource var="snapshot" driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
     url="jdbc:sqlserver://MRGIAP-PC\\SQL2012;databaseName=Jsp1501;"
     user="bkacad"  password="bkacad"/>

<sql:query dataSource="${snapshot}" var="result">
SELECT name name1, code code2, price price3 from Product1;
</sql:query>
 
<table border="1" width="100%">
<tr>
   <th>Code</th>
   <th>Name</th>
   <th>Price</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td><c:out value="${row.code2}"/></td>
   <td><c:out value="${row.name1}"/></td>
   <td><c:out value="${row.price3}"/></td>
</tr>
</c:forEach>
</table>
 
</body>
</html>