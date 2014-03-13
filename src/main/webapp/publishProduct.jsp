<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href=" <%=basePath%>">
<html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title><spring:message code="label.profile"/></title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link href="css/admin.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><spring:message code="label.publish.product"/></h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-5">
            <form id="productForm" role="form" class="form-horizontal" enctype="multipart/form-data" method="post"
                  action="product/publishProduct.do">

                <input type="text" name="accountId" hidden>
                <c:if test="${not empty message}">
                    <div class="form-group alert
                        <c:if test="${!message.success}">alert-danger</c:if>
                        <c:if test="${message.success}">alert-success</c:if>
                         fade in">
                        <button id='alert1' type="button" class="close" data-dismiss="alert"
                                aria-hidden="true">&times;</button>
                            ${message.message}
                    </div>
                </c:if>
                <div class="form-group">
                    <label for="category" class="col-sm-2 control-label"><span style="color: red">*</span>
                        <spring:message
                                code="label.category"/></label>

                    <div class="col-sm-6">
                        <select id="category" class="form-control" name="category">
                            <option><spring:message code="label.please.select"/></option>
                        </select>
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label"><span style="color: red">*</span> <spring:message
                            code="label.product.name"/></label>

                    <div class="col-sm-6">
                        <input type="text" id="name" class="form-control" name="name">
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <label for="image" class="col-sm-2 control-label"><span style="color: red">*</span> <spring:message
                            code="label.image"/></label>

                    <div class="col-sm-6">
                        <input type="file" id="image" class="form-control" name="image">
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <label for="description" class="col-sm-2 control-label"><span style="color: red">*</span>
                        <spring:message
                                code="label.description"/></label>

                    <div class="col-sm-6">
                        <textarea id="description" name="description" rows="6" class="form-control"/></textarea>
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-6">
                        <button type="submit" class="btn btn-success btn-block"><spring:message
                                code="label.publish"/></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- /container -->
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/jquery.validate.method.js"></script>
<script src="js/jquery.metisMenu.js"></script>
<script src="js/admin.js"></script>


<script type="text/javascript">

    $(document).ready(function () {
        $('#product').toggleClass('active').children('ul').collapse('toggle');
        $('#publishProduct').css({"background": "#DDDDDD"});

        $.ajax({
            cache: true,
            type: "POST",
            dataType: 'json',
            url: "product/ajax/getTopLevelCategory.do",
            error: function (request) {
                alert("Connection error");
            },
            success: function (data) {
                if (data == 'true') {
                    alert('<spring:message code="message.subscribe.success"/>');
                    $("#subscribeForm input[type=email]").val('');
                } else {
                    var obj = $.parseJSON(data);
                    if (obj.error == 'Already') {
                        alert('<spring:message code="message.already.subscribed"/>');
                    }
                    $("#subscribeForm input[type=email]").val('');
                }
            }
        });

        $('#category').on('change', function () {

            var value = $(this).children('option:selected').val();

            for (var i = 0; i < lists.length; i++) {
                if (lists[i] == id) {
                    var index = i;
                }
            }
            //取得相邻下拉框id在lists中的索引
            //var nextIndex = index + 1;
            if (index + 1 < lists.length) {
                var nextIndex = index + 1;
            }
            //移除相邻下拉框级后续下拉框的值
            remove(nextIndex);
            getList(nextIndex, value);
        })
        //通过Ajax方式为下拉框加载数据
        function getList(index, value) {
            Ext.Ajax.request({
                url: 'bookServer.php',
                params: {
                    target: lists[index],
                    value: value
                },
                callback: function (options, success, response) {
                    if (success) {
                        //取得下拉框的值
                        var select = Ext.get(lists[index]);
                        //执行返回字符串，取的数组对象
                        var array = eval(response.responseText);
                        var firstValue;
                        for (var i = 0; i < array.length; i++) {
                            var o = array[i];
                            if (i == 0) {
                                firstValue = o.value
                            }
                            //想下拉框中追加条目
                            select.appendChild(createOption(o.value, o.name));
                        }
                        //如果不是最后一个下拉框则继续加载相邻下拉框的数据
                        if (++index < lists.length) {
                            getList(index, firstValue);
                        }
                    }
                }
            })
        }

        //根据传入的value和text创建选项
        function createOption(value, text) {
            var opt = document.createElement('option');
            opt.setAttribute('value', value);
            opt.appendChild(document.createTextNode(text));
            return opt;
        }

        //级联删除下拉框及子下拉框的值
        function remove(index) {
            for (var i = index; i < lists.length; i++) {
                var select = Ext.get(lists[i]).dom;
                while (select.length > 0) {
                    select.options.remove(select.length - 1)
                }
            }
        }


        $("#productForm").validate({
            rules: {
                category: "required",
                name: "required",
                image: "required",
                description: "required"
            },
            messages: {
                category: '<spring:message code="message.error.required"/>',
                name: '<spring:message code="message.error.required"/>',
                image: '<spring:message code="message.error.required"/>',
                description: '<spring:message code="message.error.required"/>'
            },
            focusInvalid: true,
            onkeyup: false,
            errorClass: "error",
            errorPlacement: function (error, element) {
                error.appendTo(element.parent("div").next("div"));
            },
            highlight: function (element, errorClass) {
                if ($(element).attr("name") == "category") {
                    $("#category").parent("div").parent("div").addClass("has-error").removeClass("has-success");
                } else
                    $(element).parent("div").parent("div").addClass("has-error").removeClass("has-success");
            },
            success: function (label) {
                label.parent("div").parent("div").removeClass("has-error").addClass("has-success");
            },
            submitHandler: function (form) {
                form.submit();
                return false;
            }
        });
        setCheckSession();
    })
</script>
</body>
</html>