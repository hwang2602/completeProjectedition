<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<title>bkacad.edu.vn</title>
<link href="${pageContext.request.contextPath}/images/favicon.ico" rel="shortcut icon" />
</head>

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

<div id="mainbody"><%@ include file = "../common/header.jsp" %>
	<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<div id="ja-wrapper-inner" class="clearfix">		
			<font size="5">QUẢN LÝ Nhân Viên</font>
			<br /> <br />
			
			<div id="dialog_search" title="Tìm kiếm" >
				<table width="70%">
				    <tr>
				    <td align=right><label for="EMPID_search">Mã Nhân viên</label></td>
				    <td align=left><input type="text" id="EMPID_search" name="EMPID_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    <td align=right><label for="NAME_search">Tên Nhân Viên</label></td>
				    <td align=left><input type="text" id="NAME_search" name="NAME_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    </tr>
				    <tr> 
				    <td align=right><label for="HIREDATE_search">Ngày nghỉ hưu</label></td>
				    <td align=left><input type="text" id="HIREDATE_search" name="PRICE_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    </tr>
				    <tr>
				        <td></td>
				        <td align=left><button id="search" >Tìm kiếm</button></td>
				    </tr>
				</table>
			</div>
			<br/>
			<button id="create" name="button" style="float: left;">Thêm mới</button>
			<button id="edit" name="button" style="float: left;">Sửa</button>
			<button id="delete" name="button" style="float: left;">Xóa</button>
			<br /><br />
			<table id="EMPLOYEEGrid"></table>
			<div id="Pager1"></div>
			<br />
		</div>
		<%@ include file = "../common/footer.jsp" %>
	</div>
</div>


<script type="text/javascript">

function reloadEMPLOYEEList()
{
  var params = "";
  params += "CODE=" + $("#CODE_search").val();
  params += "&NAME=" + $("#NAME_search").val();
  params += "&PRICE=" + $("#PRICE_search").val();
  jQuery("#EMPLOYEEGrid").setGridParam({ url:"<%=request.getContextPath() %>/EMPLOYEE_Servlet?" + params});
  jQuery("#EMPLOYEEGrid").clearGridData();
  jQuery("#EMPLOYEEGrid").trigger("reloadGrid");
}

function clear_create()
{
	$("#CODE_create").val("");
	$("#NAME_create").val("");
	$("#PRICE_create").val("");
}

function isValidForm_create() {
	 var code = trim($("#CODE_create").val());
	 var name = trim($("#NAME_create").val()); 
	 var price = trim($("#PRICE_create").val());
	 if (!((code == "") || (name == "") || (price == ""))) { 
		 return true; 
	} 
} 

function isValidForm_edit() {
	 var code = trim($("#CODE_edit").val()); 
	 var name = trim($("#NAME_edit").val()); 
	 var price = trim($("#PRICE_edit").val()); 
	 if (!((code == "") || (name == "") || (price == ""))) { 
		 return true; 
	} 
} 

function trim( value ) { 
	 var reL = /\s*((\S+\s*)*)/; 
	 var reR = /((\s*\S+)*)\s*/; 
	 value = value.replace(reL, "$1"); 
	 return value.replace(reR, "$1"); 
} 


