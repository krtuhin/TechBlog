
<%@page import="com.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.entities.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.entities.Category"%>
<%@page import="com.entities.Post"%>
<%@page import="com.helper.ConnectionProvider"%>
<%@page import="com.dao.PostDao"%>
<%@page import="com.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostById(postId);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--css-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<!--<link href="css/style.css" rel="stylesheet">-->
<link href="css/style.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
    .banner-background{
        clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 89%, 63% 97%, 24% 90%, 0 98%, 0 0);
    }
    .post-title{
        font-weight: 250;
        font-size: 30;
    }
    .post-content{
        font-weight: 150;
        font-size: 24;
    }
    .post-date{
        font-style: italic;
        font-weight: 500;

    }
    .post-user{
        text-decoration: none;
        font-size: 20;
        font-weight: 450;
    }
    .row-user{
        border: 1px solid #e2e2e2;
        padding-top: 15px;
    }

    body{
        background-image: url(images/bg.png);
        background-attachment: fixed;
        background-size: cover;
    }
    /*    .post-user::hover{
            text-decoration: none;
        }*/
</style>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%></title>
    </head>
    <body>
        <!--start navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk"></span> Technical Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile_page.jsp"> <span class="fa fa-home"></span> Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-list-alt"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming</a>
                            <a class="dropdown-item" href="#">Projects</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"> <span class="fa fa-id-badge"></span> Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#post-modal"> <span class=" fa fa-cloud-upload"></span> Create Post</a>
                    </li>
                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"> <span class="fa fa-user-circle"></span> <%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> <span class="fa fa-sign-out"></span> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--end navbar-->

        <!--update message-->
        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert <%= m.getCssClass()%> ">
            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>

        <!--main body of the page-->

        <main>
            <div class="container">
                <div class="row my-4">
                    <div class="col-md-8 offset-md-2">
                        <div class="card">
                            <div class="card-header">
                                <%
                                    User u = d.getUserDetail(p.getUserId());
                                %>
                                <h3 class="post-title"><%= p.getpTitle()%></h3>
                            </div>
                            <div class="card-body">
                                <img class="card-img-top my-2" src="images/post/<%= p.getpImage()%>" alt="Image">
                                <!--name print-->
                                <div class="row row-user">
                                    <div class="col-md-8">
                                        <p class="post-user"><a href="#"><%= u.getName()%></a> has posted:</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p class='post-date'><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                    </div>
                                </div>
                                <h6 class="post-content"><%= p.getpContent()%></h6>
                                <br>
                                <div class="post-code">
                                    <%
                                        if (p.getpCode() != null) {
                                    %>
                                    <pre><%= p.getpCode()%></pre>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="card-footer">
                                <%
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                %>
                                <a href="#" onclick="doLike(<%= postId %>, <%= user.getId() %>)" class="btn btn-outline-primary btn-sm"><i class="fa fa-thumbs-o-up"></i> <span class="like-countV"><%= ld.countLikeOnPost(postId) %></span></a>
                                <a href="#" onclick="" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i> <span>50</span></a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </main>



        <!--end main body of the page-->

        <!--start profile modal-->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-center text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="images/profile/<%= user.getProfile()%>" style="max-width: 90px; border-radius: 50px;">
                            <h3><%= user.getName()%></h3>
                            <h5><%= user.getAbout()%></h5>

                            <!--details-->

                            <div id="profile-detail">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID: </th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email: </th>
                                            <td><%= user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender: </th>
                                            <td><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Registered on: </th>
                                            <td><%= user.getDateTime().toLocaleString()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--profile edit-->
                            <div id="profile-edit" style="display: none;">

                                <h3 class="mt-2">Edit Details</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID: </td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Name: </td>
                                            <td><input type="text" name="name" class="form-control" placeholder="Enter name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Email: </td>
                                            <td><input type="email" name="email" class="form-control" placeholder="Enter new email" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Password: </td>
                                            <td><input type="password" name="password" class="form-control" placeholder="Enter new password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender: </td>
                                            <td><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <td>About: </td>
                                            <td><textarea type="text" name="about" class="form-control" rows="3" placeholder="Enter something about yourself"><%= user.getAbout()%></textarea></td>
                                        </tr>
                                        <tr>
                                            <td>New Profile: </td>
                                            <td><input type="file" name="profile" class="form-control"></td>
                                        </tr>
                                    </table>
                                    <button type="submit" class="btn btn-outline-success">Save</button>
                                </form>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <a type="button" id="edit-btn" href="#!" class="btn btn-primary"><span class="fa fa-edit"></span> <span id="edt">Edit</span></a>
                    </div>
                </div>
            </div>
        </div>

        <!--end profile modal-->

        <!--add post modal-->

        <!-- Modal -->
        <div class="modal fade" id="post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Provide post details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="AddPostServlet" method="post" id="post-form">

                            <div class="form-group">
                                <select class="form-control" name="cId">
                                    <option selected disabled>---Select Category---</option>
                                    <%
                                        PostDao post = new PostDao(ConnectionProvider.getConnection());

                                        ArrayList<Category> list = post.getAllCategory();

                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getCname()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <input type="text" name="title" placeholder="Enter post title" class="form-control">
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" name="content" placeholder="Add post content" rows="5"></textarea>
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" name="code" placeholder="Add program(if any)" rows="4"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="pic">Add picture</label>
                                <input type="file" id="pic" name="image" class="form-control">
                            </div>

                            <div class="container text-right">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Discard</button>
                                <button type="submit" class="btn btn-primary">Post</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--end add post modal-->




        <!--javascripts-->
        <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/script.js" type="text/javascript"></script>

        <script>

                                    $(document).ready(function () {
                                        let editStatus = true;
                                        $("#edit-btn").click(function () {

                                            if (editStatus) {

                                                $("#profile-detail").hide();
                                                $("#profile-edit").show();
                                                $("#edt").text("Back");
                                                editStatus = false;
                                            } else {

                                                $("#profile-detail").show();
                                                $("#profile-edit").hide();
                                                $("#edt").text("Edit");
                                                editStatus = true;
                                            }
                                        });
                                    });
        </script>

        <!--post form-->
        <script>
            $(document).ready(function (e) {
                $("#post-form").on("submit", function (event) {
                    //this code will execute when the form will submited
                    event.preventDefault();
                    let form = new FormData(this);
                    //requesting servlet

                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data === "done") {
                                swal("Congratulations", "Your content posted successfully..!", "success")
                                        .then((value) => {
                                            window.location = "profile_page.jsp";
                                        });
                            } else {
                                swal("Error!!", "Something went wrong! Please try again..!", "warning");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        },
                        processData: false,
                        contentType: false,
                    });
                });
            });
        </script>
    </body>
</html>
