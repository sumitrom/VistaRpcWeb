/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.sumi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.sumi.rpc.RPCClient;
import org.sumi.rpc.procedures.RemoteProcedure;
import org.sumi.rpc.rpc.exceptions.LoginException;

/**
 *
 * @author longview
 */
public class loginservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String vistaip = request.getParameter("vistaip");
        int vistaport = Integer.parseInt(request.getParameter("vistaport"));

        String accesscode = request.getParameter("accesscode");
        String verifycode = request.getParameter("verifycode");
        HttpSession session = request.getSession();

        try (PrintWriter out = response.getWriter()) {

//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/reset.css\">");
//            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/structure.css\">");
//            out.println("<title>Welcome page</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<p>Session ID: " + session.getId() + "</p><br>");
//            out.println("<p>Trying to connect to " + vistaip + ":" + vistaport + " using " + accesscode + "/" + verifycode + " combo...</p>");

            RPCClient c = new RPCClient(vistaip, vistaport);
            try {
                c.login(accesscode, verifycode);
                out.println("<p><br><br>Connected: " + c.isConnected() + "</p><br>");
                RemoteProcedure r = new RemoteProcedure("XUS GET USER INFO");
                c.call(r);
                String resp = r.getResponse();
                String token[] = resp.split("\r\n");
                String username = token[1];
//                out.println("<p>Hello " + token[1] + "</p>");
                session.setAttribute("cxn", c);
                session.setAttribute("uname", username);
                RequestDispatcher requestDispatcher;
                requestDispatcher = request.getRequestDispatcher("connected.jsp");
                requestDispatcher.forward(request, response);
            } catch (LoginException ex) {
                out.println("<p><br><br>Connected: " + c.isConnected() + "</p><br>");
                Logger.getLogger(loginservlet.class.getName()).log(Level.SEVERE, null, ex);
                out.println("<p>The following error occured: " + ex.getMessage() + "</p><br>");
                c.disconnect();
                session.setAttribute("err_msg", ex.getMessage());
                RequestDispatcher requestDispatcher;
                requestDispatcher = request.getRequestDispatcher("WEB-INF/error.jsp");
                requestDispatcher.forward(request, response);
                c.disconnect();
            }

            out.println("<p><br>Connected: " + c.isConnected() + "</p><br>");
            out.println("</body>");
            out.println("</html>");
            //session.invalidate();
        }
    }
}
