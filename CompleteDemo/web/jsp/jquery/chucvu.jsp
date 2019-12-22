<%-- 
    Document   : chucvu
    Created on : Dec 14, 2019, 10:23:13 PM
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
			<font size="5">CHỨC VỤ</font>
			<br /> <br />
			
			<div id="dialog_search" title="Tìm kiếm" >
				<table width="70%">
				    <tr>
				    <td align=right><label for="macv_search">Mã chức vụ</label></td>
				    <td align=left><input type="text" id="macv_search" name="macv_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    <td align=right><label for="tencv_search">Tên chức vụ</label></td>
				    <td align=left><input type="text" id="tencv_search" name="tencv_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    </tr>
				    <tr> 
				    <td align=right><label for="mapb_search">Mã phòng ban</label></td>
				    <td align=left><input type="text" id="mapb_search" name="mapb_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
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
			<table id="chucvuGrid"></table>
			<div id="Pager1"></div>
			<br />
		</div>
		<%@ include file = "../common/footer.jsp" %>
	</div>
</div>


<script type="text/javascript">

function reloadchucvuList()
{
  var params = "";
  params += "macv=" + $("#macv_search").val();
  params += "&tencv=" + $("#tencv_search").val();
  params += "&mapb=" + $("#mapb_search").val();
  jQuery("#chucvuGrid").setGridParam({ url:"<%=request.getContextPath() %>/chucvu_Servlet?" + params});
  jQuery("#chucvuGrid").clearGridData();
  jQuery("#chucvuGrid").trigger("reloadGrid");
}

function clear_create()
{
	$("#macv_create").val("");
	$("#tencv_create").val("");
	$("#mapb_create").val("");
        $("#congviec_create").val("");
}

function isValidForm_create() {
	 var macv = trim($("#macv_create").val());
	 var tencv = trim($("#tencv_create").val()); 
	 var congviec = trim($("#congviec_create").val());
         var mapb = trim($("#mapb_create").val());
	 if (!((macv == "") || (tencv == "") || (congviec == "") || (mapb == "") )) { 
		 return true; 
	} 
} 

function isValidForm_edit() {
	 var macv = trim($("#macv_edit").val()); 
	 var tencv = trim($("#tencv_edit").val()); 
	 var mapb = trim($("#mapb_edit").val()); 
         var congviec = trim($("#congviec_create").val());
	 if (!((macv == "") || (tencv == "") || (mapb == "") || (congviec == ""))) { 
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

  jQuery("#chucvuGrid").jqGrid({ 
      url:'<%=request.getContextPath() %>/chucvu_Servlet', 
      datatype: "xml", 
      colNames:['STT', 'Mã chức vụ', 'Tên chức vụ', 'mã phòng ban', 'công việc'], 
      colModel:[
          {name:'STT',index:'STT', width:80, align:"center"},
          {name:'macv',index:'macv', width:100},
          {name:'tencv',index:'tencv', width:200},
          {name:'mapb',index:'mapb', width:100},
          {name:'congviec',index:'congviec', width:100, align:"right"}
      ],
      rowNum:15,  rowList:[15,30,60,80,150], pager: '#Pager1', 
      scrollrows: true,
      autowidth: false,
      height: 400,
      width:800,
      shrinkToFit:false,
      caption: " Danh sách chucvu",
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
                                  url: "<%=request.getContextPath()%>/chucvu_Servlet",
                                  data: {"xml":"<doc><method>create</method><macv>" + $("#macv_create").val()+"</macv><tencv>" + $("#tencv_create").val()+"</tencv><mapb>" + $("#mapb_create").val()+"</mapb><congviec>" + $("#congviec_create").val()+"</congviec></doc>"},
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
                                          jQuery("#chucvuGrid").trigger("reloadGrid");
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
                                  url: "<%=request.getContextPath()%>/chucvu_Servlet",
                                  data: {"xml":"<doc><method>update</method><macv>" + $("#macv_edit").val()+"</macv><tencv>" + $("#tencv_edit").val()+"</tencv><mapb>" + $("#mapb_edit").val()+"</mapb><congviec>" + $("#congviec_edit").val()+"</congviec></doc>"},
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
                                          jQuery("#chucvuGrid").trigger("reloadGrid");
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
          var id = jQuery("#chucvuGrid").jqGrid('getGridParam','selrow'); 
          if (id) {
              var ret = jQuery("#chucvuGrid").jqGrid('getRowData',id);
          $("#macv_edit").val(ret.macv);
          $("#tencv_edit").val(ret.tencv);
          $("#mapb_edit").val(ret.mapb);
          $("#congviec_edit").val(ret.congviec);
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
          var id1 = jQuery("#chucvuGrid").jqGrid('getGridParam','selrow'); 
          if (id1) {
              var ret = jQuery("#chucvuGrid").jqGrid('getRowData',id1); 
              $( "#dialog_confirm_delete" ).dialog({
                  resizable: false,
                  height:140,
                  modal: true,
                  buttons: {
                      "Xóa": function() {
                      blockflag = true;
                      $.ajax({
                          type: "POST",
                          url: "<%=request.getContextPath()%>/chucvu_Servlet",
                          data: {"xml":"<doc><method>delete</method><macv>" + ret.macv + "</macv><tencv>" + $("#tencv_edit").val()+"</tencv><mapb>" + $("#mapb_edit").val()+"</mapb><congviec>" + $("#congviec_edit").val()+"</congviec></doc>"},
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
                                  jQuery("#chucvuGrid").trigger("reloadGrid");
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
				<td align=left><label for="macv_create">Mã công việc<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="macv_create" name="macv_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="tencv_create">Tên công việc<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="tencv_create" name="tencv_create" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="mapb_create">mã phòng ban<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="mapb_create" name="mapb_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
                            <td align=left><label for="congviec_create">công việc<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="congviec_create" name="mapb_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
		</table>
	</form>
</div>
		<br />


<div id="dialog_form_edit" style="display: none" title="Sửa">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="macv_edit">Mã công việc<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="macv_edit" name="macv_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="tencv_edit">Tên công việc<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="tencv_edit" name="tencv_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="mapb_edit">mã phòng ban<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="mapb_edit" name="mapb_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
                                <td align=left><label for="congviec_edit">công việc<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="congviec_edit" name="congviec_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
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
	$("#macv_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadchucvuList();
		}
	});
	$("#tencv_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadchucvuList();
		}
	});
	
	$( "#search" )
	.button()
	.click(function() {
		reloadchucvuList();
	});//end #search 




	});
</script>

