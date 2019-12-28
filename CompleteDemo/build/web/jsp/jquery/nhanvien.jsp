<%-- 
    Document   : nhanvien
    Created on : Dec 17, 2019, 9:37:26 AM
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
            <font size="5">QUẢN LÝ NHÂN VIÊN</font>
            <br /> <br />

            <div id="dialog_search" title="Tìm kiếm" >
                <table width="70%">
                    <tr>
                        <td align=right><label for="manv_search">Mã nhân viên</label></td>
                        <td align=left><input type="text" id="manv_search" name="manv_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
                        <td align=right><label for="hoten_search">Tên nhân viên</label></td>
                        <td align=left><input type="text" id="hoten_search" name="hoten_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
                    </tr>
                    <tr> 
                        <td align=right><label for="gioitinh_search">Giới tính</label></td>
                        <td align=left><input type="text" id="gioitinh_search" name="gioitinh_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
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
            <table id="nhanvienGrid"></table>
            <div id="Pager1"></div>
            <br />
        </div>
        <%@ include file = "../common/footer.jsp" %>
    </div>
</div>


<script type="text/javascript">

    function reloadnhanvienList()
    {
        var params = "";
        params += "manv=" + $("#manv_search").val();
        params += "&hoten=" + $("#hoten_search").val();
        params += "&gioitinh=" + $("#gioitinh_search").val();
        jQuery("#nhanvienGrid").setGridParam({url: "<%=request.getContextPath()%>/nhanvien_Servlet?" + params});
        jQuery("#nhanvienGrid").clearGridData();
        jQuery("#nhanvienGrid").trigger("reloadGrid");
    }

    function clear_create()
    {
        $("#manv_create").val("");
        $("#hoten_create").val("");
        $("#ngaysinh_create").val("");
        $("#gioitinh_create").val("");
        $("#diachi_create").val("");
        $("#sdt_create").val("");
        $("#mapb_create").val("");
        $("#macv_create").val("");
    }

    function isValidForm_create() {
        var manv = trim($("#manv_create").val());
        var hoten = trim($("#hoten_create").val());
        var ngaysinh = trim($("#ngaysinh_create").val(""));
        var gioitinh = trim($("#gioitinh_create").val());
        var diachi = trim($("#diachi_create").val());
        var sdt = trim($("#sdt_create").val());
        var mapb = trim($("#mapb_create").val());
        var macv = trim($("#macv_create").val());
        if (!((manv == "") || (hoten == "") || (ngaysinh == "") || (gioitinh == "") || (diachi == "") || (sdt == "") || (mapb == "") || (macv == ""))) {
            return true;
        }
    }

    function isValidForm_edit() {
        var manv = trim($("#manv_edit").val());
        var hoten = trim($("#hoten_edit").val());
        var ngaysinh = trim($("#ngaysinh_edit").val(""));
        var gioitinh = trim($("#gioitinh_edit").val());
        var diachi = trim($("#diachi_edit").val());
        var sdt = trim($("#sdt_edit").val());
        var mapb = trim($("#mapb_edit").val());
        var macv = trim($("#macv_edit").val());
        if (!((manv == "") || (hoten == "") || (gioitinh == "") || (ngaysinh == "") || (diachi == "") || (sdt == "") || (mapb == "") || (macv == ""))) {
            return true;
        }
    }

    function trim(value) {
        var reL = /\s*((\S+\s*)*)/;
        var reR = /((\s*\S+)*)\s*/;
        value = value.replace(reL, "$1");
        return value.replace(reR, "$1");
    }


    $(function () {

        jQuery("#nhanvienGrid").jqGrid({
            url: '<%=request.getContextPath()%>/nhanvien_Servlet',
            datatype: "xml",
            colNames: ['STT', 'Mã nhân viên', 'Tên nhân viên', 'Ngày sinh', 'Giới tính', 'Địa chỉ', 'Số điện thoại', 'Mã phòng ban', 'Mã chức vụ'],
            colModel: [
                {name: 'STT', index: 'STT', width: 80, align: "center"},
                {name: 'manv', index: 'manv', width: 80},
                {name: 'hoten', index: 'hoten', width: 150},
                {name: 'ngaysinh', index: 'ngaysinh', width: 100},
                {name: 'gioitinh', index: 'gioitinh', width: 100},
                {name: 'diachi', index: 'diachi', width: 200},
                {name: 'sdt', index: 'sdt', width: 100},
                {name: 'mapb', index: 'mapb', width: 80},
                {name: 'macv', index: 'macv', width: 80, align: "right"}
            ],
            rowNum: 15, rowList: [15, 30, 60, 80, 150], pager: '#Pager1',
            scrollrows: true,
            autowidth: false,
            height: 400,
            width: 1100,
            shrinkToFit: false,
            caption: " Danh sách nhân viên",
            sortname: 'manv', viewrecords: true, sortorder: "desc"

        }).navGrid('#Pager1', {edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: true});

        $("#create")
                .button()
                .click(function () {
                    clear_create();
                    $("#dialog_form_create").dialog({
                        autoOpen: true,
                        height: 300,
                        width: 400,
                        modal: true,
                        buttons: {
                            Cancel: {text: 'Hủy bỏ',
                                click: function () {
                                    $(this).dialog("close");
                                }
                            },
                            Create: {text: 'Lưu',
                                click: function () {
                                    blockflag = true;
                                    if (isValidForm_create())
                                    {
                                        $.ajax({
                                            type: "POST",
                                            url: "<%=request.getContextPath()%>/nhanvien_Servlet",
                                            data: {"xml": "<doc><method>create</method><manv>" + $("#manv_create").val() + "</manv><hoten>" + $("#hoten_create").val() + "</hoten><ngaysinh>" + $("#ngaysinh_create").val() + "</ngaysinh><gioitinh>" + $("#gioitinh_create").val() + "</gioitinh><diachi>" + $("#diachi_create").val() + "</diachi><sdt>" + $("#sdt_create").val() + "</sdt><mapb>" + $("#mapb_create").val() + "</mapb><macv>" + $("#macv_create").val() + "</macv></doc>"},
                                            error: function () {
                                                $("#dialog_error").dialog({
                                                    modal: true,
                                                    buttons: {
                                                        OK: function () {
                                                            $(this).dialog("close");
                                                        }
                                                    }
                                                });
                                                blockflag = false;
                                            },
                                            success: function (msg) {
                                                if (msg.trim() == 'success') {
                                                    jQuery("#nhanvienGrid").trigger("reloadGrid");
                                                } else {
                                                    document.getElementById('dialog_error').innerHTML = "<font style='color:red;'>Có lỗi xảy ra " + msg + ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                                    $("#dialog_error").dialog({modal: true, buttons: {OK: function () {
                                                                $(this).dialog("close");
                                                            }}});
                                                    blockflag = false;
                                                }
                                                ;
                                            }
                                        });
                                        $(this).dialog("close");
                                    } else {
                                        $("#dialog_validate").dialog({
                                            modal: true,
                                            height: 230,
                                            width: 350,
                                            buttons: {
                                                OK: function () {
                                                    $(this).dialog("close");
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


        $("#edit")
                .button()
                .click(function () {
                    $("#dialog_form_edit").dialog({
                        autoOpen: false,
                        height: 300,
                        width: 400,
                        modal: true,
                        buttons: {
                            Cancel: {text: 'Hủy bỏ',
                                click: function () {
                                    $(this).dialog("close");
                                }
                            },
                            Save: {text: 'Lưu',
                                click: function () {
                                    blockflag = true;
                                    if (isValidForm_edit())
                                    {
                                        $.ajax({
                                            type: "POST",
                                            url: "<%=request.getContextPath()%>/nhanvien_Servlet",
                                            data: {"xml": "<doc><method>update</method><manv>" + $("#manv_edit").val() + "</manv><hoten>" + $("#hoten_edit").val() + "</hoten><ngaysinh>" + $("#ngaysinh_edit").val() + "</ngaysinh><gioitinh>" + $("#gioitinh_edit").val() + "</gioitinh><diachi>" + $("#diachi_edit").val() + "</diachi><sdt>" + $("#sdt_edit").val() + "</sdt><mapb>" + $("#mapb_edit").val() + "</mapb><macv>" + $("#macv_edit").val() + "</macv></doc>"},
                                            error: function () {

                                                $("#dialog_error").dialog({
                                                    modal: true,
                                                    buttons: {
                                                        OK: function () {
                                                            $(this).dialog("close");
                                                        }
                                                    }
                                                });
                                                blockflag = false;
                                            },
                                            success: function (msg) {
                                                if (msg.trim() == 'success') {
                                                    jQuery("#nhanvienGrid").trigger("reloadGrid");
                                                } else {
                                                    document.getElementById('dialog_error').innerHTML = "<font style='color:red;'>Có lỗi xảy ra " + msg + ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                                    $("#dialog_error").dialog({modal: true, buttons: {OK: function () {
                                                                $(this).dialog("close");
                                                            }}});
                                                    blockflag = false;
                                                }
                                                ;
                                            }
                                        });
                                        $(this).dialog("close");
                                    } else {
                                        $("#dialog_validate").dialog({
                                            modal: true,
                                            height: 230,
                                            width: 350,
                                            buttons: {
                                                OK: function () {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        });
                                    }
                                }
                            }
                        }
                    });
                    var id = jQuery("#nhanvienGrid").jqGrid('getGridParam', 'selrow');
                    if (id) {
                        var ret = jQuery("#nhanvienGrid").jqGrid('getRowData', id);
                        $("#manv_edit").val(ret.manv);
                        $("#hoten_edit").val(ret.hoten);
                        $("#ngaysinh_edit").val(ret.ngaysinh);
                        $("#gioitinh_edit").val(ret.gioitinh);
                        $("#diachi_edit").val(ret.diachi);
                        $("#sdt_edit").val(ret.sdt);
                        $("#mapb_edit").val(ret.mapb);
                        $("#macv_edit").val(ret.macv);
                        $("#dialog_form_edit").dialog("open");
                    } else {
                        $("#dialog_info").dialog({
                            modal: true,
                            height: 230,
                            width: 350,
                            buttons: {
                                OK: function () {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    }
                });


        $("#delete")
                .button()
                .click(function () {
                    var id1 = jQuery("#nhanvienGrid").jqGrid('getGridParam', 'selrow');
                    if (id1) {
                        var ret = jQuery("#nhanvienGrid").jqGrid('getRowData', id1);
                        $("#dialog_confirm_delete").dialog({
                            resizable: false,
                            height: 140,
                            modal: true,
                            buttons: {
                                "Xóa": function () {
                                    blockflag = true;
                                    $.ajax({
                                        type: "POST",
                                        url: "<%=request.getContextPath()%>/nhanvien_Servlet",
                                        data: {"xml": "<doc><method>delete</method><manv>" + ret.manv + "</manv><hoten>" + $("#hoten_edit").val() + "</hoten><ngaysinh>" + $("#ngaysinh_edit").val() + "</ngaysinh><gioitinh>" + $("#gioitinh_edit").val() + "</gioitinh><diachi>" + $("#diachi_edit").val() + "</diachi><sdt>" + $("#sdt_edit").val() + "</sdt><mapb>" + $("#mapb_edit").val() + "</mapb><macv>" + $("#macv_edit").val() + "</macv></doc>"},
                                        error: function () {
                                            $("#dialog_error").dialog({
                                                modal: true,
                                                buttons: {
                                                    OK: function () {
                                                        $(this).dialog("close");
                                                    }
                                                }
                                            });
                                            blockflag = false;
                                        },
                                        success: function (msg) {
                                            if (msg.trim() == 'success') {
                                                jQuery("#nhanvienGrid").trigger("reloadGrid");
                                            } else {
                                                document.getElementById('dialog_error').innerHTML = "<font style='color:red;'>Có lỗi xảy ra " + msg + ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                                $("#dialog_error").dialog({modal: true, buttons: {OK: function () {
                                                            $(this).dialog("close");
                                                        }}});
                                                blockflag = false;
                                            }
                                            ;
                                        }
                                    });
                                    $(this).dialog("close");
                                },
                                Cancel: function () {
                                    $(this).dialog("close");
                                }
                            }
                        });
                        /* $( this ).dialog( "close" ); */
                    } else {
                        $("#dialog_info").dialog({
                            modal: true,
                            height: 230,
                            width: 350,
                            buttons: {
                                OK: function () {
                                    $(this).dialog("close");
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
                <td align=left><label for="manv_create">Mã nhân viên<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="manv_create" name="manv_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
            </tr>
            <tr>
                <td align=left><label for="hoten_create">Tên nhân viên<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="hoten_create" name="hoten_create" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
            </tr>
            <tr>
                <td align=left><label for="ngaysinh_create">Ngày sinh<font color="red"> </font></label></td>
                <td align=left><input type="text" id="ngaysinh_create" name="ngaysinh_create" value="" class="text ui-widget-content ui-corner-all" maxlength="12" /></td>
            </tr>
            <tr>
                <td align=left><label for="gioitinh_create">Giới tính<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="gioitinh_create" name="gioitinh_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
            </tr>
            <tr>
                <td align=left><label for="diachi_create">Địa chỉ<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="diachi_create" name="diachi_create" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
            </tr>
            <tr>
                <td align=left><label for="sdt_create">Số điện thoại<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="sdt_create" name="sdt_create" value="" class="text ui-widget-content ui-corner-all" maxlength="11" /></td>
            </tr>
            <tr>
                <td align=left><label for="mapb_create">Mã phòng ban<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="mapb_create" name="mapb_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
            </tr>
            <tr>
                <td align=left><label for="macv_create">Mã chức vụ<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="macv_create" name="macv_create" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
            </tr>
        </table>
    </form>
</div>
<br />


<div id="dialog_form_edit" style="display: none" title="Sửa">
    <form>
        <table width="100%">
            <tr>
                <td align=left><label for="manv_edit">Mã nhân viên<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="manv_edit" name="manv_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
            </tr>
            <tr>
                <td align=left><label for="hoten_edit">Tên nhân viên<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="hoten_edit" name="hoten_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="128" /></td>
            </tr>
            <tr>
                <td align=left><label for="ngaysinh_edit">Ngày sinh<font color="red"> </font></label></td>
                <td align=left><input type="text" id="ngaysinh_edit" name="ngaysinh_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="12" /></td>
            </tr>
            <tr>
                <td align=left><label for="gioitinh_edit">Giới tính<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="gioitinh_edit" name="gioitinh_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
            </tr>
            <tr>
                <td align=left><label for="diachi_edit">Địa chỉ<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="diachi_edit" name="diachi_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
            </tr>
            <tr>
                <td align=left><label for="sdt_edit">Số điện thoại<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="sdt_edit" name="sdt_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="11" /></td>
            </tr>
            <tr>
                <td align=left><label for="mapb_edit">Mã phòng ban<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="mapb_edit" name="mapb_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
            </tr>
            <tr>
                <td align=left><label for="macv_edit">Mã chức vụ<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="macv_edit" name="macv_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
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
    $(document).ready(function () {
        $("#manv_search").keypress(function (event) {
            if (event.which == 13) {
                reloadnhanvienList();
            }
        });
        $("#hoten_search").keypress(function (event) {
            if (event.which == 13) {
                reloadnhanvienList();
            }
        });
        $("#gioitinh_search").keypress(function (event) {
            if (event.which == 13) {
                reloadnhanvienList();
            }
        });

        $("#search")
                .button()
                .click(function () {
                    reloadnhanvienList();
                });//end #search 




    });
</script>
