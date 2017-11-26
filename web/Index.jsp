<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/8/2017
  Time: 10:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Index</title>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">


  </head>
  <body>
  <%!
    String token = "";
  %>
  <%
    token = (String) session.getAttribute("csrftoken");
    System.out.println("Index:" + token);
    System.out.println("IndexToken:" + (String)request.getParameter("csrftoken"));
  %>

  <form action="ViewGifts.jsp" method="post" ></form>
  <!-- Navigation -->
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
        <ul class="nav navbar-nav">

          <li><a href="SignIn.jsp">Sign In/Sign Up</a></li>

        </ul>
      </div><!--/.nav-collapse -->
    </div>
  </nav>

  <div class="col-md-offset-3" style="padding-top: 10em">
    <img src="img/giftbox.gif" alt="giftbox">

  </div>

  <footer class="footer" style="padding-top: 10em">
    <div class="container col-md-offset-6" >
      <p class="text-muted">@Copyright</p>
    </div>
  </footer>
  </body>
  <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
