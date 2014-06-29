<%-- 
    Document   : SearchItem
    Created on : Feb 17, 2012, 8:59:29 PM
    Author     : spstudent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("memberOfGloriousWithName")==null){
        response.sendRedirect("Login.jsp");
    }

%>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN "
  " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd ">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en " lang="en ">
<!--Author: Jeffrey Nursalim-->
<!--Email:  jeffrey.nursalim@gmail.com-->
<!--Date:   20111218-->
<!--Note:   ST Java Server Programming Assignment 1-->
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Member Login</title>
<link rel="stylesheet" type="text/css" href="style_GloriousMusicStore.css" />
</head>

<body>
<a name="top"></a>
<form method="post" action="SearchServlet">
<table class="menu">
    <tr>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="index.jsp">Home</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="ViewItem.jsp">View Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuwordselect"><a href="SearchItem.jsp">Search Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="EditProfile.jsp">Edit Profile</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="Logout.jsp">Log Out</a></td>
        <td class="menupipe">|</td>
    </tr>
</table>
<table>
    <tr>
        <td>Enter a keyword in the title, or artist/singer, or the year here</td>
    </tr>
    <tr>
        <td><input type="radio" name="itemAttribute" value="title" />Title</td>
        <td><input type="radio" name="itemAttribute" value="artist" />Artist</td>
        <td><input type="radio" name="itemAttribute" value="year" />Year</td>
    </tr>
    <tr>
        <td><input name="itemKeyword" id="itemKeyword" type="text" size="25" /></td>
    </tr>
    <tr>
        <td><input type="submit" value="Submit"/></td>
    </tr>
</table>

</form>
</body>
</html>