
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry ! something went wrong..!</title>
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
        <div class="container text-center display-1">
            <img src="images/error.png" alt="Error" class="img-fluid">
            <h3 class="display-4">Sorry..! Something wrong in our site..!</h3>
            <%= exception%>
            <br>
            <a class="btn btn-lg primary-background mt-2 text-white" href="index.jsp">Home</a>
        </div>
    </body>
</html>
