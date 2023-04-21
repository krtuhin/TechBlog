package com.servlets;

import com.dao.PostDao;
import com.entities.Post;
import com.entities.User;
import com.helper.ConnectionProvider;
import com.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author krtuh
 */
@MultipartConfig
public class AddPostServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            int cId = Integer.parseInt(request.getParameter("cId"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String code = request.getParameter("code");
            Part part = request.getPart("image");
            String img = part.getSubmittedFileName();

            if (img.isEmpty()) {
                img = "default.png";
            }
            
            //getting current user id
            HttpSession s = request.getSession();

            User user = (User) s.getAttribute("currentUser");

            Post p = new Post(title, content, code, img, cId, user.getId());

            PostDao post = new PostDao(ConnectionProvider.getConnection());

            boolean ans = post.savePost(p);

            if (ans) {

                String path = request.getRealPath("/") + "images" + File.separator + "post" + File.separator + img;
                if (Helper.saveFile(part.getInputStream(), path)) {
                    out.print("done");
                }
            } else {
                out.println("error");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
