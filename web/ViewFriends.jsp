<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/13/2017
  Time: 1:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>ViewFriends</title>
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
<% String name=(String)request.getParameter("username");
    String sessionToken = request.getParameter("sessionToken");
    String userObjectId = request.getParameter("userObjectId");%>
<script language="javascript">

    window.onload=function(){
        getFriends();
    }
    function getFriends() {
        $.ajax({
            type: "GET",
            beforeSend: function(request) {
                request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
                request.setRequestHeader("Content-Type", "application/json");
            },
            url: "https://api2.bmob.cn/1/classes/Friend?where={\"user\":\"<%=name%>\"}",
            success: function(msg) {
                $.ajax({
                    type: "GET",
                    beforeSend: function(request) {
                        request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                        request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
                        request.setRequestHeader("Content-Type", "application/json");
                    },
                    url: "https://api2.bmob.cn/1/users",
                    success: function(data) {
                        console.log(data);
                        for(var i=0; i<data.results.length; i++){
                            for (var j=0; j<msg.results.length; j++) {
                                if(data.results[i].username == msg.results[j].friend){
                                    var portrait = data.results[i].portrait == null ? "img/p2.jpg" : data.results[i].portrait;

                                    var temp = msg.results[j].friend;
                                    console.log(portrait);
                                    var row = '<tr><td><img src='+ portrait +' alt="../img/p1.jpg" width="50" height="50"></td>' +
                                        '<td id=' + data.results[i].objectId +'>' +  data.results[i].username + '</td>' +
                                        '<td><div class="btn-group" role="group" aria-label=""><button type="button" class="btn btn-default" onclick="deleteFriend(this)" id="'+ temp +'">Delete</button></div></td></tr>';
                                    $("#table tbody").append(row);
                                }
                            }
                        }
                    },
                    error: function (err) {
                        console.log(err)
                        alert(err.responseJSON.error)
                    }
                });
                console.log(msg);
            },
            error: function (err) {
                console.log(err)
                alert(err.responseJSON.error)
            }
        });
    }

    function deleteFriend(data){
        var friend = data.id;
        $.ajax({
            type: "GET",
            beforeSend: function(request) {
                request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
                request.setRequestHeader("Content-Type", "application/json");
            },
            url: "https://api2.bmob.cn/1/classes/Friend?where={\"user\":\"<%=name%>\"}",
            success: function(msg) {
                console.log(msg);
                for(var i=0; i<msg.results.length; i++){
                  if (msg.results[i].friend.trim() == friend) {
                      console.log(msg.results[i].objectId);
                      $.ajax({
                          type: "DELETE",
                          beforeSend: function(request) {
                              request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                              request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
                              request.setRequestHeader("Content-Type", "application/json");
                          },
                          url: "https://api2.bmob.cn/1/classes/Friend/" + msg.results[i].objectId,
                          success: function(msg) {
                              alert("delete success");
                              location.reload();

                          },
                          error: function (err) {
                              console.log(err)
                              alert(err.responseJSON.error)
                          }
                      });
                  }
                }
            },
            error: function (err) {
                console.log(err)
                alert(err.responseJSON.error)
            }
        });
    }

    function searchFriends() {
        $.ajax({
            type: "GET",
            beforeSend: function(request) {
                request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
                request.setRequestHeader("Content-Type", "application/json");
            },
            url: "https://api2.bmob.cn/1/classes/Friend?where={\"user\":\"<%=name%>\"}",
            success: function(msg) {
                console.log(msg);
                console.log("search success!");
                $("#table  tr:not(:first)").empty("");
                console.log("empty success!");
                $.ajax({
                    type: "GET",
                    beforeSend: function(request) {
                        request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                        request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
                        request.setRequestHeader("Content-Type", "application/json");
                    },
                    url: "https://api2.bmob.cn/1/users",
                    success: function(data) {
                        console.log(data);
                        for(var i=0; i<msg.results.length; i++){
                            for (var j=0; j<data.results.length; j++) {
                                if (msg.results[i].friend.includes($("#search").val()) && data.results[j].username == msg.results[i].friend) {
                                    console.log("find a row");
                                    var portrait = data.results[i].portrait == null ? "img/p2.jpg" : data.results[i].portrait;
                                    var row = '<tr><td><img src="'+ portrait +'" alt="img/p2.jpg" width="50" height="50"></td>' +
                                        '<td id="username">'+ msg.results[i].friend + '</td>' +
                                        '<td><div class="btn-group" role="group" aria-label="...">' +
                                        '<button type="button" class="btn btn-default" onclick="deleteFriend()" id="delete">Delete</button></div></td></tr>';
                                    $("#table tbody").append(row);
                                }
                            }
                        }
                    }
                });
            }
        });
    }
</script>

<%!
    String token = "";
%>
<%
    token = (String) session.getAttribute("csrftoken");
    System.out.println("ViewGifts:" + token);
    System.out.println("ViewGiftsToken:" + (String)request.getParameter("csrftoken"));
%>


<%    if(name!=null){%>
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
                <li class="dropdown ">

                    <a id="drop0" href="ViewGifts.html" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        MyAccount
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop0">
                        <li>
                            <form action="EditProfile.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="hidden" name="username" value="<%=name%>">
                                <input type="hidden" name="sessionToken" value="<%=sessionToken%>">
                                <input type="hidden" name="userObjectId" value="<%=userObjectId%>">
                                <input type="submit" value="Edit Profile" class="text-button" >
                            </form>
                        </li>
                        <li>
                            <form action="SignOut.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="hidden" name="username" value="<%=name%>">
                                <input type="hidden" name="sessionToken" value="<%=sessionToken%>">
                                <input type="hidden" name="userObjectId" value="<%=userObjectId%>">
                                <input type="submit" value="Sign Out" class="text-button" >
                            </form>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a id="drop1" href="ViewAccount.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Gifts
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <li>
                            <form action="ViewGifts.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="hidden" name="username" value="<%=name%>">
                                <input type="hidden" name="sessionToken" value="<%=sessionToken%>">
                                <input type="hidden" name="userObjectId" value="<%=userObjectId%>">
                                <input type="submit" value="View Gifts" class="text-button" >
                            </form>
                        </li>
                    </ul>
                </li>

                <li class="dropdown active">
                    <a id="drop2" href="ViewAccount.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Friends
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <li>
                            <form action="ViewFriends.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="hidden" name="username" value="<%=name%>">
                                <input type="hidden" name="sessionToken" value="<%=sessionToken%>">
                                <input type="hidden" name="userObjectId" value="<%=userObjectId%>">
                                <input type="submit" value="View Friends" class="text-button" >
                            </form>
                        </li>
                        <li>
                            <form action="AddFriends.jsp" method="post">
                                <input type="hidden" name="csrftoken" value="<%=token%>">
                                <input type="hidden" name="username" value="<%=name%>">
                                <input type="hidden" name="sessionToken" value="<%=sessionToken%>">
                                <input type="hidden" name="userObjectId" value="<%=userObjectId%>">
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
            <input type="text" class="form-control" placeholder="Search for..." id="search">
            <span class="input-group-btn">
        <button class="btn btn-default" type="button" onclick="searchFriends()">Go!</button>
      </span>
        </div><!-- /input-group -->
    </div><!-- /.col-lg-6 -->
</div>

<div class="container" style="padding-top: 5em">
    <table id="table" class="table table-striped">
        <tr>
            <th>Portrait</th>
            <th>Username</th>
            <th></th>
        </tr>
    </table>
</div>

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
