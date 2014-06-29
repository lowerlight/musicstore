<%-- 
    Document   : Logout
    Created on : Feb 5, 2012, 10:52:10 PM
    Author     : spstudent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN "
  " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd ">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en " lang="en ">
<!--Author: Jeffrey Nursalim-->
<!--Email:  jeffrey.nursalim@gmail.com-->
<!--Date:   20111218-->
<!--Note:   ST4011 Java Server Programming Assignment 1-->
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Logout</title>
<link rel="stylesheet" type="text/css" href="style_GloriousMusicStore.css" />

</head>

<body>
<a name="top"></a>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log out</title>
    </head>
        <td class="menupipe">|</td>
        <td class="menuwordselect"><a href="Login.jsp">Member Login</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="Registration.html">Register as a Member</a></td>
        <td class="menupipe">|</td>
</body>
</html>
    <body>
        <br>
            <h1>You have logged out successfully!</h1>
        <%
            session.invalidate();
        %>
    </body>
</html>
