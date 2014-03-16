<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="css/basic.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>VistA RPC</title>
    </head>
    <%
        String uname = (String) session.getAttribute("uname");
        String conninfo = (String) session.getAttribute("conninfo");
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
                    <li><a href="connected.jsp">Run Another</a></li>
                </ul>
            </div>
            <div id="content">

                <h3>How to pass LITERAL parameters:</h3>
                <p>Just type in as a # separated String. For example:<br>
                    For RPC SD APPOINTMENT MAKE, parameters are supplied thus:<br>
                    <font color="red">195#3130801.0900#ROUTINE#CHECKUP#30#URGENT</font>
                </p>

                <h3>How to pass LIST parameters:</h3>
                <p>For list parameters, use "^" as delimeters. For example:<br>
                    For RPC XYZ that accepts list parameters only, Parameters are supplied thus:<br>
                    <font color="red">12^abcd^edtf^hypo<br></font>
                    In the Above example, 12^abcd^edtf^hypo are list parameters.
                </p>
                <h3>How to pass ORDERED LIST parameters:</h3>
                <p>For ordered list parameters, use [] and #. For example:<br>
                    For RPC ORWORR GET4LST, Parameters are supplied thus:<br>
                    <font color="red">2#3130610.155123#[1,33249;1]#[2,33248;1]<br></font>
                    In the Above example, 2 and 3130610.155123 are literal parameters and the rest are ordered lists.
                </p>
            </div>

            <div id="footer">
                Logged in as: <%= uname.toString() + conninfo%> 
            </div>
        </div>
    </body>
</html>
