<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/8/2017
  Time: 11:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.sql.*" import="encrypt.com.BCrypt" import="java.util.UUID" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.UUID" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>My JSP 'check.jsp' starting page</title>
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

<%!
    String token = "";
%>
<%
    token = (String) session.getAttribute("csrftoken");
    System.out.println("CheckSignIn:" + token);
    System.out.println("CheckSignInToken:" + (String)request.getParameter("csrftoken"));
%>

<%
    //BCrypt.checkpw(candidate, hashed)
    request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String pass = request.getParameter("password");
    String pToken = request.getParameter("csrftoken");
    boolean flag = false;
    PreparedStatement sql = null;
    ResultSet rs = null;
    Connection conn = null;
    String DBpass;
%>

<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/gift";
    String use = "root";
    String password = "123456";
    Class.forName(driver);
    conn= DriverManager.getConnection(url,use,password);
    sql =conn.prepareStatement("select * from user where username=?");
    sql.setString(1,username);
    rs=sql.executeQuery();
%>

<%
    if (rs.next()) {
        DBpass = rs.getString("password");
        if(BCrypt.checkpw(pass, DBpass)){

            flag=true;
        }

    }
    rs.close();
    sql.close();
    conn.close();
%>
<!-- 判断是否是正确的登录用户 -->
<%
    if (flag==true){
        session.setAttribute("username",username);
%>
<jsp:forward page="ViewGifts.jsp"></jsp:forward>

<%}
    else{
%>
<script>
    {alert("Username or password wrong");
        window.location.href="SignIn.jsp";
    }</script>
<%} %>

</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
