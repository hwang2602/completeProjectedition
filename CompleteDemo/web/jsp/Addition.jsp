<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- The localization file we need, English in this case -->
<link rel="stylesheet" type="text/css" media="screen"
	href='<%=request.getContextPath()%>/css/ui.theme.css' />
<link rel="stylesheet" type="text/css" media="screen"
	href="<%=request.getContextPath()%>/css/jquery.checkboxtree.min.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="<%=request.getContextPath()%>/css/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="<%=request.getContextPath()%>/js/jqGrid460/css/ui.jqgrid.css" />

<script src="<%=request.getContextPath()%>/js/jquery-1.10.2.js"
	type="text/javascript"></script>
<script src='<%=request.getContextPath()%>/js/jquery-ui-1.10.4.custom.js'
	type="text/javascript"></script>
<script src='<%=request.getContextPath()%>/js/jquery.bgiframe.js'
	type="text/javascript"></script>
<script src='<%=request.getContextPath()%>/js/jquery.uniform.min.js'
	type="text/javascript"></script>
<script src='<%=request.getContextPath()%>/js/jquery.checkboxtree.min.js'
	type="text/javascript"></script>
<script src='<%=request.getContextPath()%>/js/jquery.maskedinput.js'
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/jqGrid460/grid.locale-en.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/jqGrid460/jquery.jqGrid.js"
	type="text/javascript"></script>

</head>
<body>
<div id="mainbody"><%@ include file = "common/header.jsp" %>
	<div id="ja-wrapper">o
		<div id="ja-wrapper-top"></div>
		<div id="ja-wrapper-inner" class="clearfix">
	
	<br><br><font style="font-size: x-large;">Demo call webservice</font>
	<form action="CalculatorServlet" method="GET">
	Number 1: <input type="text" id="a"><br>
	Number 2: <input type="text" id="b"><br>
	<input type="button" id="addition" value="Add">
	</form>
	Result: <input type="text" id="result" name="result"><br>
	<br><br>
<script>
$( "#addition" )
.button()
.click(function() {
	$.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/CalculatorServlet",
        data: {"a": $("#a").val(), "b": $("#b").val()},
        error: function(){
            $( "#dialog_error" ).dialog({
                modal: true,
                buttons: {
                    OK: function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
            blockflag = false;
        },
        success: function(msg) {
        	$("#result").val(msg)
        }
	});
});
</script>
</div>
		<%@ include file = "common/footer.jsp" %>
	</div>
</div>
</body>
</html>