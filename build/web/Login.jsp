<%-- 
    Document   : Login
    Created on : Feb 17, 2012, 12:01:16 AM
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
<title>Member Login</title>
<link rel="stylesheet" type="text/css" href="style_GloriousMusicStore.css" />

<script language="javascript">
function isEmailAndPasswordFilled(){
    var objEmail = new Object();
    var objPassword = new Object();
    var msg = new Object();
    var bCompleted = new Boolean(true);

    objEmail = document.getElementById("memberEmail");
    objPassword = document.getElementById("memberPassword");
    msg = document.getElementById("divMessage");

    //Reset all CSS classes first in case there were previous invalid attempts
    resetCSSField(objEmail);
    resetCSSField(objPassword);

    if(!isFieldFilled(objEmail)){
        msg.innerHTML += "Empty Email! Please enter your email address. <br>";
        bCompleted = bCompleted && false;
    }else{
        //bonus: validate Email
    }

    if(!isFieldFilled(objPassword)){
        msg.innerHTML += "Empty Password! Please enter your password. <br>";
        bCompleted = bCompleted && false;
    }else{
        //bonus: validate Password strength
    }

    return bCompleted;
}

function isFieldFilled(objElement){
    var bFilled = new Boolean(true);

    if(!objElement.value){
        objElement.className = "highlight";
        bFilled = false;
    }

    return bFilled;
}

function resetCSSField(objElement){
    objElement.className = "normal";
}
</script>
</head>

<body>
<a name="top"></a>
<div id="MemberLogin">
<form method="post" action="LoginServlet" >
<table class="menu">
    <tr>
        <td class="menupipe">|</td>
        <td class="menuwordselect"><a href="Login.jsp">Member Login</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="Registration.html">Register as a Member</a></td>
        <td class="menupipe">|</td>
    </tr>
    </table>
    <br />  <!--Line break to simulate the effect of hidden links-->
    <table>
        <div id="divMessage" style="text-align: center"></div>
    </table>
    <tr>
        <td><h1>Member Login</h1></td>
    </tr>
    <%
        if(session.getAttribute("memberName") == null){
            //Member is not found or wrong password or the first time
            out.println("Please enter your email and password");
        }
    %>
    </br>
    <table>
    <tr>
        <td>Email</td>
        <td><input name="memberEmail" id="memberEmail" type="text" size="50" /></td>
    </tr>
    <tr>
        <td>Password</td>
        <td><input name="memberPassword" id="memberPassword" type="password" size="25" /></td>
    </tr>
    <tr>
        <td>
            <input type="submit" value="Submit" onclick="return isEmailAndPasswordFilled()" />
        </td>
    </tr>
    </table>
    <br />
    <table>
    <tr>
        <td>
            Forgot your password?
        </td>
    </tr>
    <tr>
        <td>
            <a href="mailto:admin@glorious.com">Click here to request the administrator to reset your password</a>
        </td>
    </tr>

</table>

<!--picture here-->
<br/>
<p><a href="#top">Back to top</a></p>

</form>
</div>
</body>
</html>