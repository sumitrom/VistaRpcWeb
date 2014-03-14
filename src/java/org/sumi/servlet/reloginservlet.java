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
public class reloginservlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        String vistaip = (String) session.getAttribute("vistaip");
//        int vistaport = (int) session.getAttribute("vistaport");
//   //     int vistaport = Integer.parseInt(port);
        String vport = (String) session.getAttribute("vistaport");
        int vistaport = Integer.parseInt(port);
        String accesscode = (String) session.getAttribute("accesscode");
        String verifycode = (String) session.getAttribute("verifycode");

        try (PrintWriter out = response.getWriter()) {

            RPCClient c = new RPCClient(vistaip, vistaport);
            try {
                c.login(accesscode, verifycode);
                out.println("<p><br><br>Connected: " + c.isConnected() + "</p><br>");
                RemoteProcedure r = new RemoteProcedure("XUS GET USER INFO");
                c.call(r);
                String resp = r.getResponse();
                String token[] = resp.split("\r\n");
                String username = token[1];
                String conninfo = (" * Connected to " + vistaip + " at port " + vport);

                session.setAttribute("cxn", c);
                session.setAttribute("uname", username);
                session.setAttribute("vistaip", vistaip);
                session.setAttribute("vport", vport);
                session.setAttribute("conninfo", conninfo);
                session.setAttribute("accesscode", accesscode);
                session.setAttribute("verifycode", verifycode);
                RequestDispatcher requestDispatcher;
                requestDispatcher = request.getRequestDispatcher("connected.jsp");
                requestDispatcher.forward(request, response);
            } catch (LoginException ex) {
                out.println("<p><br><br>Connected: " + c.isConnected() + "</p><br>");
                Logger.getLogger(reloginservlet.class.getName()).log(Level.SEVERE, null, ex);
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
