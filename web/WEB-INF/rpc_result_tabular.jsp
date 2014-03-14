<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/reset.css">
        <link rel="stylesheet" type="text/css" href="css/structure.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style type="text/css">
            .tftable {font-size:12px;color:#fbfbfb;width:100%;border-width: 2px;border-color: #686767;border-collapse: collapse;padding: 3px 7px 2px 7px;}
            .tftable th {font-size:12px;background-color:#171515;border-width: 1px;padding: 3px 7px 2px 7px;border-style: solid;border-color: #686767;text-align:left;}
            .tftable tr {background-color:#2f2f2f;}
            .tftable td {font-size:12px;border-width: 1px;padding: 12px;border-style: solid;border-color: #686767;}
            .tftable tr:hover {background-color:#171515;}
        </style>

        <title>RPC Results</title>
    </head>
    <body>
        <div style="text-align:center"> 
            <FORM METHOD="LINK" ACTION="connected.jsp">
                <INPUT TYPE="submit" class="sumibox" VALUE="Run another RPC">
            </FORM>
            <form name="Logout" action="LogoutServlet" method="POST">
                <input type="submit" class="sumibox" value="Logout" />
            </form>
        </div> 
        <br><br><br>

        <h1>Results from RPC Execution</h1>
        <br>


        <%

            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            if (session.getAttribute("uname") == null) {
                response.sendRedirect("login.jsp");
            }
            String rpctorun = (String) session.getAttribute("rpctorun");
            String parameters = (String) session.getAttribute("parameters");
            String inputstring = (String) session.getAttribute("output");
            String token[] = inputstring.split("\n");
            out.print("<p>RPC executed: " + rpctorun +"</p><br>");
            out.print("<p>Parameters: " + parameters +"</p><br>");
            out.print("<table style=\"float:right\" class=\"tftable\" border=\"1\">");
            for (int i = 0; i < token.length; i++) {
                out.print("<tr>");
                String infield[] = token[i].split("\\^");

                for (int j = 0; j < infield.length; j++) {
                    out.print("<td>" + infield[j] + "</td>");
                }
                out.println("<tr>");
            }
            out.print("</table>");
        %>

        <br>

    </body>
</html>