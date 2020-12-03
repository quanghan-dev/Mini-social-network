<%-- 
    Document   : error
    Created on : Sep 17, 2020, 10:22:42 AM
    Author     : Han Quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>ERROR PAGE</h1>
        <h2>
            <font color="red">
            </font>
            ${requestScope.ERROR}
        </h2>
        <a href="login.jsp">Back to Login Page</a>
    </body>
</html>
