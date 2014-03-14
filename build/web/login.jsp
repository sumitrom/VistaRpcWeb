<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="css/basic.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>VistA RPC</title>
    </head>
    <body bgcolor="#980000">
        <div id="container">
            <div id="header">
                <h1>
                    VistA RPC Runner 
                </h1>
            </div>
            <div id="content">

                <h3>
                    VistA RPC web runner provides a web-enabled GUI to connect to a VistA site and execute Remote Procedure Call against it.
                    <br><br>
                    The RPC Broker is a client/server system within VA's Veterans Health Information Systems and Technology Architecture (VISTA) environment. It enables client applications to communicate and exchange data with M Servers.
                    <br><br>
                    Please Login using VistA credentials. If you do not have access to a VistA system, please contact your VistA System Administrator.<br><br>
                </h3>

                <div id="loginbox" style="text-align: center">


                    <form method="POST" action="loginservlet">

                        <input type="text" tabindex="1" placeholder="VistA Servername or IP Address" name="vistaip" required class="myinput"><br>
                        <input type="text" tabindex="2" placeholder="VistA Port" name="vistaport" required class="myinput"><br>
                        <input type="text" tabindex="3" placeholder="Access Code" name="accesscode" required class="myinput"><br>
                        <input type="password" tabindex="4" placeholder="Verify Code" name="verifycode" required class="myinput"><br>
                        <input type="submit" value="Login" tabindex="4" class="mybutton">  
                    </form>
                </div>
            </div>

            <div id="footer">
                Copyright © Sumitro Majumdar, 2014
            </div>
        </div>
    </body>
</html>
