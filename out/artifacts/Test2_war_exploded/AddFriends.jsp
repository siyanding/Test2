<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/13/2017
  Time: 1:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AddFriends</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <style type="text/css">
        .text-button
        {
            background-color: Transparent;
            cursor: pointer;
            border:0;
            text-align: center;

        }
        .text-button:hover
        {
            text-decoration:none;
            background-color: rgb(245,245,245);
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
%>
<%

    token = (String) session.getAttribute("csrftoken");
    System.out.println("AddFriends:" + token);
    System.out.println("AddFriendsToken:" + (String)request.getParameter("csrftoken"));
%>
<%
    String name=(String)session.getAttribute("username");
    if(name != null){%>
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
    <table class="table table-striped" style="width: 1100px">
        <tr>
            <th>Portrait</th>
            <th>Username</th>
            <th></th>
        </tr>
        <tr>
            <td><img src="img/p1.jpg" alt="p1"></td>
            <td>test1</td>
            <td>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default">Add Friend</button>
                </div>
            </td>
        </tr>
        <tr>
            <td><img src="img/p2.jpg" alt="p2"></td>
            <td>test2</td>
            <td>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default">Add Friend</button>
                </div>
            </td>
        </tr>
        <tr>
            <td><img src="img/p3.png" alt="p3"></td>
            <td>test3</td>
            <td>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default">Add Friend</button>
                </div>
            </td>
        </tr>
        <tr>
            <td><img src="img/p4.png" alt="p4"></td>
            <td>test4</td>
            <td>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default">Add Friend</button>
                </div>
            </td>
        </tr>
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

<footer class="footer" >
    <div class="container col-md-offset-5" >
        <p class="text-muted">@Copyright</p>
    </div>
</footer>
<%}else{ %>
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
            b.innerHTML="Please sign in first! After" + time + "s go to sign in page";
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
