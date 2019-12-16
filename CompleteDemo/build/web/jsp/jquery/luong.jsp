<%-- 
    Document   : luong
    Created on : Dec 16, 2019, 9:53:11 PM
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
			<font size="5">BẢNG LƯƠNG</font>
			<br /> <br />
			
			<div id="dialog_search" title="Tìm kiếm" >
				<table width="70%">
				    <tr>
				    <td align=right><label for="ma_search">Mã lương</label></td>
				    <td align=left><input type="text" id="ma_search" name="ma_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    <td align=right><label for="manv_search">Mã nhân viên</label></td>
				    <td align=left><input type="text" id="manv_search" name="manv_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    </tr>
				    <tr> 
				    <td align=right><label for="luongcoban_search">lương cơ bản</label></td>
				    <td align=left><input type="text" id="luongcoban_search" name="luongcoban_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
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
			<table id="luongGrid"></table>
			<div id="Pager1"></div>
			<br />
		</div>
		<%@ include file = "../common/footer.jsp" %>
	</div>
</div>


<script type="text/javascript">

function reloadluongList()
{
  var params = "";
  params += "ma=" + $("#ma_search").val();
  params += "&manv=" + $("#manv_search").val();
  params += "&luongcoban=" + $("#luongcoban_search").val();
//  params += "&phucap=" + $("#phucap_search").val();
//  params += "&tienthuong=" + $("#tienthuong_search").val();
//  params += "&baohiem=" + $("#baohiem_search").val();
//  params += "&tong=" + $("#tong_search").val();
//  params += "&ngaylinh=" + $("#ngaylinh_search").val();
//  params += "&ghichu=" + $("#ghichu_search").val();
  jQuery("#luongGrid").setGridParam({ url:"<%=request.getContextPath() %>/luong_Servlet?" + params});
  jQuery("#luongGrid").clearGridData();
  jQuery("#luongGrid").trigger("reloadGrid");
}

function clear_create()
{
	$("#ma_create").val("");
	$("#manv_create").val("");
	$("#luongcoban_create").val("");
        $("#phucap_create").val("");
        $("#tienthuong_create").val("");
        $("#baohiem_create").val("");
        $("#tong_create").val("");
        $("#ngaylinh_create").val("");
        $("#ghichu_create").val("");
}

function isValidForm_create() {
	 var ma = trim($("#ma_create").val());
	 var manv = trim($("#manv_create").val()); 
	 var luongcoban = trim($("#luongcoban_create").val());
         var phucap = trim($("#phucap_create").val());
         var tienthuong = trim($("#tienthuong_create").val());
         var baohiem = trim($("#baohiem_create").val());
         var tong = trim($("#tong_create").val());
         var ngaylinh = trim($("#ngaylinh_create").val());
         var ghichu = trim($("#ghichu_create").val());
	 if (!((ma == "") || (manv == "") || (luongcoban == "") || (phucap == "") || (tienthuong == "") || (baohiem == "") || (tong == "") || (ngaylinh == "") || (ghichu == ""))) { 
		 return true; 
	} 
} 

