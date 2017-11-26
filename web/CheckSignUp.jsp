<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/8/2017
  Time: 11:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.sql.*" import="encrypt.com.BCrypt" contentType="text/html;charset=utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>检验注册页面</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

</head>

<body>
<%
    request.setCharacterEncoding("utf-8");
    String users = request.getParameter("username");
    String pass = BCrypt.hashpw(request.getParameter("pwd"),BCrypt.gensalt());
    String email = request.getParameter("email");
    PreparedStatement sql = null;
    ResultSet rs = null;
    int usernameCount;
    int emailCount;
%>
<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/gift";
    String use = "root";
    String password = "123456";
    Class.forName(driver);
    Connection conn= DriverManager.getConnection(url,use,password);


    sql =conn.prepareStatement("select * from user where username=?");
    sql.setString(1,users);
    rs=sql.executeQuery();
    usernameCount = 0;
    while(rs.next()){
        usernameCount++;
    }
    sql =conn.prepareStatement("select * from user where email=?");
    sql.setString(1,email);
    rs=sql.executeQuery();
    emailCount = 0;
    while(rs.next()){
        emailCount++;
    }
    if (usernameCount > 0) {%>
    <script>
        {alert("Username has been taken");
            window.location.href="SignUp.jsp";
        }</script>
<%  }else if(emailCount > 0) {%>
    <script>
    {alert("This email already associated with an account");
        window.location.href="SignUp.jsp";
    }</script>
 <% }
    else{
         sql =conn.prepareStatement("insert into user(username,password,email)values(?,?,?)");
         sql.setString(1,users);
         sql.setString(2,pass);
         sql.setString(3,email);
         int rtn = sql.executeUpdate();
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
        <div id="navbar" class="collapse navbar-collapse pull-right">


        </div><!--/.nav-collapse -->
    </div>
</nav>
<div class="container col-md-offset-5" id="timer" style="padding-top: 20em"></div>

<script>
    //5秒跳转页面
    var b=document.getElementById("timer");
    b.innerHTML="Sign up success! go to homepage after 5s";
    var time=5;
    //每隔一秒执行定时器
    var timer=setInterval(function(){
        if(time>0){
            time--;
            b.innerHTML="After" + time + "s go to homepage";
        }else{//终止定时器
            //alert("跳转页面");
            //open("http://www.baidu.com");
            window.location.href="ViewGifts.jsp";
            timer.clearInterval();
        }
    },1000);
</script>
<% }

    sql.close();
    conn.close();
%>


</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