$(function() {

  jQuery("#EMPLOYEEGrid").jqGrid({ 
      url:'<%=request.getContextPath() %>/EMPLOYEE_Servlet', 
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

  $( "#create" )
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
                                  url: "<%=request.getContextPath()%>/EMPLOYEE_Servlet",
                                  data: {"xml":"<doc><method>create</method><NAME>" + $("#CODE_create").val()+"</CODE><NAME>" + $("#NAME_create").val()+"</NAME><PRICE>" + $("#PRICE_create").val()+"</PRICE></doc>"},
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


  $( "#edit" )
      .button()
      .click(function() {
          $( "#dialog_form_edit" ).dialog({
              autoOpen: false,
              height: 300,
              width: 400,
              modal: true,
              buttons: {
                  Cancel: { text:'Hủy bỏ',
                      click: function() {
                          $( this ).dialog( "close" );
                      }
                  },
                  Save: { text:'Lưu', 
                      click: function() {
                          blockflag = true;
                          if 	(isValidForm_edit())
                          {
                              $.ajax({
                                  type: "POST",
                                  url: "<%=request.getContextPath()%>/EMPLOYEE_Servlet",
                                  data: {"xml":"<doc><method>update</method><EMPID>" + $("#EMPID_edit").val()+"</EMPID><NAME>" + $("#NAME_edit").val()+"</NAME><POSITION>" + $("#POSITION_edit").val()+"</POSITION><HIRE_DATE>"+$("#HIREDATE_edit").val()+"</HIRE_DATE></doc>"},
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
                                      if (msg.trim() == 'success'){
                                          jQuery("#EMPLOYEEGrid").trigger("reloadGrid");
                                      }else{
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
          });
          var id = jQuery("#EMPLOYEEGrid").jqGrid('getGridParam','selrow'); 
          if (id) {
              var ret = jQuery("#EMPLOYEEGrid").jqGrid('getRowData',id);
          $("#EMPID_edit").val(ret.EMP_ID);
          $("#NAME_edit").val(ret.NAME);
          $("#POSITION_edit").val(ret.POSITION);
          $("#HIREDATE_edit").val(ret.HIREDATE);
          $("#SALARY_edit").val(ret.SALARY);
          $("#dialog_form_edit" ).dialog( "open" ); 
          } else {
              $( "#dialog_info" ).dialog({
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
      });


  $( "#delete" )
      .button()
      .click(function() {
          var id1 = jQuery("#EMPLOYEEGrid").jqGrid('getGridParam','selrow'); 
          if (id1) {
              var ret = jQuery("#EMPLOYEEGrid").jqGrid('getRowData',id1); 
              $( "#dialog_confirm_delete" ).dialog({
                  resizable: false,
                  height:140,
                  modal: true,
                  buttons: {
                      "Xóa": function() {
                      blockflag = true;
                      $.ajax({
                          type: "POST",
                          url: "<%=request.getContextPath()%>/EMPLOYEE_Servlet",
                          data: {"xml":"<doc><method>delete</method><CODE>" + ret.CODE + "</CODE><NAME>" + $("#NAME_edit").val()+"</NAME><PRICE>" + $("#PRICE_edit").val()+"</PRICE></doc>"},
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
                              if (msg.trim() == 'success') {
                                  jQuery("#EMPLOYEEGrid").trigger("reloadGrid");
                              } else {
                                  document.getElementById('dialog_error').innerHTML="<font style='color:red;'>Có lỗi xảy ra " + msg + ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                  $("#dialog_error" ).dialog({modal: true,buttons:{OK: function(){$( this ).dialog( "close" );}}});blockflag = false;
                              };
                              }
                          });
                          $( this ).dialog( "close" );
                      },
                      Cancel: function() {
                          $( this ).dialog( "close" );
                      }
                  }
                  });
					/* $( this ).dialog( "close" ); */
              } else {
                  $( "#dialog_info" ).dialog({
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
          });
});
</script>


<div id="dialog_form_create" style="display: none;" title="Thêm mới" > 
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="CODE_create">Mã sản phẩm<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="CODE_create" name="CODE_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="NAME_create">Tên sản phẩm<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="NAME_create" name="NAME_create" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="PRICE_create">Giá tiền<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="PRICE_create" name="PRICE_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
		<br />


<div id="dialog_form_edit" style="display: none" title="Sửa">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="EMPID_edit">Mã Nhân viên<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="EMPID_edit" name="EMPID_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="NAME_edit">Tên nhân viên<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="NAME_edit" name="NAME_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="POSITION_edit">Vin trí<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="POSITION_edit" name="POSITION_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
				<td align=left><label for="HIREDATE_edit">Ngày nghỉ hưu<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="HIREDATE_edit" name="HIREDATE_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<!--<tr>
				<td align=left><label for="SALARY_edit">Lương<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="SALARY_edit" name="SALARY_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr> -->
			<tr>
			</tr>
		</table>
	</form>
</div>




<div id="dialog_validate" style="display: none" title="Thông báo">
Dữ liệu nhập vào chưa đầy đủ. Hãy kiểm tra lại các trường có dấu <font color="red"> (*)</font> <br />
</div>

<div id="dialog_info" style="display: none" title="Thông báo">
Hãy chọn một bản ghi
</div>

<div id="dialog_confirm_delete" style="display: none" title="Thông báo">
Có chắc muốn xóa không?
</div>
<div id="dialog_error" style="display: none" title="Báo lỗi">
Có lỗi xảy ra. Hãy kiểm tra lại!
</div>
<script type="text/javascript">
	$(document).ready(function(){
	$("#CODE_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadEMPLOYEEList();
		}
	});
	$("#NAME_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadEMPLOYEEList();
		}
	});
	
	$( "#search" )
	.button()
	.click(function() {
		reloadEMPLOYEEList();
	});//end #search 




	});
</script>