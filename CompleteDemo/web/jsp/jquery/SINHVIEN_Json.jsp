<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<title>TEN CHUONG TRINH</title>
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
			<font style="font-size: x-large;">QL Sinh Viên Json</font>
			<br /> <br />
			
			<div id="dialog_search" title="Tìm kiếm" >
				<table width="70%">
				    <tr>
				    <td align=right><label for="MSV_search">Mã sinh viên</label></td>
				    <td align=left><input type="text" id="MSV_search" name="MSV_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    <td align=right><label for="Hoten_search">Họ tên</label></td>
				    <td align=left><input type="text" id="Hoten_search" name="Hoten_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    </tr>
				    <tr>
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
			<table id="SINHVIENGrid"></table>
			<div id="Pager1"></div>
			<br />
		</div>
		<%@ include file = "../common/footer.jsp" %>
	</div>
</div>


<script type="text/javascript">

function reloadSINHVIENList()
{
  var params = "";
  params += "MSV=" + $("#MSV_search").val();
  params += "&Hoten=" + $("#Hoten_search").val();
  jQuery("#SINHVIENGrid").setGridParam({ 
	  	url:"<%=request.getContextPath() %>/SINHVIEN_Json_Servlet?" + params});
  jQuery("#SINHVIENGrid").clearGridData();
  jQuery("#SINHVIENGrid").trigger("reloadGrid");
}

function clear_create()
{
	$("#MSV_create").val("");
	$("#Hoten_create").val("");
	$("#GT_create").val("");
	$("#NS_create").val("");
	$("#Que_create").val("");
	$("#Lop_create").val("");
}

function isValidForm_create() {
	 var msv = trim($("#MSV_create").val()); 
	 var hoten = trim($("#Hoten_create").val()); 
	 if (!((msv == "") || (hoten == ""))) { 
		 return true; 
	} 
} 

function isValidForm_edit() {
	 var msv = trim($("#MSV_edit").val()); 
	 var hoten = trim($("#Hoten_edit").val()); 
	 if (!((msv == "") || (hoten == ""))) { 
		 return true; 
	} 
} 

function trim( value ) { 
	 var reL = /\s*((\S+\s*)*)/; 
	 var reR = /((\s*\S+)*)\s*/; 
	 value = value.replace(reL, "$1"); 
	 return value.replace(reR, "$1"); 
} 

function buildDataCreate() {
	var obj = new Object();
	obj.method = "insert";
	obj.MSV = $("#MSV_create").val();
	obj.Hoten = $("#Hoten_create").val();
	obj.GT = $("#GT_create").val();
	obj.NS = $("#NS_create").val();
	obj.Que = $("#Que_create").val();
	obj.Lop = $("#Lop_create").val();
	return obj;
}
function buildDataEdit() {
	var obj = new Object();
	obj.method = "update";
	obj.MSV = $("#MSV_edit").val();
	obj.Hoten = $("#Hoten_edit").val();
	obj.GT = $("#GT_edit").val();
	obj.NS = $("#NS_edit").val();
	obj.Que = $("#Que_edit").val();
	obj.Lop = $("#Lop_edit").val();
	return obj;
}
function buildDataDelete() {
	var obj = new Object();
	obj.method = "delete";
	var id = jQuery("#SINHVIENGrid").jqGrid('getGridParam','selrow'); 
    if (id) {
        var ret = jQuery("#SINHVIENGrid").jqGrid('getRowData',id);}
	obj.MSV = ret.MSV;
	/* obj.Hoten = $("#Hoten_edit").val();
	obj.GT = $("#GT_edit").val();
	obj.NS = $("#NS_edit").val();
	obj.Que = $("#Que_edit").val();
	obj.Lop = $("#Lop_edit").val(); */
	return obj;
}

