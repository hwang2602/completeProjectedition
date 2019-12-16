<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/jquery-1.10.2.js"
	type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">
$(function() {
	  $( "#btnTimKiem" )
      .button()
      .click(function() {
    	  var params = "";
    	  params += "manhanvien=" + $("#txtMaNhanVien").val();
    	  params += "&tennhanvien=" + $("#txtTenNhanVien").val();
    	  jQuery("#EMPLOYEEGrid").setGridParam({ url:"<%=request.getContextPath() %>/PHEPTINHCONG?" + params});
    	  jQuery("#EMPLOYEEGrid").clearGridData();
    	  jQuery("#EMPLOYEEGrid").trigger("reloadGrid");
      });
	  
	  $( "#btnThemMoi" )
      .button()
      .click(function() {
    	  clear_create();
          $( "#dialog_form_create" ).dialog({
              autoOpen: true,
              height: 300,
              width: 400,
              modal: true,
              buttons: { 
                  Cancel: { text:'Hủy bỏ',
                      click: function() {
                          $( this ).dialog( "close" );
                      }
                  },
                  Create: { text:'Lưu', 
                      click: function() {
                          blockflag = true;
                          if 	(isValidForm_create())
                          {
                              $.ajax({
                                  type: "POST",
                                  url: "<%=request.getContextPath()%>/PHEPTINHCONG",
                                  data: {"method":"<method>create</method>","EMPID": $("#EMPID_create").val(),"NAME": $("#NAME_create").val(),"SALARY": $("#SALARY_create").val()},
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
                                  success: function(msg){
                                      if (msg.trim() == 'success') {
                                          jQuery("#EMPLOYEEGrid").trigger("reloadGrid");                                      
                                      } else {
                                          document.getElementById('dialog_error').innerHTML="<font style='color:red;'>Có lỗi xảy ra " + msg + ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                          $("#dialog_error" ).dialog({modal: true,buttons:{OK: function(){$( this ).dialog( "close" );}}});blockflag = false;
                                      };
                                  }
                                  });
                                  $( this ).dialog( "close" );
                          } else {
                              $( "#dialog_validate" ).dialog({
                                  modal: true,
                                  height: 230,
                                  width: 350,
                                  buttons: {
                                      OK: function() {
                                          $( this ).dialog( "close" );
                                      }
                                  }
                              });
                          }
                      }
                  }
              }
          }
          )
      });
	  
	  $( "#btnChinhSua" )
      .button()
      .click(function() {
    	  alert('Chinh sua');
      });
	  
	  $( "#btnXoaBo" )
      .button()
      .click(function() {
    	  alert('Xoa bo');
      });
	  
	  jQuery("#EMPLOYEEGrid").jqGrid({ 
	      url:'<%=request.getContextPath() %>/PHEPTINHCONG', 
	      datatype: "xml", 
	      colNames:['STT', 'Mã Nhân viên', 'Tên nhân viên', 'vị trí','ngày nghỉ hưu'], 
	      colModel:[
	          {name:'STT',index:'STT', width:80, align:"center"},
	          {name:'EMP_ID',index:'EMP_ID', width:100},
	          {name:'NAME',index:'NAME', width:200},
	          {name:'POSITION',index:'POSITION', width:100, align:"right"},
	          {name:'HIREDATE',index:'HIREDATE', width:100, align:"right"}
	          
	      ],
	      rowNum:15,  rowList:[15,30,60,80,150], pager: '#Pager1', 
	      scrollrows: true,
	      autowidth: false,
	      height: 400,
	      width:800,
	      shrinkToFit:false,
	      caption: " Danh sách EMPLOYEE",
	      sortname: 'EMP_ID', viewrecords: true, sortorder: "desc"

	  }).navGrid('#Pager1',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});

});
</script>
<script type="text/javascript">
   function clear_create()
   {
	   $("#EMPID_create").val("");
	   $("#NAME_create").val("");
	   $("#SALARY_create").val("");
   }
   function isValidForm_create() {
		 var empid = trim($("#EMPID_create").val());
		 var name = trim($("#NAME_create").val()); 
		 var salary = trim($("#SALARY_create").val());
		 if (!((empid == "") || (name == "") || (salary == ""))) { 
			 return true; 
		} 
	} 
   function trim( value ) { 
		 var reL = /\s*((\S+\s*)*)/; 
		 var reR = /((\s*\S+)*)\s*/; 
		 value = value.replace(reL, "$1"); 
		 return value.replace(reR, "$1"); 
	} 
</script>

<div id="mainbody"><%@ include file = "common/header.jsp" %>
	<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<div id="ja-wrapper-inner" class="clearfix">		
			<font size="5">Phép tính cộng</font>
			<br /> <br />
			
     Mã nhân viên: <input type="text" id="txtMaNhanVien" name="txtMaNhanVien"/> <br/>
     Tên nhân viên: <input type="text" id="txtTenNhanVien" name="txtTenNhanVien"/> <br/>
     <button type="button" id="btnTimKiem" name="btnTimKiem">Tìm kiếm</button>
     <button type="button" id="btnThemMoi" name="btnThemMoi">Thêm mới</button>
     <button type="button" id="btnChinhSua" name="btnChinhSua">Chỉnh sửa</button>
     <button type="button" id="btnXoaBo" name="btnXoaBo">Xóa bỏ</button>
     <br />
			<table id="EMPLOYEEGrid"></table>
			<div id="Pager1"></div>
			<br />
     </div>
		<%@ include file = "common/footer.jsp" %>
	</div>
</div>

<div id="dialog_form_create" style="display: none;" title="Thêm mới" > 
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="EMPID_create">Mã nhân viên<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="EMPID_create" name="CODE_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="NAME_create">Tên nhân viên<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="NAME_create" name="NAME_create" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="SALARY_create">lương<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="SALARY_create" name="SALARY_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<div id="dialog_error" style="display: none" title="Báo lỗi">
Có lỗi xảy ra. Hãy kiểm tra lại!
</div>
</body>
</html>