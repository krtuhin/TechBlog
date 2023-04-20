package com.dao;

import com.entities.Category;
import com.entities.Post;
import java.sql.*;
import java.util.ArrayList;

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
}
