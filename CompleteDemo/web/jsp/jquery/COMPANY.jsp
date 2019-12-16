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

<div id="mainbody"><jsp:include page="../common/header.jsp" />
	<div id="ja-wrapper">
		<div id="ja-wrapper-top"></div>
		<div id="ja-wrapper-inner" class="clearfix">		
			<h1>Cập nhật COMPANY</h1>
			<br /> <br />
			
			<div id="dialog_search" title="Tìm kiếm" >
				<table width="70%">
				    <tr>
				    <td align=right><label for="CName_search">CName</label></td>
				    <td align=left><input type="text" id="CName_search" name="CName_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
				    <td align=right><label for="StockPrice_search">StockPrice</label></td>
				    <td align=left><input type="text" id="StockPrice_search" name="StockPrice_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
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
			<table id="COMPANYGrid"></table>
			<div id="Pager1"></div>
			<br />
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</div>


<script type="text/javascript">

function reloadCOMPANYList()
{
  var params = "";
  params += "CName=" + $("#CName_search").val();
  params += "&StockPrice=" + $("#StockPrice_search").val();
  jQuery("#COMPANYGrid").setGridParam({ url:"<%=request.getContextPath() %>/COMPANY_Servlet?" + params});
  jQuery("#COMPANYGrid").clearGridData();
  jQuery("#COMPANYGrid").trigger("reloadGrid");
}

function clear_create()
{
	$("#CName_create").val("");
	$("#StockPrice_create").val("");
	$("#Country_create").val("");
}

							        function isValidForm_create() {
	 var cname = trim($("# CName_create").val()); 
	 var stockprice = trim($("# StockPrice_create").val()); 
	 var country = trim($("# Country_create").val()); 
	 if (!((cname == "") || (stockprice == "") || (country == ""))) { 
		 return true; 
	} 
} 

function isValidForm_edit() {
	 var cname = trim($("# CName_create").val()); 
	 var stockprice = trim($("# StockPrice_create").val()); 
	 var country = trim($("# Country_create").val()); 
	 if (!((cname == "") || (stockprice == "") || (country == ""))) { 
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

  jQuery("#COMPANYGrid").jqGrid({ 
      url:'<%=request.getContextPath() %>/COMPANY_Servlet', 
      datatype: "xml", 
      colNames:['STT', 'CName', 'StockPrice', 'Country'], 
      colModel:[
          {name:'STT',index:'STT', width:80, align:"center"},
          {name:'CName',index:'CName', width:100},
          {name:'StockPrice',index:'StockPrice', width:100},
          {name:'Country',index:'Country', width:100}
      ],
      rowNum:20,  rowList:[20,40,60,80,150], pager: '#Pager1', 
      scrollrows: true,
      autowidth: true,
      height: 400,
      width:1200,
      shrinkToFit:false,
      caption: " Danh sách COMPANY",
      sortname: 'CName', viewrecords: true, sortorder: "ASC"

  }).navGrid('#Pager1',{edit:false,add:false,del:false,search:false,refresh:true,view:false,position:"left",cloneToTop:true});

  $( "#create" )
      .button()
      .click(function() {
          clear_create();
          $( "#dialog_form_create" ).dialog({
              autoOpen: true,
              height: 150,
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
                                  url: "<%=request.getContextPath()%>/COMPANY_Servlet",
                                  data: {"xml":"<doc><method>create</method><CName>" + $("#CName_create").val()+"</CName><StockPrice>" + $("#StockPrice_create").val()+"</StockPrice><Country>" + $("#Country_create").val()+"</Country></doc>"},
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
                                          jQuery("#COMPANYGrid").trigger("reloadGrid");
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
              height: 150,
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
                                  url: "<%=request.getContextPath()%>/COMPANY_Servlet",
                                  data: {"xml":"<doc><method>update</method><CName>" + $("#CName_edit").val()+"</CName><StockPrice>" + $("#StockPrice_edit").val()+"</StockPrice><Country>" + $("#Country_edit").val()+"</Country></doc>"},
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
                                          jQuery("#COMPANYGrid").trigger("reloadGrid");
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
          var id = jQuery("#COMPANYGrid").jqGrid('getGridParam','selrow'); 
          if (id) {
              var ret = jQuery("#COMPANYGrid").jqGrid('getRowData',id);
          $("#CName_edit").val(ret.CName);
          $("#StockPrice_edit").val(ret.StockPrice);
          $("#Country_edit").val(ret.Country);
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
          var id1 = jQuery("#COMPANYGrid").jqGrid('getGridParam','selrow'); 
          if (id1) {
              var ret = jQuery("#COMPANYGrid").jqGrid('getRowData',id1); 
              $( "#dialog_confirm_delete" ).dialog({
                  resizable: false,
                  height:140,
                  modal: true,
                  buttons: {
                      "Xóa": function() {
                      blockflag = true;
                      $.ajax({
                          type: "POST",
                          url: "<%=request.getContextPath()%>/COMPANY_Servlet",
                          data: {"xml":"<doc><method>delete</method><CName>" + $("#CName_edit").val()+"</CName><StockPrice>" + $("#StockPrice_edit").val()+"</StockPrice><Country>" + $("#Country_edit").val()+"</Country></doc>"},
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
                                  jQuery("#COMPANYGrid").trigger("reloadGrid");
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
				<td align=left><label for="CName_create">CName<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="CName_create" name="CName_create" value="" class="text ui-widget-content ui-corner-all" maxlength="50" /></td>
			</tr>
			<tr>
				<td align=left><label for="StockPrice_create">StockPrice<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="StockPrice_create" name="StockPrice_create" value="" class="text ui-widget-content ui-corner-all" maxlength="2" /></td>
			</tr>
			<tr>
				<td align=left><label for="Country_create">Country<font color="red"> (*)</font></label></td>
				<td align=left><input type="text" id="Country_create" name="Country_create" value="" class="text ui-widget-content ui-corner-all" maxlength="50" /></td>
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
				<td align=left><label for="CName_edit">CName<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="CName_edit" name="CName_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="50" /></td>
			</tr>
			<tr>
				<td align=left><label for="StockPrice_edit">StockPrice<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="StockPrice_edit" name="StockPrice_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="2" /></td>
			</tr>
			<tr>
				<td align=left><label for="Country_edit">Country<font color="red">(*)</font></label></td>
				<td align=left><input type="text" id="Country_edit" name="Country_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="50" /></td>
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
	$("#CName_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadCOMPANYList();
		}
	});
	$("#StockPrice_search").keypress(function(event) {
		if ( event.which == 13 ) {
			reloadCOMPANYList();
		}
	});
	$( "#search" )
	.button()
	.click(function() {
		reloadCOMPANYList();
	});//end #search 




	});
</script>
