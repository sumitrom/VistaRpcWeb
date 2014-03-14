/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.sumi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.sumi.rpc.RPCClient;
import org.sumi.rpc.Utilities;
import org.sumi.rpc.procedures.RemoteProcedure;

/**
 *
 * @author longview
 */
@WebServlet(name = "RunRpcServlet", urlPatterns = {"/RunRpcServlet"})
public class RunRpcServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RPCClient cxn = (RPCClient) session.getAttribute("cxn");
        String rpctorun = request.getParameter("RPCname");
        String parameters = request.getParameter("RPCparameters");
        RemoteProcedure r = new RemoteProcedure(rpctorun);

        if (parameters.contains("[")) {
            r = Utilities.rpc_list_param(rpctorun, parameters);
        } else {
            r = Utilities.rpc_literal_param(rpctorun, parameters);
        }

        cxn.call(r);
        String resp = r.getResponse();

        System.out.println(
                "Connected: " + cxn.isConnected());
        session.setAttribute("rpctorun", rpctorun);
        session.setAttribute("parameters", parameters);
        session.setAttribute("output", resp);
        RequestDispatcher requestDispatcher;
        requestDispatcher = request.getRequestDispatcher("WEB-INF/results.jsp");
        requestDispatcher.forward(request, response);
        {

        }
    }
}
