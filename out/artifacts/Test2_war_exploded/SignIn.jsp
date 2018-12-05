<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/8/2017
  Time: 11:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html;charset=utf-8"%>
<%@ page import="javax.mail.Session" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>

    <base href="<%=basePath%>">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <meta charset="UTF-8">
    <title>SignIn</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">


</head>
<body>

<%!
    String token = "";
%>
<%
    token = (String) session.getAttribute("csrftoken");
    System.out.println("SignIn:" + token);
%>


<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Gift Box</a>
        </div>
    </div>
</nav>


<form class="form-horizontal col-md-6 col-md-offset-3" style="padding-top: 10em" action="CheckSignIn.jsp" method="post" onsubmit="return isValid(this)">
    <div class="form-group">
        <label for="username" class="col-sm-2 control-label">Username</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="username" placeholder="Username" name="username">
        </div>
    </div>
    <div class="form-group">
        <label for="password" class="col-sm-2 control-label">Password</label>
        <div class="col-sm-10">
            <input type="password" class="form-control" id="password" placeholder="Password" name="password">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-default">Sign in</button>
        </div>
    </div>
    <div class="col-sm-offset-4 col-sm-10">
        <div>Don't have an account?<u><a href="SignUp.jsp">Sign up</a></u></div>
    </div>
</form>

    <footer class="footer" >
        <div class="container col-md-offset-5" style="padding-top: 50em">
            <p class="text-muted">@Copyright</p>
        </div>
    </footer>
<script language="javascript">
    var Bmob = require('Bmob-x.x.x.min.js');
    Bmob.initialize("b2ab2a965d7a4ea905eeba56d4a2fa4d", "68f8f8b68a20fc68f92fd378b3aa6ddd");
    function isValid(form)
    {

        if (form.username.value=="")
        {
            alert("Username can not be null");
            return false;
        }
        if (form.pwd.value=="")
        {
            alert("Password can not be null！");
            return false;
        }
        Bmob.User.login('username','password').then(res => {
            console.log(res)
        }).catch(err => {
            console.log(err)
        });
        return false;
    }
</script>

</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>

