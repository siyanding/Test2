<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/13/2017
  Time: 12:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>CreateGifts</title>
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
    Boolean uploadResult = false;
    String filePath;
    String fileName = null;
    Boolean ImgCenter;

%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"//";
    request.setAttribute("basePath", basePath);
%>
<%

    if (request.getSession().getAttribute("uploadResult") != null){
        uploadResult = (Boolean) request.getSession().getAttribute("uploadResult");
    }
    System.out.println(uploadResult);
    fileName = (String) request.getSession().getAttribute("fileName");
    filePath = (String) request.getSession().getAttribute("filePath");
    ImgCenter = (Boolean) request.getSession().getAttribute("ImgCenter");
    System.out.println("CreateGifts.uploadResult:"+ uploadResult);
    System.out.println("CreateGifts.filePath:"+ filePath);
%>


<%!
    String token = "";
%>
<%

    token = (String) session.getAttribute("csrftoken");
    System.out.println("ViewGifts:" + token);
    System.out.println("ViewGiftsToken:" + (String)request.getParameter("csrftoken"));
%>

<% String name=(String)session.getAttribute("username");
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

<div class="row">
    <div class="input-group col-md-offset-3" style="padding-top: 135px">
        <div class="input-group">
            <div style="width: 550px;height: 550px;border: dashed">
                <img id="gift" style="display:block; margin:0 auto;vertical-align:middle;">
            </div>


            <span class="input-group-btn">

            <div class="btn-group-vertical col-md-offset-8" role="group" style="margin-top: -200px">

                <div class="btn-group-vertical">
                    <div class="btn-group-vertical">
                        <div class="col-lg-6 col-md-offset-2">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search for...">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">Go!</button>
                                </span>
                            </div><!-- /input-group -->
                        </div><!-- /.col-lg-6 -->

                    </div><br>

                </div>
                <div style="width: 9em; height: 9em; margin-top: 10px">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book"><br>
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book"><br>
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book"><br>
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book"><br>
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book"><br>
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book"><br>
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book">
                    <img class="btn btn-default" style="width: 3em; height: 3em" src="img/book.jpg" alt="book"><br>

                </div>


            </div>
      </span>
        </div>

    </div>
</div>
<script language="javascript">
    function isValid(form)
    {
//        getLocation();
        if (form.uploadFile.value =="")
        {
            alert("File can not be null！");
            return false;
        }
        if (form.comment.value=="")
        {
            alert("comment can not be null");
            return false;
        }
        if(!navigator.onLine){
            alert("Cannot get your location without Internet connection");
            return false;
        }

        return true;
    }

</script>
<script>
//    var x = document.getElementById("demo");
    window.onload = getLocation;
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
        } else {
//            x.innerHTML = "Geolocation is not supported by this browser.";
        }
    }

    function showPosition(position) {
        document.getElementById("coordinate").value = position.coords.latitude + ":" + position.coords.longitude;
        console.log(document.getElementById("coordinate"));
    }
</script>
<form  method="post" action="UploadServlet" enctype="multipart/form-data" onsubmit="return isValid(this)">
    <input type="hidden" name="csrftoken" value="<%=token%>">
    <input type="hidden"  id="coordinate" name="coordinate" value="">
    <input  type="file" name="uploadFile" style="display:inline;">
    name:<input type="text" name="comment" style="display:inline;">
    <input type="submit" value="Create Gift" style="display:inline;">
</form>

<%
    if (uploadResult){
%>
<script type="text/javascript">
    document.getElementById("gift").src = "${basePath}${fileName}";
    if(!<%=ImgCenter%>){
        document.getElementById("gift").width = 550;
        document.getElementById("gift").height = 550;
    }
        <%--"img/<%=fileName%>";--%>
    console.log("${basePath}${fileName}");
</script>







<%
    }

%>

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
