<%-- 
    Document   : connected
    Created on : Feb 24, 2014, 5:55:54 PM
    Author     : longview
--%>

<%@page import="org.sumi.rpc.procedures.RemoteProcedure"%>
<%@page import="org.sumi.rpc.RPCClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/basic.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>JSP Page</title>
    </head>

    <%

        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        if (session.getAttribute("uname") == null) {
            response.sendRedirect("login.jsp");
        }

        String uname = (String) session.getAttribute("uname");
        RPCClient cxn = (RPCClient) session.getAttribute("cxn");

        System.out.println("Connected: " + cxn.isConnected());
    %>

    <body>
        <div id="container">
            <div id="header">
                <h1>
                    VistA RPC Runner 
                </h1>
            </div>
            <div id="navigation">
                <ul>
                    <li><a href="LogoutServlet">Logout</a></li>
                    <li><a href="help.jsp">Help</a></li>
                </ul>
            </div>

            <h2>Provide the RPC name and parameters</h2>

            <div id="loginbox" style="text-align: center">

                <form class="box login" method="POST" action="RunRpcServlet">

                    <input type="text" tabindex="1" placeholder="Remote Procedure" name="RPCname" required class="myinput"><br>
                    <input type="text" tabindex="2" placeholder="Parameters" name="RPCparameters" class="myinput"><br>
                    <input type="submit" value="Run" tabindex="4" class="mybutton">  
                </form>
            </div>

            <div id="footer">
                Logged in as: <%= uname.toString()%>
            </div>
        </div>
    </body>
</html>
