/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.sumi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.sumi.rpc.RPCClient;

/**
 *
 * @author longview
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RPCClient cxn = (RPCClient) session.getAttribute("cxn");

        try (PrintWriter out = response.getWriter()) {

//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/reset.css\">");
//            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/structure.css\">");
//            out.println("<title>Logout page</title>");
//            out.println("</head>");
//            out.println("<body>");
            cxn.disconnect();
            session.invalidate();
            if (!cxn.isConnected()) {

                RequestDispatcher requestDispatcher;
                requestDispatcher = request.getRequestDispatcher("logout.jsp");
                requestDispatcher.forward(request, response);
//                out.println("<p><br>You have been successfully logged out....</p><br>");
//                out.println("</body>");
//                out.println("</html>");
            } else {
                out.println("<p><br>Couldn't log you out... </p><br>");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }
    
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RPCClient cxn = (RPCClient) session.getAttribute("cxn");

        try (PrintWriter out = response.getWriter()) {
            cxn.disconnect();
            session.invalidate();
            if (!cxn.isConnected()) {
                RequestDispatcher requestDispatcher;
                requestDispatcher = request.getRequestDispatcher("logout.jsp");
                requestDispatcher.forward(request, response);
            } else {
                out.println("<p><br>Couldn't log you out... </p><br>");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }
}
