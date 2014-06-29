<%-- 
    Document   : ViewItem
    Created on : Feb 17, 2012, 8:52:52 PM
    Author     : spstudent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN "
  " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd ">


<!--Convert to JSP REfer to sample code -->
<%
    if(session.getAttribute("memberOfGloriousWithName")==null){
        response.sendRedirect("Login.jsp");
    }

%>



<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en " lang="en ">
<!--Author: Jeffrey Nursalim-->
<!--Email:  jeffrey.nursalim@gmail.com-->
<!--Date:   20111218-->
<!--Note:   ST Java Server Programming Assignment 1-->
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>CD</title>

<link rel="stylesheet" type="text/css" href="style_GloriousMusicStore.css" />
<link rel="section" type="text/html" href="" />
</head>

<body>

<a name="top"></a>
<br />  <!--Line break to simulate the effect of hidden links-->
<table class="menu">
    <tr>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="index.jsp">Home</a></td>
        <td class="menupipe">|</td>
        <td class="menuwordselect"><a href="ViewItem.jsp">View Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="SearchItem.jsp">Search Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="EditProfile.jsp">Edit Profile</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="Logout.jsp">Log Out</a></td>
        <td class="menupipe">|</td>
    </tr>
</table>

<form method="post" action="ViewServlet">
    <input type="submit" value="Submit" />
</form>
<!--This file is a template for all search results that are to be-->
<!--displayed in table form-->
<div id="studentdata">
    <table class="tablefordisplay">
        <tr>
            <th class="headingfordisplay">Title</th>
            <th class="headingfordisplay">Singer</th>
            <th class="headingfordisplay">Genre</th>
            <th class="headingfordisplay">Price</th>
        </tr>
    </table>
</div>
<br />
<br />
<p><a href="#top">Back to top</a></p>

</body>
</html>