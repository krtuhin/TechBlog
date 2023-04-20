
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <!--<link href="css/style.css" rel="stylesheet">-->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 89%, 63% 97%, 24% 90%, 0 98%, 0 0);
            }
        </style>
    </head>
    <body>
        <!--navbar-->
        <%@include file="navbar.jsp" %>

        <main class="primary-background banner-background" style=" padding-bottom: 100px; padding-top: 20px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <div class="card">
                            <div class="card-header text-center primary-background text-white">
                                <span class="fa fa-user-circle-o fa-2x"></span>
                                <br>
                                Register Here!
                            </div>
                            <div class="card-body">
                                <form id="register" action="RegisterServlet" method="POST">
                                    <div class="form-group">
                                        <label for="user_name">User Name<span style="color:red;">*</span></label>
                                        <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">
                                    </div>

                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Email address<span style="color:red;">*</span></label>
                                        <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                    </div>

                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password<span style="color:red;">*</span></label>
                                        <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                    </div>

                                    <div class="form-group">
                                        <label for="gender">Select Gender<span style="color:red;">*</span></label>
                                        <br>
                                        <input type="radio" id="gender" name="gender" value="Male"> Male
                                        <input type="radio" id="gender" name="gender" value="Female"> Female
                                    </div>

                                    <div class="form-group">
                                        <label for="about">About(optional)</label>
                                        <textarea name="about" id="" class="form-control" rows="3" placeholder="Enter somrthing about yourself"></textarea>
                                    </div>

                                    <div class="form-check">
                                        <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="exampleCheck1">Agree terms & conditions </label>
                                    </div>
                                    <br>

                                    <div class="container text-center" id="loader" style="display:none;">
                                        <span class="fa fa-refresh fa-3x fa-spin"></span>
                                        <h4>Please wait...</h4>
                                    </div>
                                    <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!--javascripts-->
        <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/script.js" type="text/javascript"></script>

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
            $(document).ready(function () {

                console.log("Loaded...");

                $("#register").on("submit", function (event) {

                    event.preventDefault();

                    let form = new FormData(this);

                    $("#sunmit-btn").hide();
                    $("#loader").show();

                    //send data to register servlet
                    $.ajax({
                        url: 'RegisterServlet',
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#sunmit-btn").show();
                            $("#loader").hide();

                            if (data.trim() === "done") {
                                swal("Registered Successfully..! We are going to redirect into login page...")
                                        .then((value) => {
                                            window.location = "login_page.jsp";
                                        });
                            } else {
                                swal(data);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                            $("#sunmit-btn").show();
                            $("#loader").hide();
                            swal("Something went wrong..try again..!");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });

        </script>
    </body>
</html>
