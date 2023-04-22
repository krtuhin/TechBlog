package com.dao;

import com.entities.Category;
import com.entities.Post;
import com.entities.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategory() {
        ArrayList<Category> list = new ArrayList<>();

        try {

            String query = "select * from categories";

            Statement pstmt = this.con.createStatement();

            ResultSet set = pstmt.executeQuery(query);

            while (set.next()) {
                int cId = set.getInt("cid");
                String name = set.getString("cname");
                String description = set.getString("cdescription");

                Category c = new Category(cId, name, description);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean savePost(Post p) {

        boolean f = false;

        try {
            String query = "insert into posts(pid,ptitle,pcontent,pcode,pimage,catid,userid) values(pid.nextval,?,?,?,?,?,?)";

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpImage());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());

            pstmt.executeUpdate();

            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    //get all the post
    public List<Post> getAllPosts() {

        List<Post> list = new ArrayList<>();

        //fetch all the post
        try {

            PreparedStatement pstmt = con.prepareStatement("select * from posts order by pid desc");
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                int pId = set.getInt("pid");
                String name = set.getString("ptitle");
                String content = set.getString("pcontent");
                String code = set.getString("pcode");
                String image = set.getString("pimage");
                Timestamp date = set.getTimestamp("pdate");
                int catId = set.getInt("catid");
                int userId = set.getInt("userid");

                Post post = new Post(pId, name, content, code, image, date, catId, userId);
                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Post> getPostsByCatId(int cId) {
        List<Post> list = new ArrayList<>();
        //get posts by id

        try {

            PreparedStatement pstmt = con.prepareStatement("select * from posts where catid=? order by pid desc");
            pstmt.setInt(1, cId);
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {

                int pId = set.getInt("pid");
                String name = set.getString("ptitle");
                String content = set.getString("pcontent");
                String code = set.getString("pcode");
                String image = set.getString("pimage");
                Timestamp date = set.getTimestamp("pdate");
                int userId = set.getInt("userid");

                Post post = new Post(pId, name, content, code, image, date, cId, userId);
                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //get user name by id
    public User getUserDetail(int userId) {
        User user = null;

        String query = "select name,profile from tuser where id=?";

        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                String name = set.getString("name");
                String profile = set.getString("profile");

                user = new User(name, profile);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public Post getPostById(int postId) {
        Post post = null;
        String q = "select * from posts where pid=?";
        try {
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, postId);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                String title = set.getString("ptitle");
                String content = set.getString("pcontent");
                String code = set.getString("pcode");
                String image = set.getString("pimage");
                Timestamp date = set.getTimestamp("pdate");
                int catId = set.getInt("catid");
                int userId = set.getInt("userid");

                post = new Post(title, content, code, image, date, catId, userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }
}