$(function() {

  jQuery("#SINHVIENGrid").jqGrid({ 
      url:'<%=request.getContextPath() %>/SINHVIEN_Json_Servlet', 
      datatype: "json", 
      colNames:['STT', 'Mã sinh viên', 'Họ tên', 'GT', 'Giới tính', 'Ngày sinh', 'Que', 'Quê quán', 'Lớp'], 
      colModel:[
          {name:'STT',index:'STT', width:80, align:"center"},
          {name:'MSV',index:'MSV', width:110},
          {name:'Hoten',index:'Hoten', width:180},
          {name:'GT',index:'GT', hidden:true},
          {name:'GT1',index:'GT1', width:100, align:"center"},
          {name:'NS',index:'NS', width:120, align:"center"},
          {name:'Que',index:'Que', hidden:true},
          {name:'ten_tinh',index:'ten_tinh', width:120},
          {name:'Lop',index:'Lop', width:100}
      ],
      rowNum:15,  rowList:[15,30,60,80,150], pager: '#Pager1', 
      scrollrows: true,
      autowidth: true,
      height: 370,
      width:1200,
      shrinkToFit:false,
      caption: " Danh sách SINHVIEN",
      sortname: 'MSV', viewrecords: true, sortorder: "ASC",
      gridComplete: function(){ 
			var ids = jQuery("#SINHVIENGrid").jqGrid('getDataIDs'); 
	        for(var i=0;i < ids.length;i++){ 
	        	var cl = ids[i]; 
	        	var ret = jQuery("#SINHVIENGrid").jqGrid('getRowData',cl);
	        	var gt = ret.GT1;
	        	if(gt == null || gt == '')
	        		gt = "Ko xác định";
        		else if(gt == '1') 
        			gt = "Nam";
        		else gt = "Nữ";
	        	jQuery("#SINHVIENGrid").jqGrid('setRowData',ids[i],{GT1:gt});
	        } 
		},

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
                                  url: "<%=request.getContextPath()%>/SINHVIEN_Json_Servlet",
                                  data: buildDataCreate(),
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
                                          jQuery("#SINHVIENGrid").trigger("reloadGrid");
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
                                  url: "<%=request.getContextPath()%>/SINHVIEN_Json_Servlet",
                                  data: buildDataEdit(),
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
                                          jQuery("#SINHVIENGrid").trigger("reloadGrid");
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
          var id = jQuery("#SINHVIENGrid").jqGrid('getGridParam','selrow'); 
          if (id) {
              var ret = jQuery("#SINHVIENGrid").jqGrid('getRowData',id);
          $("#MSV_edit").val(ret.MSV);
          $("#Hoten_edit").val(ret.Hoten);
          $("#GT_edit").val(ret.GT);
          $("#NS_edit").val(ret.NS);
          $("#Que_edit").val(ret.Que);
          $("#Lop_edit").val(ret.Lop);
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
          var id1 = jQuery("#SINHVIENGrid").jqGrid('getGridParam','selrow'); 
          if (id1) {
              var ret = jQuery("#SINHVIENGrid").jqGrid('getRowData',id1); 
              $( "#dialog_confirm_delete" ).dialog({
                  resizable: false,
                  height:140,
                  modal: true,
                  buttons: {
                      "Xóa": function() {
                      blockflag = true;
                      $.ajax({
                          type: "POST",
                          url: "<%=request.getContextPath()%>/SINHVIEN_Json_Servlet",
                          data: buildDataDelete(),
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
                                  jQuery("#SINHVIENGrid").trigger("reloadGrid");
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
				<td align=left><label for="MSV_create">Mã sinh viên<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="MSV_create" name="MSV_create" value="" class="text ui-widget-content ui-corner-all" maxlength="50" /></td>
			</tr>
			<tr>
				<td align=left><label for="Hoten_create">Họ tên<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="Hoten_create" name="Hoten_create" value="" class="text ui-widget-content ui-corner-all" maxlength="200" /></td>
			</tr>
			<tr>
				<td align=left><label for="GT_create">Giới tính</label></td>
				<td align=left><select	id="GT_create" style="width:250px;">
					<option value="1">Nam</option>
					<option value="0">Nữ</option>
				</select></td>
			</tr>
			<tr>
				<td align=left><label for="NS_create">Ngày sinh</label></td>
				<td align=left><input type="text" id="NS_create" name="NS_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
				<td align=left><label for="Que_create">Quê quán</label></td>
				<td align=left><select	id="Que_create" style="width:250px;">
					<option>loading...</option>
				</select></td>
			</tr>
			<tr>
				<td align=left><label for="Lop_create">Lớp</label></td>
				<td align=left><input type="text" id="Lop_create" name="Lop_create" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
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
				<td align=left><label for="MSV_edit">Mã sinh viên<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="MSV_edit" name="MSV_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="50" disabled="disabled"/></td>
			</tr>
			<tr>
				<td align=left><label for="Hoten_edit">Họ tên<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="Hoten_edit" name="Hoten_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="200" /></td>
			</tr>
			<tr>
				<td align=left><label for="GT_edit">Giới tính</label></td>
				<td align=left><select	id="GT_edit" style="width:250px;">
					<option value="1">Nam</option>
					<option value="0">Nữ</option>
				</select></td>
			</tr>
			<tr>
				<td align=left><label for="NS_edit">Ngày sinh</label></td>
				<td align=left><input type="text" id="NS_edit" name="NS_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
				<td align=left><label for="Que_edit">Quê quán</label></td>
				<td align=left><select	id="Que_edit" style="width:250px;">
					<option>loading...</option>
				</select></td>
			</tr>
			<tr>
				<td align=left><label for="Lop_edit">Lớp</label></td>
				<td align=left><input type="text" id="Lop_edit" name="Lop_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
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
	$("#MSV_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadSINHVIENList();
		}
	});
	$("#Hoten_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadSINHVIENList();
		}
	});
	$( "#search" )
	.button()
	.click(function() {
		reloadSINHVIENList();
	});//end #search 

	$("#NS_create").datepicker({ 
		dateFormat: "dd/mm/yy", 
		dayNames: ['Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy', 'Chủ nhật'], 
		dayNamesMin: ['CN','T2','T3','T4','T5','T6','T7'], 
		dayNamesShort: ['CN','Th2','Th3','Th4','Th5','Th6','Th7'], 
		monthNames: ['Tháng 1','Tháng 2','Tháng 3','Tháng 4', 'Tháng 5','Tháng 6','Tháng 7','Tháng 8', 'Tháng 9','Tháng 10','Tháng 11','Tháng 12'], 
		yearSuffix: '' 
	});
	
	$("#NS_edit").datepicker({ 
		dateFormat: "dd/mm/yy", 
		dayNames: ['Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy', 'Chủ nhật'], 
		dayNamesMin: ['CN','T2','T3','T4','T5','T6','T7'], 
		dayNamesShort: ['CN','Th2','Th3','Th4','Th5','Th6','Th7'], 
		monthNames: ['Tháng 1','Tháng 2','Tháng 3','Tháng 4', 'Tháng 5','Tháng 6','Tháng 7','Tháng 8', 'Tháng 9','Tháng 10','Tháng 11','Tháng 12'], 
		yearSuffix: '' 
	}); 
 
	$.ajax({ 
		type: "GET", 
		url: '<%=request.getContextPath() %>/SINHVIEN_Json_Servlet?method=getCbbData&cbbName=Que', 
		dataType: "json", 
		success: function(json) { 
			var Que_create = $('#Que_create'); 
			var Que_edit = $('#Que_edit'); 
			Que_create.find('option').remove().end(); 
			Que_create.append('<option value="" selected="true">-Chọn một dòng-</option>'); 
			Que_edit.find('option').remove().end(); 
			Que_edit.append('<option value="" selected="true">-Chọn một dòng-</option>');
			
			var htm = '';
			var len = json.length;
			for(var i=0; i<len; i++) {
				htm += '<option value="' + json[i].Value + '">' + json[i].Text + '</option>';
			}
			Que_create.append(htm); 
			Que_edit.append(htm); 
			
		} 
	}); 
});
</script>
