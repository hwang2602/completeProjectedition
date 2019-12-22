<%-- 
    Document   : chamcong
    Created on : Dec 22, 2019, 3:07:44 PM
    Author     : Admin
--%>
<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<title>Quản lý nhân sự</title>
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
			<font size="5">QUẢN LÝ CHẤM CÔNG</font>
			<br /> <br />
			
			<div id="dialog_search" title="Tìm kiếm" >
				<table width="70%">
				    <tr>
				    <td align=right><label for="machamcong_search">Mã chấm công</label></td>
				    <td align=left><input type="text" id="machamcong_search" name="machamcong_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    <td align=right><label for="manv_search">Mã nhân viên</label></td>
				    <td align=left><input type="text" id="manv_search" name="manv_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    </tr>
				    <tr> 
				    <td align=right><label for="ngaychamcong_search">Ngày chấm công</label></td>
				    <td align=left><input type="text" id="ngaychamcong_search" name="ngaychamcong_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
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
			<table id="chamcongGrid"></table>
			<div id="Pager1"></div>
			<br />
		</div>
		<%@ include file = "../common/footer.jsp" %>
	</div>
</div>


<script type="text/javascript">

function reloadchamcongList()
{
  var params = "";
  params += "machamcong=" + $("#machamcong_search").val();
  params += "&manv=" + $("#manv_search").val();
  params += "&ngaychamcong=" + $("#ngaychamcong_search").val();
  jQuery("#chamcongGrid").setGridParam({ url:"<%=request.getContextPath() %>/chamcong_Servlet?" + params});
  jQuery("#chamcongGrid").clearGridData();
  jQuery("#chamcongGrid").trigger("reloadGrid");
}

function clear_create()
{
	$("#machamcong_create").val("");
	$("#manv_create").val("");
	$("#ngaychamcong_create").val("");
}

function isValidForm_create() {
	 var machamcong = trim($("#machamcong_create").val());
	 var manv = trim($("#manv_create").val()); 
	 var ngaychamcong = trim($("#ngaychamcong_create").val());
	 if (!((machamcong == "") || (manv == "") || (ngaychamcong == ""))) { 
		 return true; 
	} 
} 

function isValidForm_edit() {
	 var machamcong = trim($("#machamcong_edit").val()); 
	 var manv = trim($("#manv_edit").val()); 
	 var ngaychamcong = trim($("#ngaychamcong_edit").val()); 
	 if (!((machamcong == "") || (manv == "") || (ngaychamcong == ""))) { 
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

  jQuery("#chamcongGrid").jqGrid({ 
      url:'<%=request.getContextPath() %>/chamcong_Servlet', 
      datatype: "xml", 
      colNames:['STT', 'Mã chấm công', 'Mã nhân viên', 'Ngày chấm công'], 
      colModel:[
          {name:'STT',index:'STT', width:80, align:"center"},
          {name:'machamcong',index:'machamcong', width:100},
          {name:'manv',index:'manv', width:200},
          {name:'ngaychamcong',index:'ngaychamcong', width:100, align:"right"}
      ],
      rowNum:15,  rowList:[15,30,60,80,150], pager: '#Pager1', 
      scrollrows: true,
      autowidth: false,
      height: 400,
      width:800,
      shrinkToFit:false,
      caption: " Danh sách chamcong",
      sortname: 'ngaychamcong', viewrecords: true, sortorder: "desc"

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
                                  url: "<%=request.getContextPath()%>/chamcong_Servlet",
                                  data: {"xml":"<doc><method>create</method><machamcong>" + $("#machamcong_create").val()+"</machamcong><manv>" + $("#manv_create").val()+"</manv><ngaychamcong>" + $("#ngaychamcong_create").val()+"</ngaychamcong></doc>"},
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
                                          jQuery("#chamcongGrid").trigger("reloadGrid");
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
                                  url: "<%=request.getContextPath()%>/chamcong_Servlet",
                                  data: {"xml":"<doc><method>update</method><machamcong>" + $("#machamcong_edit").val()+"</machamcong><manv>" + $("#manv_edit").val()+"</manv><ngaychamcong>" + $("#ngaychamcong_edit").val()+"</ngaychamcong></doc>"},
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
                                          jQuery("#chamcongGrid").trigger("reloadGrid");
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
          var id = jQuery("#chamcongGrid").jqGrid('getGridParam','selrow'); 
          if (id) {
              var ret = jQuery("#chamcongGrid").jqGrid('getRowData',id);
          $("#machamcong_edit").val(ret.machamcong);
          $("#manv_edit").val(ret.manv);
          $("#ngaychamcong_edit").val(ret.ngaychamcong);
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
          var id1 = jQuery("#chamcongGrid").jqGrid('getGridParam','selrow'); 
          if (id1) {
              var ret = jQuery("#chamcongGrid").jqGrid('getRowData',id1); 
              $( "#dialog_confirm_delete" ).dialog({
                  resizable: false,
                  height:140,
                  modal: true,
                  buttons: {
                      "Xóa": function() {
                      blockflag = true;
                      $.ajax({
                          type: "POST",
                          url: "<%=request.getContextPath()%>/chamcong_Servlet",
                          data: {"xml":"<doc><method>delete</method><machamcong>" + ret.machamcong + "</machamcong><manv>" + $("#manv_edit").val()+"</manv><ngaychamcong>" + $("#ngaychamcong_edit").val()+"</ngaychamcong></doc>"},
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
                                  jQuery("#chamcongGrid").trigger("reloadGrid");
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
				<td align=left><label for="machamcong_create">Mã chấm công<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="machamcong_create" name="machamcong_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="manv_create">Mã nhân viên<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="manv_create" name="manv_create" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="ngaychamcong_create">Ngày chấm công<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="ngaychamcong_create" name="ngaychamcong_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
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
				<td align=left><label for="machamcong_edit">Mã chấm công<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="machamcong_edit" name="machamcong_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="manv_edit">Mã nhân viên<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="manv_edit" name="manv_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="ngaychamcong_edit">Ngày chấm công<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="ngaychamcong_edit" name="ngaychamcong_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
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
	$("#machamcong_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadchamcongList();
		}
	});
	$("#manv_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadchamcongList();
		}
	});
	
	$( "#search" )
	.button()
	.click(function() {
		reloadchamcongList();
	});//end #search 




	});
</script>

