<%-- 
    Document   : results
    Created on : Mar 9, 2014, 12:04:12 PM
    Author     : Sumitro
--%>

<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="css/basic.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>VistA RPC</title>
    </head>
    <%

        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String uname = (String) session.getAttribute("uname");
        if (session.getAttribute("uname") == null) {
            response.sendRedirect("login.jsp");
        }
        String conninfo = (String) session.getAttribute("conninfo");
        String rpctorun = (String) session.getAttribute("rpctorun");
        String parameters = (String) session.getAttribute("parameters");
        String inputstring = (String) session.getAttribute("output");
        String token[] = inputstring.split("\n");%>

    <body bgcolor="#980000">
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
                    <li><a href="reloginservlet">Run Another</a></li>
                </ul>
            </div>
            <div id="content" style="overflow:scroll; height:500px;">
                <h2>
                    Remote Procedure Name: <%=rpctorun%><br>
                    Parameter(s) Passed: <%=parameters%><br>
                </h2>
                <h3>
                    Results
                </h3>

                <p>

                    <%
                        for (int i = 0; i < token.length; i++) {
                            out.print(token[i] + "<br>");
                        }
                    %>
                </p>


            </div>
            <div id="footer">
                Logged in as: <%= uname.toString() + conninfo%> 
            </div>
        </div>

    </body>
</html>
