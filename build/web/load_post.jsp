<%@page import="com.dao.LikeDao"%>
<%@page import="com.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="com.entities.Post"%>
<%@page import="com.helper.ConnectionProvider"%>
<%@page import="com.dao.PostDao"%>
<!--this page is for loading the posts-->

<div class="row">
    <%
        PostDao p = new PostDao(ConnectionProvider.getConnection());
        List<Post> list = null;
        int cid = Integer.parseInt(request.getParameter("cid"));
        if(cid==0){
                list = p.getAllPosts();

        }else{
        list = p.getPostsByCatId(cid);
        }
                if(list.size()==0){
                out.println("<h2 class='text-center'>No post available in this category..</h2>");
        }
        for (Post post : list) {
    %>

    <div class="col-md-6 mt-4">

        <div class="card">
            <div class="card-header primary-background text-white">
                <h4>
                    <%
                    User u = p.getUserDetail(post.getUserId());
                    %>
                    <span><img src="images/profile/<%= u.getProfile() %>" alt="Image" style="max-width: 35px; border-radius: 30px;"> </span><%= u.getName() %>
                </h4>

            </div>
            <img class="card-img-top" src="images/post/<%= post.getpImage()%>" alt="Card image cap">
            <div class="card-body">
                <h5><%= post.getpTitle()%></h5>
                <p><%= post.getpContent()%></p>
                <div class="row mr-right">
                    <p class="mr-right"><%= post.getpDate().toLocaleString() %></p>
                </div>
            </div>
            <div class="card-footer">
                <%
                User user = (User)session.getAttribute("currentUser");
                LikeDao like = new LikeDao(ConnectionProvider.getConnection());
                %>
                <a href="post_detail.jsp?id=<%= post.getPid() %>" class="btn btn-primary btn-sm">Read More</a>
                <a href="#" onclick="doLike(<%= post.getPid() %>,<%= user.getId() %>)" class="btn btn-outline-primary btn-sm mr-right"><i class="fa fa-thumbs-o-up"></i> <span class="like-count"><%= like.countLikeOnPost(post.getPid()) %></span></a>
                <a href="#" class="btn btn-outline-primary btn-sm mr-right"><i class="fa fa-commenting-o"></i> <span>30</span></a>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>