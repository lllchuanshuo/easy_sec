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
</head>

<body>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><spring:message code="label.profile"/></h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-5">
            <form id="profileForm" role="form" class="form-horizontal" action="account/changeProfile.do" method="post">

                <input type="text" name="accountId" value="${currentAccountSecurity.accountId}" hidden>
                <c:if test="${not empty errorMessage || not empty successMessage}">
                    <div class="alert <c:if test="${not empty errorMessage}">alert-danger</c:if> <c:if test="${not empty successMessage}">alert-success</c:if> fade in">
                        <button id='alert1' type="button" class="close" data-dismiss="alert"
                                aria-hidden="true">&times;</button>
                            ${errorMessage}${successMessage}
                    </div>
                </c:if>
                <div class="form-group">
                    <label for="nickname" class="col-sm-2 control-label"><span style="color: red">*</span>
                        <spring:message
                                code="label.nickname"/></label>

                    <div class="col-sm-6">
                        <input type="text" id="nickname" class="form-control" name="nickname"
                               value="${currentAccountSecurity.nickname}">
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"><span style="color: red">*</span> <spring:message
                            code="label.gender"/></label>

                    <div class="col-sm-1">
                        <div class="radio">
                            <label>
                                <input type="radio" name="gender" id="gender1" value="1"
                                       <c:if test="${currentAccountSecurity.gender==1}">checked</c:if>>
                                <spring:message
                                        code="label.male"/>
                            </label>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <div class="radio">
                            <label>
                                <input type="radio" name="gender" id="gender2" value="0"
                                       <c:if test="${currentAccountSecurity.gender==0}">checked</c:if>><spring:message
                                    code="label.female"/>
                            </label>
                        </div>
                    </div>
                    <div class="col-sm-4 control-label gender"></div>
                </div>
                <div class="form-group">
                    <label for="qq" class="col-sm-2 control-label"> <spring:message
                            code="label.qq"/></label>

                    <div class="col-sm-6">
                        <input type="text" id="qq" class="form-control" name="qq"
                               value="${currentAccountSecurity.qq}">
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <label for="telephone" class="col-sm-2 control-label"> <spring:message
                            code="label.telephone"/></label>

                    <div class="col-sm-6">
                        <input type="text" id="telephone" class="form-control" name="telephone"
                               value="${currentAccountSecurity.telephone}">
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <label for="postcode" class="col-sm-2 control-label"> <spring:message
                            code="label.postcode"/></label>

                    <div class="col-sm-6">
                        <input type="text" id="postcode" class="form-control" name="postcode"
                               value="${currentAccountSecurity.postcode}">
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <label for="address" class="col-sm-2 control-label"> <spring:message
                            code="label.address"/></label>

                    <div class="col-sm-6">
                        <input type="text" id="address" class="form-control" name="address"
                               value="${currentAccountSecurity.address}">
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                        <input type="text" id="verifyCode" class="form-control" name="verifyCode">
                    </div>
                    <div class="col-sm-3">
                        <img id="verifyCodeImg" onclick="reloadVerifyCode()" src="common/getVerifyCodeImage.do"/>
                    </div>
                    <div class="col-sm-4 control-label"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-6">
                        <button type="submit" class="btn btn-default btn-lg"><spring:message
                                code="label.change"/></button>
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
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/admin.js"></script>


<script type="text/javascript">
    var reloadVerifyCode = function () {
        document.getElementById("verifyCodeImg").src = "common/getVerifyCodeImage.do";
    }

    $(document).ready(function () {

        $('#settings').toggleClass('active').children('ul').collapse('toggle');

        $("#profileForm").validate({
            rules: {
                nickname: {
                    required: true,
                    minlength: 4,
                    stringCheck: true
                },
                gender: {
                    required: true
                },
                verifyCode: {
                    required: true,
                    remote: "ajax/checkVerifyCode.do"
                }
            },
            messages: {
                nickname: {
                    required: '<spring:message code="message.error.required"/>',
                    minlength: '<spring:message code="message.error.min.length"/>',
                    stringCheck: '<spring:message code="message.error.string.check"/>'
                },
                gender: '<spring:message code="message.error.required"/>',
                verifyCode: {
                    required: '<spring:message code="message.error.required"/>',
                    remote: '<spring:message code="message.error.wrong.verify.code"/>'
                }
            },
            focusInvalid: true,
            onkeyup: false,
            errorClass: "error",
            errorPlacement: function (error, element) {
                if (element.attr("name") == "verifyCode")
                    error.appendTo(element.parent("div").next("div").next("div"));
                else if (element.attr("name") == "gender") {
                    error.appendTo($(".gender"));
                } else
                    error.appendTo(element.parent("div").next("div"));
            },
            highlight: function (element, errorClass) {
                if ($(element).attr("name") == "gender") {
                    $(".gender").parent("div").addClass("has-error").removeClass("has-success");
                } else
                    $(element).parent("div").parent("div").addClass("has-error").removeClass("has-success");
            },
            success: function (label) {
                label.parent("div").parent("div").removeClass("has-error").addClass("has-success");
            },
            submitHandler: function (form) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "account/changeProfile.do",
                    data: $('#profileForm').serialize(),
                    async: false,
                    error: function (request) {
                        alert("Connection error");
                    },
                    success: function (data) {
                        var o = $.toJSON(data);
                        if (o.isSuccess) {
                            alert('<spring:message code="message.change.success"/>');
                        }
                    }
                });
                return false;
            }
        });
    })
</script>
</body>
</html>