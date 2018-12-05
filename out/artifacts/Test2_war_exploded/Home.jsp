<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 10/9/2017
  Time: 12:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">

    <meta charset="UTF-8">
    <title>Home</title>
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
                        <li><a href="EditProfile.jsp">Edit Profile</a></li>
                        <li><a href="SignOut.jsp">Sign Out </a></li>
                    </ul>
                </li>
                <li class="dropdown active">
                    <a id="drop1" href="ViewAccount.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Gifts
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <li><a href="ViewGifts.jsp">View Gifts</a></li>
                        <li><a href="CreateGifts.jsp">Create Gifts</a></li>
                    </ul>
                </li>

                <li class="dropdown">
                    <a id="drop2" href="ViewAccount.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Friends
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <li><a href="ViewFriends.jsp">View Friends</a></li>
                        <li><a href="AddFriends.jsp">Add Friends</a></li>
                    </ul>
                </li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>

<div class=" container row" >
    <div class="input-group col-md-offset-3" style="padding-top: 135px">
        <div class="input-group">
            <table class="table table-striped col-md-6" >
                <tr>
                    <th>Picture</th>
                    <th>Name</th>
                    <th></th>
                    <th></th>
                </tr>
                <tr>
                    <td><img src="img/g1.jpg" alt="g1"></td>
                    <td>note</td>
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
                <tr>
                    <td><img src="img/g2.jpg" alt="g2"></td>
                    <td>textbook</td>
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
                <tr>
                    <td><img src="img/g3.jpg" alt="g3"></td>
                    <td>pen</td>
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
                <tr>
                    <td><img src="img/g4.jpg" alt="g4"></td>
                    <td>mouse</td>
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
            </table>

            <span class="input-group-btn" >
            <div class="btn-group-vertical col-md-offset-8" role="group" aria-label="..." >
                 <div class="btn-group-vertical" style="width:200px;height:480px;overflow: scroll;">
                     <button type="button" class="btn btn-default"><img src="img/p1.jpg" alt="book"></button>
                <button type="button" class="btn btn-default"><img src="img/p2.jpg" alt="book"></button>
                <button type="button" class="btn btn-default"><img src="img/p3.png" alt="book"></button>
                <button type="button" class="btn btn-default"><img src="img/p4.png" alt="book"></button>
                </div>

            </div>
            </span>
        </div>

    </div>
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
</body>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
