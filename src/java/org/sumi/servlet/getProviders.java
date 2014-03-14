/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.sumi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.sumi.rpc.RPCClient;
import org.sumi.rpc.Utilities;
import org.sumi.rpc.procedures.RemoteProcedure;

/**
 *
 * @author Admin
 */
public class getProviders extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RPCClient cxn = (RPCClient) session.getAttribute("cxn");
        String rpctorun = "ORQPT PROVIDERS";
        RemoteProcedure r = new RemoteProcedure(rpctorun);

        cxn.call(r);
        String resp = r.getResponse();

                System.out.println(
                        "Connected: " + cxn.isConnected());
                        session.setAttribute("output", resp);
                        RequestDispatcher requestDispatcher;
                        requestDispatcher = request.getRequestDispatcher("/WEB-INF/rpc_result.jsp");
                        requestDispatcher.forward(request, response);
     {
            
        }
    }
}
