<%--
    Document   : index
    Created on : Dec 25, 2011, 12:55:39 PM
    Author     : spstudent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN "
  " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd ">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en " lang="en ">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Home</title>
<link rel="stylesheet" type="text/css" href="style_GloriousMusicStore.css" />
</head>

<%
    boolean loggedInVisitor = true;
    boolean memberVisitor = true;
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(int i=0; i<cookies.length; i++){
            Cookie c = cookies[i];
            if((c.getName().equals("alreadyAuthen")) && (c.getValue().equals("yes"))){
                loggedInVisitor = true;
                c.setMaxAge(0);    //retire the old cookie
                Cookie returningVisitorCookie = new Cookie("alreadyAuthen", "yes");
                returningVisitorCookie.setMaxAge(120);
                response.addCookie(returningVisitorCookie);
            }
            if((c.getName().equals("memberOfGloriousWithName")) && (c.getValue() != null)){
                memberVisitor = true;
                c.setMaxAge(0);    //retire the old cookie
                Cookie memberCookie = new Cookie("memberOfGloriousWithName", c.getValue());
                memberCookie.setMaxAge(120);
                response.addCookie(memberCookie);
            }
            if(loggedInVisitor == true && memberVisitor == true){
                break;
            }
        }
    }
    if(!loggedInVisitor){
        response.sendRedirect("Login.jsp");
    }
    if(!loggedInVisitor){
        response.sendRedirect("Login.jsp");
    }
%>
<body>
<a name="top"></a>
<table class="menu">
    <tr>
        <td class="menupipe">|</td>
        <td class="menuwordselect"><a href="index.jsp">Home</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="ViewItem.jsp">View Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="SearchItem.jsp">Search Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="EditProfile.jsp">Edit Profile</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="Logout.jsp">Log Out</a></td>
        <td class="menupipe">|</td>
    </tr>
</table>
<h1>Welcome to the Glorious Music Store!</h1>
</body>
</html>