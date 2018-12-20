
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>EditProfile</title>
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
<%String name= request.getParameter("username");
   String sessionToken = request.getParameter("sessionToken");
   System.out.println("sessionToken:" + sessionToken);
   String userObjectId = request.getParameter("userObjectId");
    System.out.println("objectId:" + userObjectId);
%>

<script language="javascript">
    window.onload=function(){
        getUser();
    }
    function getUser() {
        $.ajax({
            type: "GET",
            beforeSend: function(request) {
                request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
            },
            url: "https://api2.bmob.cn/1/users/<%=userObjectId%>",
            success: function(msg) {
                console.log("json" + msg.username);
                document.getElementById("inputPassword3").value=msg.password;
                document.getElementById("inputRepeatPassword3").value=msg.password;
                console.log(msg);
                console.log("success");
            }
        });
    }
    function updateProfile() {
        if ($("#inputUsername3").val() == ""){
            alert("Username can not be null!");
        }
        if ($("#inputPassword3").val() != $("#inputRepeatPassword3").val()){
            alert("The two password don't match！");
        }
        if ($("#inputRepeatPassword3").val() == ""){
            alert("Repeat password can not be null！");
        }
        if ($("#inputEmail3").val() == ""){
            alert("Email can not be null！");
        }
        var da = {
            password: document.getElementById("inputPassword3").value,
           };
        $.ajax({
            type: "PUT",
            beforeSend: function(request) {
                request.setRequestHeader("X-Bmob-Application-Id", "b2ab2a965d7a4ea905eeba56d4a2fa4d");
                request.setRequestHeader("X-Bmob-REST-API-Key", "68f8f8b68a20fc68f92fd378b3aa6ddd");
                request.setRequestHeader("Content-Type", "application/json");
                request.setRequestHeader("X-Bmob-Session-Token", "<%=sessionToken%>");
            },
            url: "https://api2.bmob.cn/1/users/<%=userObjectId%>",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(da),
            dataType: "json",
            success: function(msg) {
                alert("Profile has been updated！");
                console.log(msg);
                console.log('<%=name%>');
            },
            error: function (err) {
                console.log(err)
                alert(err.responseJSON.error)
            }
        });
    }

</script>
<%
    if(name!=null){
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
            <ul class="nav navbar-nav">
                <li class="dropdown active">

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

                <li class="dropdown">
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
        </div>
    </div>
</nav>

<form class="form-horizontal container col-md-6 col-md-offset-3" style="padding-top: 11em">
    <div class="form-group">
        <label for="inputPassword3" class="col-sm-2 control-label">Edit Profile</label>
    </div>
    <%--<div class="form-group">--%>
        <%--<label for="inputUsername3" class="col-sm-2 control-label">username</label>--%>
        <%--<div class="col-sm-10">--%>
            <%--<input type="text" class="form-control" id="inputUsername3" placeholder="Username">--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div class="form-group">--%>
        <%--<label for="inputEmail3" class="col-sm-2 control-label">Email</label>--%>
        <%--<div class="col-sm-10">--%>
            <%--<input type="email" class="form-control" id="inputEmail3" placeholder="Email">--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="form-group">
        <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
        <div class="col-sm-10">
            <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
        </div>
    </div>
    <div class="form-group">
        <label for="inputRepeatPassword3" class="col-sm-2 control-label">Repeat Password</label>
        <div class="col-sm-10">
            <input type="password" class="form-control" id="inputRepeatPassword3" placeholder="Password">
        </div>
    </div>
</form>

<div class="col-sm-offset-6 col-sm-4">
    <button type="submit" class="btn btn-default" onclick="updateProfile()">Save</button>
</div>

<footer class="footer" style="padding-top: 50em">
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
