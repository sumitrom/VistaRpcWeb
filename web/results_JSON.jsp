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
        String uname = (String) session.getAttribute("uname");
        if (session.getAttribute("uname") == null) {
            response.sendRedirect("login.jsp");
        }
        String conninfo = (String) session.getAttribute("conninfo");
        String rpctorun = (String) session.getAttribute("rpctorun");
        String parameters = (String) session.getAttribute("parameters");
        String inputstring = (String) session.getAttribute("output");
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
                    <li><a href="connected.jsp">Run Another</a></li>
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
                        String lines[] = inputstring.split("\n");

                        String jsonOutput = "";
                        for (int i = 0; (i < lines.length); i++) {
                            String[] fields = lines[i].split("\\^");
                            System.out.println("{");
                            jsonOutput = jsonOutput + "{";

                            for (int j = 0; j < (fields.length - 1); j++) {
                                System.out.println("   \"field" + j + "\":" + "\"" + fields[j] + "\",");
                                jsonOutput = jsonOutput + "\"field" + j + "\":" + "\"" + fields[j] + "\",";
                            }
                            System.out.println("   \"field" + (fields.length - 1) + "\":" + "\"" + fields[fields.length - 1] + "\"");
                            jsonOutput = jsonOutput + "\"field" + (fields.length - 1) + "\":" + "\"" + fields[fields.length - 1] + "\"";
                            System.out.println("},");
                            jsonOutput = jsonOutput + "},";
                        }
                        jsonOutput = jsonOutput.substring(0, jsonOutput.length() - 1);
                        out.print(jsonOutput);
                    %>
                </p>


            </div>
            <div id="footer">
                Logged in as: <%= uname.toString() + conninfo%> 
            </div>
        </div>

    </body>
</html>
