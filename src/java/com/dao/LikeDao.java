package com.dao;

import java.sql.*;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean doLike(int pId, int uId) {
        boolean f = false;
        String q = "insert into likes(lid,pid,userid) values(lid.nextval,?,?)";
        try {
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, pId);
            pstmt.setInt(2, uId);
            pstmt.executeUpdate();

            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public int countLikeOnPost(int pId) {
        int count = 0;
        String q = "select count(*) from likes where pid=?";
        try {
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, pId);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                count = set.getInt("count(*)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean checkLike(int pId, int uId) {
        String q = "select lid from likes where pid=? and userid=?";
        boolean f = false;
        try {
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, pId);
            pstmt.setInt(2, uId);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean deleteLike(int pId, int uId) {
        boolean f = false;
        try {
            PreparedStatement pstmt = this.con.prepareStatement("delete from likes where pid=? and userid=?");
            pstmt.setInt(1, pId);
            pstmt.setInt(2, uId);
            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
