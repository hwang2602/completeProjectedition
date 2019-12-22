<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html >
  <head>
    <title>Quản lý nhân sự</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/login.css">
    <script src="<%=request.getContextPath()%>/js/prefixfree.min.js"></script>
    <script type="text/javascript"
		src="<%=request.getContextPath()%>/js/jquery-1.10.2.js"></script>
	
	
	<script>
		function login() {
			var username = document.getElementById("username").value;
			if(username == "") {
				alert("Please set your username!");
				return;
				
				// Prevent submit form (have submit button) when validate not valid.
				/* document.getElementById('formLogin').onsubmit = function() {
				    return false;
				} */
			}
			var password = document.getElementById("password").value;
			if(password == "") {
				alert("Please set your password!");
				return;
			}
			
			// Submit from without use submit button
			document.getElementById('formLogin').submit();
		}
	</script>
  </head>

  <body>
    <div class="body"></div>
		<div class="grad"></div>
		<div class="header">
			<div>Site<span>Dev</span></div>
		</div>
		<br>
		<div class="login">
			<form id = "formLogin" method="post" action="<%=request.getContextPath()%>/login">
			<input type="text" placeholder="username" name="username" id="username"><br>
			<input type="password" placeholder="password" name="password" id="password" autocomplete="off"><br>
			<input type="button" value="Login" onclick="login()">
			</form>
		</div>
        
  </body>
</html>
