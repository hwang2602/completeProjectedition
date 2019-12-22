<%-- 
    Document   : hopdonglaodong
    Created on : Dec 22, 2019, 11:58:34 AM
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
            <font size="5">HỢP ĐỒNG LAO ĐỘNG</font>
            <br /> <br />

            <div id="dialog_search" title="Tìm kiếm" >
                <table width="70%">
                    <tr>
                        <td align=right><label for="mahd_search">Mã hợp đồng</label></td>
                        <td align=left><input type="text" id="mahd_search" name="mahd_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
                        <td align=right><label for="manv_search">Mã nhân viên</label></td>
                        <td align=left><input type="text" id="manv_search" name="manv_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
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
            <table id="hopdonglaodongGrid"></table>
            <div id="Pager1"></div>
            <br />
        </div>
        <%@ include file = "../common/footer.jsp" %>
    </div>
</div>


<script type="text/javascript">

    function reloadhopdonglaodongList()
    {
        var params = "";
        params += "mahd=" + $("#mahd_search").val();
        params += "&manv=" + $("#manv_search").val();
        params += "&loaihd=" + $("#loaihd_search").val();
        jQuery("#hopdonglaodongGrid").setGridParam({url: "<%=request.getContextPath()%>/hopdonglaodong_Servlet?" + params});
        jQuery("#hopdonglaodongGrid").clearGridData();
        jQuery("#hopdonglaodongGrid").trigger("reloadGrid");
    }

    function clear_create()
    {
        $("#mahd_create").val("");
        $("#manv_create").val("");
        $("#loaihd_create").val("");
        $("#tungay_create").val("");
        $("#denngay_create").val("");
        $("#ghichu_create").val("");

    }

    function isValidForm_create() {
        var mahd = trim($("#mahd_create").val());
        var manv = trim($("#manv_create").val());
        var loaihd = trim($("#loaihd_create").val());
        var tungay = trim($("#tungay_create").val());
        var denngay = trim($("#denngay_create").val());
        var ghichu = trim($("#ghichu_create").val());
        if (!((mahd == "") || (manv == "") || (loaihd == "") || (tungay == "") || (denngay == "") || (ghichu == ""))) {
            return true;
        }
    }

    function isValidForm_edit() {
        var mahd = trim($("#mahd_edit").val());
        var manv = trim($("#manv_edit").val());
        var loaihd = trim($("#loaihd_edit").val());
        var tungay = trim($("#tungay_edit").val());
        var denngay = trim($("#denngay_edit").val());
        var ghichu = trim($("#ghichu_edit").val());
        if (!((mahd == "") || (manv == "") || (loaihd == "") || (tungay == "") || (denngay == "") || (ghichu == ""))) {
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

        jQuery("#hopdonglaodongGrid").jqGrid({
            url: '<%=request.getContextPath()%>/hopdonglaodong_Servlet',
            datatype: "xml",
            colNames: ['STT', 'Mã hợp đồng', 'Mã nhân viên', 'Loại hợp đồng', 'Từ ngày', 'Đến ngày', 'Ghi chú'],
            colModel: [
                {name: 'STT', index: 'STT', width: 80, align: "center"},
                {name: 'mahd', index: 'mahd', width: 80},
                {name: 'manv', index: 'manv', width: 80},
                {name: 'loaihd', index: 'loaihd', width: 100},
                {name: 'tungay', index: 'tungay', width: 100},
                {name: 'denngay', index: 'denngay', width: 100},
                {name: 'ghichu', index: 'ghichu', width: 120, align: "right"}
            ],
            rowNum: 15, rowList: [15, 30, 60, 80, 150], pager: '#Pager1',
            scrollrows: true,
            autowidth: false,
            height: 400,
            width: 1000,
            shrinkToFit: false,
            caption: " Danh sách hopdonglaodong",
            sortname: 'mahd', viewrecords: true, sortorder: "desc"

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
                                            url: "<%=request.getContextPath()%>/hopdonglaodong_Servlet",
                                            data: {"xml": "<doc><method>create</method><mahd>" + $("#mahd_create").val() + "</mahd><manv>" + $("#manv_create").val() + "</manv><loaihd>" + $("#loaihd_create").val() + "</loaihd><tungay>" + $("#tungay_create").val() + "</tungay><denngay>" + $("#denngay_create").val() + "</denngay><ghichu>" + $("#ghichu_create").val() + "</ghichu></doc>"},
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
                                                    jQuery("#hopdonglaodongGrid").trigger("reloadGrid");
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
                                            url: "<%=request.getContextPath()%>/hopdonglaodong_Servlet",
                                            data: {"xml": "<doc><method>update</method><mahd>" + $("#mahd_edit").val() + "</mahd><manv>" + $("#manv_edit").val() + "</manv><loaihd>" + $("#loaihd_edit").val() + "</loaihd><tungay>" + $("#tungay_edit").val() + "</tungay><denngay>" + $("#denngay_edit").val() + "</denngay><ghichu>" + $("#ghichu_edit").val() + "</ghichu></doc>"},
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
                                                    jQuery("#hopdonglaodongGrid").trigger("reloadGrid");
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
                    var id = jQuery("#hopdonglaodongGrid").jqGrid('getGridParam', 'selrow');
                    if (id) {
                        var ret = jQuery("#hopdonglaodongGrid").jqGrid('getRowData', id);
                        $("#mahd_edit").val(ret.mahd);
                        $("#manv_edit").val(ret.manv);
                        $("#loaihd_edit").val(ret.loaihd);
                        $("#tungay_edit").val(ret.tungay);
                        $("#denngay_edit").val(ret.denngay);
                        $("#ghichu_edit").val(ret.ghichu);
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
                    var id1 = jQuery("#hopdonglaodongGrid").jqGrid('getGridParam', 'selrow');
                    if (id1) {
                        var ret = jQuery("#hopdonglaodongGrid").jqGrid('getRowData', id1);
                        $("#dialog_confirm_delete").dialog({
                            resizable: false,
                            height: 140,
                            modal: true,
                            buttons: {
                                "Xóa": function () {
                                    blockflag = true;
                                    $.ajax({
                                        type: "POST",
                                        url: "<%=request.getContextPath()%>/hopdonglaodong_Servlet",
                                        data: {"xml": "<doc><method>delete</method><mahd>" + ret.mahd + "</mahd><manv>" + $("#manv_edit").val() + "</manv><loaihd>" + $("#loaihd_edit").val() + "</loaihd><tungay>" + $("#tungay_edit").val() + "</tungay><denngay>" + $("#denngay_edit").val() + "</denngay><ghichu>" + $("#ghichu_edit").val() + "</ghichu></doc>"},
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
                                                jQuery("#hopdonglaodongGrid").trigger("reloadGrid");
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
                <td align=left><label for="mahd_create">Mã hợp đồng<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="mahd_create" name="mahd_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
            </tr>
            <tr>
                <td align=left><label for="manv_create">Mã nhân viên<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="manv_create" name="manv_create" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
            </tr>
            <tr>
                <td align=left><label for="loaihd_create">Loại hợp đồng<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="loaihd_create" name="loaihd_create" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
            </tr>
            <tr>
                <td align=left><label for="tungay_create">Từ ngày<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="tungay_create" name="tungay_create" value="" class="text ui-widget-content ui-corner-all" maxlength="28" /></td>
            </tr>
            <tr>
                <td align=left><label for="denngay_create">Đến ngày<font color="red"> (*)</font></label></td>
                <td align=left><input type="text" id="denngay_create" name="denngay_create" value="" class="text ui-widget-content ui-corner-all" maxlength="28" /></td>
            </tr>
            <tr>
                <td align=left><label for="ghichu_create">Ghi chú<font color="red"> </font></label></td>
                <td align=left><input type="text" id="ghichu_create" name="ghichu_create" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
            </tr>
        </table>
    </form>
</div>
<br />


<div id="dialog_form_edit" style="display: none" title="Sửa">
    <form>
        <table width="100%">
            <tr>
                <td align=left><label for="mahd_edit">Mã hợp đồng<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="mahd_edit" name="mahd_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
            </tr>
            <tr>
                <td align=left><label for="manv_edit">Mã nhân viên<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="manv_edit" name="manv_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="20" /></td>
            </tr>
            <tr>
                <td align=left><label for="loaihd_edit">Loại hợp đồng<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="loaihd_edit" name="loaihd_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
            </tr>
             <tr>
                <td align=left><label for="tungay_edit">Từ ngày<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="tungay_edit" name="tungay_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="28" /></td>
            </tr>
            <tr>
                <td align=left><label for="denngay_edit">Đến ngày<font color="red">(*)</font></label></td>
                <td align=left><input type="text" id="denngay_edit" name="denngay_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="28" /></td>
            </tr>
            <tr>
                <td align=left><label for="ghichu_edit">Ghi chú<font color="red"></font></label></td>
                <td align=left><input type="text" id="denngay_edit" name="denngay_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="255" /></td>
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
    $(document).ready(function () {
        $("#mahd_search").keypress(function (event) {
            if (event.which == 13) {
                reloadhopdonglaodongList();
            }
        });
        $("#manv_search").keypress(function (event) {
            if (event.which == 13) {
                reloadhopdonglaodongList();
            }
        });

        $("#search")
                .button()
                .click(function () {
                    reloadhopdonglaodongList();
                });//end #search 




    });
</script>