function isValidForm_edit() {
	 var ma = trim($("#ma_edit").val()); 
	 var manv = trim($("#manv_edit").val()); 
	 var luongcoban = trim($("#luongcoban_edit").val()); 
         var phucap = trim($("#phucap_edit").val());
         var tienthuong = trim($("#tienthuong_edit").val());
         var baohiem = trim($("#baohiem_edit").val());
         var tong = trim($("#tong_edit").val());
         var ngaylinh = trim($("#ngaylinh_edit").val());
         var ghichu = trim($("#ghichu_edit").val());
	 if (!((ma == "") || (manv == "") || (luongcoban == "") || (phucap == "") || (tienthuong == "") || (baohiem == "") || (tong == "") || (ngaylinh == "") || (ghichu == ""))) { 
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

  jQuery("#luongGrid").jqGrid({ 
      url:'<%=request.getContextPath() %>/luong_Servlet', 
      datatype: "xml", 
      colNames:['STT', 'Mã số lương', 'Mã nhân viên', 'Lương cơ bản', 'Phụ cấp', 'Tiền thưởng', 'Bảo hiểm', 'Tổng', 'Ngày lĩnh', 'Ghi chú'], 
      colModel:[
          {name:'STT',index:'STT', width:80, align:"center"},
          {name:'ma',index:'ma', width:100},
          {name:'manv',index:'manv', width:200},
          {name:'luongcoban',index:'luongcoban', width:100, align:"right"},
          {name:'phucap',index:'phucap', width:100, align:"right"},
          {name:'tienthuong',index:'tienthuong', width:100, align:"right"},
          {name:'baohiem',index:'baohiem', width:100, align:"right"},
          {name:'tong',index:'tong', width:100, align:"right"},
          {name:'ngaylinh',index:'ngaylinh', width:100, align:"right"},
          {name:'ghichu',index:'ghichu', width:100, align:"right"}
          
          
      ],
      rowNum:15,  rowList:[15,30,60,80,150], pager: '#Pager1', 
      scrollrows: true,
      autowidth: false,
      height: 400,
      width:800,
      shrinkToFit:false,
      caption: " Danh sách lương",
      sortname: 'manv', viewrecords: true, sortorder: "desc"

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
                                  url: "<%=request.getContextPath()%>/luong_Servlet",
                                  data: {"xml":"<doc><method>create</method><ma>" + $("#ma_create").val()+"</ma><manv>" + $("#manv_create").val()+"</manv><luongcoban>" + $("#luongcoban_create").val()+"</luongcoban><phucap>" + $("#phucap_create").val()+"</phucap><tienthuong>" + $("#tienthuong_create").val()+"</tienthuong><baohiem>" + $("#baohiem_create").val()+"</baohiem><tong>" + $("#tong_create").val()+"</tong><ngaylinh>" + $("#ngaylinh_create").val()+"</ngaylinh><ghichu>" + $("#ghichu_create").val()+"</ghichu></doc>"},
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
                                          jQuery("#luongGrid").trigger("reloadGrid");
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
                                  url: "<%=request.getContextPath()%>/luong_Servlet",
                                  data: {"xml":"<doc><method>update</method><ma>" + $("#ma_edit").val()+"</ma><manv>" + $("#manv_edit").val()+"</manv><luongcoban>" + $("#luongcoban_edit").val()+"</luongcoban><phucap>" + $("#phucap_edit").val()+"</phucap><tienthuong>" + $("#tienthuong_edit").val()+"</tienthuong><baohiem>" + $("#baohiem_edit").val()+"</baohiem><tong>" + $("#tong_edit").val()+"</tong><ngaylinh>" + $("#ngaylinh_edit").val()+"</ngaylinh><ghichu>" + $("#ghichu_edit").val()+"</ghichu></doc>"},
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
                                          jQuery("#luongGrid").trigger("reloadGrid");
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
          var id = jQuery("#luongGrid").jqGrid('getGridParam','selrow'); 
          if (id) {
              var ret = jQuery("#luongGrid").jqGrid('getRowData',id);
          $("#ma_edit").val(ret.ma);
          $("#manv_edit").val(ret.manv);
          $("#luongcoban_edit").val(ret.luongcoban);
          $("#phucap_edit").val(ret.phucap);
          $("#tienthuong_edit").val(ret.tienthuong);
          $("#baohiem_edit").val(ret.baohiem);
          $("#tong_edit").val(ret.tong);
          $("#ngaylinh_edit").val(ret.ngaylinh);
          $("#ghichu_edit").val(ret.ghichu);
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
          var id1 = jQuery("#luongGrid").jqGrid('getGridParam','selrow'); 
          if (id1) {
              var ret = jQuery("#luongGrid").jqGrid('getRowData',id1); 
              $( "#dialog_confirm_delete" ).dialog({
                  resizable: false,
                  height:140,
                  modal: true,
                  buttons: {
                      "Xóa": function() {
                      blockflag = true;
                      $.ajax({
                          type: "POST",
                          url: "<%=request.getContextPath()%>/luong_Servlet",
                          data: {"xml":"<doc><method>delete</method><ma>" + ret.ma + "</ma><manv>" + $("#manv_edit").val()+"</manv><luongcoban>" + $("#luongcoban_edit").val()+"</luongcoban><phucap>" + $("#phucap_edit").val()+"</phucap><tienthuong>" + $("#tienthuong_edit").val()+"</tienthuong><baohiem>" + $("#baohiem_edit").val()+"</baohiem><tong>" + $("#tong_edit").val()+"</tong><ngaylinh>" + $("#ngaylinh_edit").val()+"</ngaylinh><ghichu>" + $("#ghichu_edit").val()+"</ghichu></doc>"},
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
                                  jQuery("#luongGrid").trigger("reloadGrid");
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
				<td align=left><label for="ma_create">Mã lương<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="ma_create" name="ma_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="manv_create">Mã nhân viên<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="manv_create" name="manv_create" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
			</tr>
			<tr>
				<td align=left><label for="luongcoban_create">lương cơ bản<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="luongcoban_create" name="luongcoban_create" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
			<tr>
                            <td align=left><label for="phucap_create">phụ cấp<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="phucap_create" name="phucap_create" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="tienthuong_create">tiền thưởng<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="tienthuong_create" name="tienthuong_create" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="baohiem_create">bảo hiểm<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="baohiem_create" name="baohiem_create" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="tong_create">tổng<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="tong_create" name="tong_create" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="ngaylinh_create">ngày lĩnh<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="ngaylinh_create" name="ngaylinh_create" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="ghichu_create">ghi chú<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="ghichu_create" name="ghichu_create" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
		</table>
	</form>
</div>
		<br />


<div id="dialog_form_edit" style="display: none" title="Sửa">
	<form>
		<table width="100%">
			<tr>
				<td align=left><label for="ma_edit">Mã sản phẩm<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="ma_edit" name="ma_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
			</tr>
			<tr>
				<td align=left><label for="manv_edit">Tên sản phẩm<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="manv_edit" name="manv_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
			</tr>
			<tr>
				<td align=left><label for="luongcoban_edit">lương cơ bản<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="luongcoban_edit" name="luongcoban_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
			</tr>
			<tr>
                            <td align=left><label for="phucap_edit">phụ cấp<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="phucap_edit" name="phucap_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="tienthuong_edit">tiền thưởng<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="tienthuong_edit" name="tienthuong_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="baohiem_edit">bảo hiểm<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="baohiem_edit" name="baohiem_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="tong_edit">tổng<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="tong_edit" name="tong_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="ngaylinh_edit">ngày lĩnh<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="ngaylinh_edit" name="ngaylinh_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
			</tr>
                        <tr>
                            <td align=left><label for="ghichu_edit">ghi chú<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="ghichu_edit" name="ghichu_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="15" /></td>
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
	$("#ma_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadluongList();
		}
	});
	$("#manv_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadluongList();
		}
	});
	
	$( "#search" )
	.button()
	.click(function() {
		reloadluongList();
	});//end #search 




	});
</script>

