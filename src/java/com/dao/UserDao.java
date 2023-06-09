package com.dao;

import java.sql.*;
import com.entities.User;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

//     method for inserting user into database
    public boolean saveData(User user) {

        boolean f = false;

        try {
            //user data -->> database

            String query = "insert into tuser(id,name,email,password,gender,about,rdate) values(id.nextval,?,?,?,?,?,current_date)";

            PreparedStatement pstmt = this.con.prepareStatement(query);

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    //get user by email and password
    public User getUserByEmailAndPassword(String email, String password) {

        User user = null;

        try {
            String query = "Select * from tuser where email=? and password=?";
            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                user = new User();

//                data from database
                String name = set.getString("name");

//                set data to user object
                user.setName(name);

                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean updateUser(User user) {

        boolean f = false;

        try {
            String query = "update tuser set name=?, email=?, password=?, gender=?, about=?, profile=? where id=?";
            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.setString(6, user.getProfile());
            pstmt.setInt(7, user.getId());

            pstmt.executeUpdate();

            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
