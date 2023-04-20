/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlets;

import com.dao.UserDao;
import com.entities.Message;
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
public class EditServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String about = request.getParameter("about");
            Part image = request.getPart("profile");
            String imageName = image.getSubmittedFileName();

//            get the user from session
            HttpSession s = request.getSession();

            User user = (User) s.getAttribute("currentUser");

            String oldFile = user.getProfile();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);

            //if image not updated
            if (imageName.isEmpty()) {
                user.setProfile(oldFile);
            } else {
                user.setProfile(imageName);
            }
            
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());

            boolean ans = userDao.updateUser(user);

            if (ans) {
                if (!imageName.isEmpty()) {

                    //save image to server
                    String path = request.getRealPath("/") + "images" + File.separator + "profile" + File.separator + user.getProfile();

                    if (!oldFile.equals("default.png")) {

                        String oldFilePath = request.getRealPath("/") + "images" + File.separator + "profile" + File.separator + oldFile;

                        Helper.deleteFile(oldFilePath);
                    }

                    if (Helper.saveFile(image.getInputStream(), path)) {

                        Message msg = new Message("Profile details updated successfully..!", "success", "alert-success");
                        s.setAttribute("msg", msg);

                    } else {
                        Message msg = new Message("Profile photo is not updated..!", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                    }
                } else {
                    Message msg = new Message("Profile details updated successfully..!", "success", "alert-success");
                    s.setAttribute("msg", msg);
                }
            } else {
                Message msg = new Message("Profile details not updated...!", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }

            response.sendRedirect("profile_page.jsp");

            out.println("</body>");
            out.println("</html>");
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
