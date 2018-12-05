<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/9/2017
  Time: 9:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.sql.*" import="encrypt.com.BCrypt" import="java.util.UUID" contentType="text/html;charset=utf-8"%>
<%@ page import="DBUtil.Gifts" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>ViewGifts</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <style type="text/css">
        .text-button
        {
            background-color: transparent;
            cursor: pointer;
            border:0;
            text-align: center;

        }
        .text-button:hover
        {
            text-decoration:none;
            background-color: rgb(245,245,245);
            text-align:center;
        }
        form{
             margin:0;
            padding:3px;
            text-align:center;
        }
    </style>
</head>
<body>

<%!
    String token = "";
    String name="";
    List<Gifts> res;
%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    request.setAttribute("basePath", basePath);
%>
<%
    name = (String)session.getAttribute("username");
    token = (String) session.getAttribute("csrftoken");
    System.out.println("ViewGifts:" + token);
    System.out.println("ViewGiftsToken:" + (String)request.getParameter("csrftoken"));
%>



<%
    request.setCharacterEncoding("utf-8");
    PreparedStatement sql = null;
    ResultSet rs = null;
    Connection conn = null;
%>

<%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/gift";
    String use = "root";
    String password = "123456";
    Class.forName(driver);
    conn= DriverManager.getConnection(url,use,password);
    sql =conn.prepareStatement("select * from gifts where user=?");
    sql.setString(1,name);
    rs=sql.executeQuery();
%>

<%
    res = new ArrayList<Gifts>();
    while (rs.next()) {
        // Retrieve by column name
        Gifts g = new Gifts();
        g.setId(rs.getInt("id"));
        g.setBackground(rs.getString("background"));
        g.setUser(rs.getString("user"));
        g.setAttachment(rs.getString("attachment"));
        g.setCoordinate(rs.getString("coordinate"));
        g.setComment(rs.getString("comment"));
        res.add(g);
    }
    rs.close();
    sql.close();
    conn.close();
%>






<%
    if(name!=null){%>
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
                <li class="dropdown">

                    <a id="drop0" href="ViewGifts.html" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        MyAccount
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop0">
                        <li>
                            <form action="EditProfile.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="submit" value="Edit Profile" class="text-button" >
                            </form>
                        </li>
                        <li>
                            <form action="SignOut.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="submit" value="Sign Out" class="text-button" >
                            </form>
                        </li>
                    </ul>
                </li>
                <li class="dropdown active">
                    <a id="drop1" href="ViewAccount.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Gifts
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <li>
                            <form action="ViewGifts.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="submit" value="View Gifts" class="text-button" >
                            </form>
                        </li>
                        <li>
                            <form action="CreateGifts.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="submit" value="Create Gifts" class="text-button" >
                            </form>
                        </li>
                    </ul>
                </li>

                <li class="dropdown">
                    <a id="drop2" href="ViewAccount.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Friends
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <li>
                            <form action="ViewFriends.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="submit" value="View Friends" class="text-button" >
                            </form>
                        </li>
                        <li>
                            <form action="AddFriends.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="submit" value="Add Friends" class="text-button" >
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>

<div style="padding-top: 7em">
    <div class="col-lg-6 col-md-offset-2">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Search for...">
            <span class="input-group-btn">
        <button class="btn btn-default" type="button">Go!</button>
      </span>
        </div><!-- /input-group -->
    </div><!-- /.col-lg-6 -->

</div>

<div class="container" style="padding-top: 5em">
    <table class="table table-striped">
        <tr>
            <th>Picture</th>
            <th>Name</th>
            <th></th>
            <th></th>
        </tr>
        <%
            for (int i=0;i<res.size();i++){
        %>
        <tr>
            <td><img src= "${basePath}/img/<%=res.get(i).getBackground()%>" alt="gift" width="50" height="50"></td>
            <td><%=res.get(i).getComment()%></td>
            <td>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default">Edit</button>
                </div>
            </td>
            <td>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default">Delete</button>
                </div>
            </td>
        </tr>
        <%
            }

        %>
    </table>

</div>

<nav aria-label="Page navigation" class="col-md-offset-5">
    <ul class="pagination col-md-offset-6">
        <li>
            <a href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
        <li class="active"><a href="#">1</a></li>
        <li><a href="#">2</a></li>

        <li>
            <a href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>

<footer class="footer">
    <div class="container col-md-offset-5" >
        <p class="text-muted">@Copyright</p>
    </div>
</footer>
<%}else{%>

<div class="container col-md-offset-5" id="timer" style="padding-top: 20em"></div>

<script>
    //5秒跳转页面
    var b=document.getElementById("timer");
    b.innerHTML="Please sign in first! go to sign in page after 3s";
    var time=3;
    //每隔一秒执行定时器
    var timer=setInterval(function(){
        if(time>0){
            time--;
            b.innerHTML="Please sign in first! After" + time + "s go to  sign in page";
        }else{//终止定时器
            //alert("跳转页面");
            //open("http://www.baidu.com");
            window.location.href="SignIn.jsp";
            timer.clearInterval();
        }
    },1000);
</script>

<%} %>

</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
