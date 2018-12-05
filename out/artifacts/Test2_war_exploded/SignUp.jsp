<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/8/2017
  Time: 11:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html;charset=utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <base href="<%=basePath%>">

    <meta charset="UTF-8">
    <title>SignUp</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <script language="javascript">
        function isValid(form)
        {
            if (form.username.value=="")
            {
                alert("Username can not be null");
                return false;
            }
            if (form.pwd.value!=form.pwd2.value)
            {
                alert("The two password don't match！");
                return false;
            }
            else  if (form.pwd.value=="")
            {
                alert("Password can not be null！");
                return false;
            }
            else return true;
        }
    </script>
</head>

<body>

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

    <form class="form-horizontal container col-md-6 col-md-offset-3" style="padding-top: 10em" action="CheckSignUp.jsp" method="post" onSubmit="return isValid(this);">
        <div class="form-group">
            <label class="col-sm-2 control-label">Sign up</label>
        </div>
        <div class="form-group">
            <label for="Username" class="col-sm-2 control-label" >username</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="Username" placeholder="Username" name="username">
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail" class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" id="inputEmail" placeholder="Email" name="email">
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword" class="col-sm-2 control-label">Password</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputPassword" placeholder="Password" name="pwd">
            </div>
        </div>
        <div class="form-group">
            <label for="inputRepeatPassword" class="col-sm-2 control-label">Repeat Password</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="inputRepeatPassword" placeholder="Repeat Password" name="pwd2">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">Portrait:</label>
            <div class="col-sm-10">
                <img  src="img/portrait1.jpg" alt="portrait" >
            </div>
        </div>


        <ul class="list-inline col-md-offset-5">
            <li><div class="col-sm-offset-2 col-sm-10">
                <input type="submit" class="btn btn-default" value="Sign Up"/>
            </div></li>
        </ul>
        <div class="col-sm-offset-4 col-sm-10">
            <div>Already have an account?<u><a href="SignIn.jsp">Sign in</a></u></div>
        </div>


    </form>

    <footer class="footer" >
        <div class="container col-md-offset-5" style="padding-top: 60em">
            <p class="text-muted">@Copyright</p>
        </div>
    </footer>

</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
