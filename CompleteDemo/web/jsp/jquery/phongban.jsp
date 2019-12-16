<%-- 
    Document   : phongban
    Created on : Dec 15, 2019, 1:06:56 PM
    Author     : Admin
--%>
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
			<font size="5">PHÒNG BAN</font>
			<br /> <br />
			
			<div id="dialog_search" title="Tìm kiếm" >
				<table width="70%">
				    <tr>
				    <td align=right><label for="mapb_search">Mã phòng ban</label></td>
				    <td align=left><input type="text" id="mapb_search" name="mapb_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    <td align=right><label for="tenpb_search">Tên phòng ban</label></td>
				    <td align=left><input type="text" id="tenpb_search" name="tenpb_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    </tr>
				    <tr> 
				    <td align=right><label for="diachi_search">Địa chỉ</label></td>
				    <td align=left><input type="text" id="diachi_search" name="diachi_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
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
			<table id="phongbanGrid"></table>
			<div id="Pager1"></div>
			<br />
		</div>
		<%@ include file = "../common/footer.jsp" %>
	</div>
</div>


<script type="text/javascript">

function reloadphongbanList()
{
  var params = "";
  params += "mapb=" + $("#mapb_search").val();
  params += "&tenpb=" + $("#tenpb_search").val();
  params += "&diachi=" + $("#diachi_search").val();
  params += "&sdt=" + $("#sdt_search").val();
  jQuery("#phongbanGrid").setGridParam({ url:"<%=request.getContextPath() %>/phongban_Servlet?" + params});
  jQuery("#phongbanGrid").clearGridData();
  jQuery("#phongbanGrid").trigger("reloadGrid");
}

function clear_create()
{
	$("#mapb_create").val("");
	$("#tenpb_create").val("");
	$("#diachi_create").val("");
        $("#sdt_create").val("");
}

function isValidForm_create() {
	 var mapb = trim($("#mapb_create").val());
	 var tenpb = trim($("#tenpb_create").val()); 
	 var sdt = trim($("#sdt_create").val());
         var diachi = trim($("#diachi_create").val());
	 if (!((mapb == "") || (tenpb == "") || (sdt == "") || (diachi == "") )) { 
		 return true; 
	} 
} 

function isValidForm_edit() {
	 var mapb = trim($("#mapb_edit").val()); 
	 var tenpb = trim($("#tenpb_edit").val()); 
	 var diachi = trim($("#diachi_edit").val()); 
         var sdt = trim($("#sdt_create").val());
	 if (!((mapb == "") || (tenpb == "") || (diachi == "") || (sdt == ""))) { 
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

  jQuery("#phongbanGrid").jqGrid({ 
      url:'<%=request.getContextPath() %>/phongban_Servlet', 
      datatype: "xml", 
      colNames:['STT', 'Mã phòng ban', 'Tên phòng ban', 'địa chỉ', 'số điện thoại'], 
      colModel:[
          {name:'STT',index:'STT', width:80, align:"center"},
          {name:'mapb',index:'mapb', width:100},
          {name:'tenpb',index:'tenpb', width:200},
          {name:'diachi',index:'diachi', width:100},
          {name:'sdt',index:'sdt', width:100, align:"right"}
      ],
      rowNum:15,  rowList:[15,30,60,80,150], pager: '#Pager1', 
      scrollrows: true,
      autowidth: false,
      height: 400,
      width:800,
      shrinkToFit:false,
      caption: " Danh sách phòng ban",
      sortname: 'mapb', viewrecords: true, sortorder: "desc"

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
                                  url: "<%=request.getContextPath()%>/phongban_Servlet",
                                  data: {"xml":"<doc><method>create</method><mapb>" + $("#mapb_create").val()+"</mapb><tenpb>" + $("#tenpb_create").val()+"</tenpb><diachi>" + $("#diachi_create").val()+"</diachi><sdt>" + $("#sdt_create").val()+"</sdt></doc>"},
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
                                          jQuery("#phongbanGrid").trigger("reloadGrid");
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
                                  url: "<%=request.getContextPath()%>/phongban_Servlet",
                                  data: {"xml":"<doc><method>update</method><mapb>" + $("#mapb_edit").val()+"</mapb><tenpb>" + $("#tenpb_edit").val()+"</tenpb><diachi>" + $("#diachi_edit").val()+"</diachi><sdt>" + $("#sdt_edit").val()+"</sdt></doc>"},
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
                                          jQuery("#phongbanGrid").trigger("reloadGrid");
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
          var id = jQuery("#phongbanGrid").jqGrid('getGridParam','selrow'); 
          if (id) {
              var ret = jQuery("#phongbanGrid").jqGrid('getRowData',id);
          $("#mapb_edit").val(ret.mapb);
          $("#tenpb_edit").val(ret.tenpb);
          $("#diachi_edit").val(ret.diachi);
          $("#sdt_edit").val(ret.sdt);
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
          var id1 = jQuery("#phongbanGrid").jqGrid('getGridParam','selrow'); 
          if (id1) {
              var ret = jQuery("#phongbanGrid").jqGrid('getRowData',id1); 
              $( "#dialog_confirm_delete" ).dialog({
                  resizable: false,
                  height:140,
                  modal: true,
                  buttons: {
                      "Xóa": function() {
                      blockflag = true;
                      $.ajax({
                          type: "POST",
                          url: "<%=request.getContextPath()%>/phongban_Servlet",
                          data: {"xml":"<doc><method>delete</method><mapb>" + ret.mapb + "</mapb><tenpb>" + $("#tenpb_edit").val()+"</tenpb><diachi>" + $("#diachi_edit").val()+"</diachi><sdt>" + $("#sdt_edit").val()+"</sdt></doc>"},
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
                                  jQuery("#phongbanGrid").trigger("reloadGrid");
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
				<td align=left><label for="mapb_create">Mã phòng ban<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="mapb_create" name="mapb_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="tenpb_create">Tên phòng ban<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="tenpb_create" name="tenpb_create" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="diachi_create">Địa chỉ phòng ban<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="diachi_create" name="diachi_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
                            <td align=left><label for="sdt_create">số điện thoại<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="sdt_create" name="sdt_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
		</table>
	</form>
</div>
		<br />


<div id="dialog_form_edit" style="display: none" title="Sửa">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="mapb_edit">Mã phòng ban<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="mapb_edit" name="mapb_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="tenpb_edit">Tên phòng ban<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="tenpb_edit" name="tenpb_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="diachi_edit">địa chỉ<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="diachi_edit" name="diachi_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
                                <td align=left><label for="sdt_edit">số điện thoại<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="sdt_edit" name="sdt_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
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
	$("#mapb_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadphongbanList();
		}
	});
	$("#tenpb_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadphongbanList();
		}
	});
	
	$( "#search" )
	.button()
	.click(function() {
		reloadphongbanList();
	});//end #search 




	});
</script>

