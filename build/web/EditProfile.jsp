<%-- 
    Document   : EditProfile
    Created on : Feb 17, 2012, 12:01:16 AM
    Author     : spstudent
--%>
<%@page import="java.sql.*" %>
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
<title>Edit Profile</title>
<link rel="stylesheet" type="text/css" href="style_GloriousMusicStore.css" />

<script language="javascript">
function isEditProfileCorrect(){
    var objNRIC = new Object();
    var objName = new Object();
    var objAddress = new Object();
    var objEmail = new Object();
    var objContact = new Object();
    var objPassword = new Object();
    var objCCType = new Object();
    var objCCNumber = new Object();
    var msg = new Object();
    var bFilled = new Boolean(true);
    var bCompleted = new Boolean(true);
    var bValid = new Boolean(true);

    objNRIC = document.getElementById("memberNRIC");
    objName = document.getElementById("memberName");
    objAddress = document.getElementById("memberAddress");
    objEmail = document.getElementById("memberEmail");
    objContact = document.getElementById("memberContact");
    objCCType_Visa = document.getElementById("memberCCType_Visa");
    objCCType_MC = document.getElementById("memberCCType_MC");
    objCCNo = document.getElementById("memberCreditCardNo");
    objPassword = document.getElementById("memberPassword");
    msg = document.getElementById("divMessage");

    //Reset all CSS classes first in case there were previous invalid attempts
    resetCSSField(objNRIC);
    resetCSSField(objName);
    resetCSSField(objAddress);
    resetCSSField(objEmail);
    resetCSSField(objContact);
    resetCSSField(objCCNo);
    resetCSSField(objPassword);

    if(!objNRIC.value){
        bValid = bValid && false;
        msg.innerHTML += "Empty NRIC! Please enter your NRIC. <br>";
        highlightCSSField(objNRIC);
    }else{
        //validate NRIC
        if(!isNRICValid(objNRIC)){
            bValid = bValid && false;
            msg.innerHTML += "Invalid format for NRIC. Please reenter. <br>";
            highlightCSSField(objNRIC);
        }
    }

    if(!objName.value){
        bValid = bValid && false;
        msg.innerHTML += "Empty Name! Please enter your Name. <br>";
        highlightCSSField(objName);
    }

    if(!objAddress.value){
        bValid = bValid && false;
        msg.innerHTML += "Empty Address! Please enter your Address. <br>";
        highlightCSSField(objAddress);
    }

    if(!objEmail.value){
        bValid = bValid && false;
        msg.innerHTML += "Empty Email! Please enter your Email. <br>";
        highlightCSSField(objEmail);
    }else{
        //validate Email
        if(!isEmailValid(objEmail)){
            bValid = bValid && false;
            msg.innerHTML += "Invalid format for Email. Please reenter. <br>";
            highlightCSSField(objEmail);
        }
    }

    if(!objContact.value){
        bValid = bValid && false;
        msg.innerHTML += "Empty Contact! Please enter your Contact. <br>";
        highlightCSSField(objContact);
    }else{
        //validate Contact
        if(!isContactValid(objContact)){
            bValid = bValid && false;
            msg.innerHTML += "Invalid Contact number. Please reenter. <br>";
            highlightCSSField(objContact);
        }
    }


    if(!objCCType_Visa.checked && !objCCType_MC.checked){
        bValid = bValid && false;
        msg.innerHTML += "Empty Credit Card Type! Please enter your Credit Card Type. <br>";
        //highlightCSSField(objCCType_Visa);
        //highlightCSSField(objCCType_MC);
    }

    if(!objCCNo.value){
        bValid = bValid && false;
        msg.innerHTML += "Empty Credit Card No! Please enter your Credit Card No. <br>";
        highlightCSSField(objCCNo);
    }else{
        //validate CCType

    }

    if(!objPassword.value){
        bValid = bValid && false;
        msg.innerHTML += "Empty Password! Please enter your Password. <br>";
        highlightCSSField(objPassword);
    }else{
        //measure password strength??
    }

    return bValid;
}

function highlightCSSField(objElement){
    objElement.className = "highlight";
}

function resetCSSField(objElement){
    objElement.className = "normal";
}

function isNRICValid(objIC){
    var numberTemplate = "1234567890";
    var firstLetter = objIC.value.charAt(0);
    var lengthOfIC = objIC.value.length;
    var lastLetter;
    var idx = new Number(0);
    var bValid = new Boolean(true);

    if(objIC.value.length != 9){
        bValid = bValid && false;
    }

    if(firstLetter.toUpperCase() != 'S'){
        bValid = bValid && false;
    }

    for(idx = 1; idx < (lengthOfIC - 1); idx++){
        //Check through the digits between the first and the last letter
        if(numberTemplate.indexOf(objIC.value.charAt(idx)) < 0){
            //It's an alphabet, not a number!
            bValid = bValid && false;
            break;
        }
    }

    lastLetter = objIC.value.charAt(lengthOfIC - 1);
    if(numberTemplate.indexOf(lastLetter) >= 0){
        //It's a number, not an alphabet!
        bValid = bValid && false;
    }

    return bValid;
}

function isEmailValid(objEml){
    var atCharIdx = objEml.value.indexOf("@");
    var atCharLastIdx = objEml.value.lastIndexOf("@");
    var dotCharIdx = objEml.value.lastIndexOf(".");
    var charTemplate = "abcdefghijklmnopqrstuvwxyz0123456789.-_@";
    //var invCharTemplateLast = ".-@"
    var idx = new Number(0);
    var bValid = new Boolean(false);

    if(atCharIdx < 1 || dotCharIdx < (atCharIdx + 2) || (dotCharIdx + 2) >= objEml.value.length){
        bValid = bValid && false;
    }

    if(atCharIdx != atCharLastIdx){
        bValid = bValid && false;
    }

    for(idx = 0; idx < objEml.value.length; idx++){
        //Check that all characters are valid
        if(charTemplate.indexOf(objEml.value.charAt(idx).toLowerCase()) < 0){
            //Invalid character found
            bValid = bValid && false;
            break;
        }
    }

    return bValid;
}

function isContactValid(objTel){
    var numberTemplate = "1234567890";
    var lengthOfTel = objTel.value.length;
    var idx = new Number(0);
    var bValid = new Boolean(true);

    if(lengthOfTel != 8){
        bValid = bValid && false;
    }

    for(idx = 0; idx < lengthOfTel; idx++){
        //Check that all characters are digits
        if(numberTemplate.indexOf(objTel.value.charAt(idx)) < 0){
            //It's an alphabet, not a number!
            bValid = bValid && false;
            break;
        }
    }

    return bValid;
}
</script>
</head>

<%
    if(session.getAttribute("memberOfGloriousWithName")==null){
        response.sendRedirect("Login.jsp");
    }
%>

<%
    Connection conn=null;
    Statement stmt=null;
    PreparedStatement prepStmt=null;
    boolean regStatus = Boolean.FALSE;
    boolean memberFound = Boolean.FALSE;
    try{
        //Must query the row containing the name first
        String sqlStrSelect = "SELECT * FROM Member";
 
        getConnection(conn, stmt);
        ResultSet rSet = stmt.executeQuery(sqlStrSelect);
        ResultSetMetaData rSetMetaData = rSet.getMetaData();

        //out.println("Please wait while we verify your details");

        //Find the member using his name
        while(rSet.next()){
            if(rSet.getString("memberName").equals(session.getAttribute("memberOfGloriousWithName"))){
                memberFound = Boolean.TRUE;

                StoreMember newcomer = new StoreMember(
                    rSet.getString("NRIC"),
                    rSet.getString("MemberName"),
                    rSet.getString("Address"),
                    rSet.getString("Email"),
                    rSet.getString("Contact"),
                    rSet.getString("CreditCardType"),
                    rSet.getString("CreditCardNo"),
                    rSet.getString("Password"));
                break;
            }
        }
        closeConnection(conn);
        
    }
    catch (SQLException e) {
        out.println("Error executing SQL command :" + e);
    }
%>

<body>
<a name="top"></a>
<table class="menu">
    <tr>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="index.jsp">Home</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="ViewItem.jsp">View Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuwordselect"><a href="SearchItem.jsp">Search Catalogue</a></td>
        <td class="menupipe">|</td>
        <td class="menuwordselect"><a href="EditProfile.jsp">Edit Profile</a></td>
        <td class="menupipe">|</td>
        <td class="menuword"><a href="Logout.jsp">Log Out</a></td>
        <td class="menupipe">|</td>
    </tr>
</table>
<br />  <!--Line break to simulate the effect of hidden links-->
<table>
    <div id="divMessage" style="text-align: center"></div>
</table>
<form method="post" action="EditProfileServlet" >
<div id="EditProfile">
<tr>
    <td><h1>Edit Profile</h1></td>
</tr>
<br />

<%!
    final static String URL_SQL_DB = "jdbc:odbc:SWEBAssn1";
    public void getConnection(Connection conn, Statement stmt) {
        try {
            // Step 1: Load JDBC Driver
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            // Step 2: Establish connection (to database)
            conn = DriverManager.getConnection(URL_SQL_DB);
            // Step 3: Create a (prepared) statement object
            stmt = conn.createStatement();
        }
        catch (Exception e) {
          System.err.println("Error loading driver :" + e);
        }
       
    }// getConnection
%>
<%!
    public void closeConnection(Connection conn) {
        try {
            conn.close();
        }
        catch (SQLException e) {
            System.err.println("Error executing SQL command :" + e);
        }
    }//closeConnection
%>
<%
    try{
        //Must query the row containing the name first
        String sqlStrUpdate = "UPDATE Member SET (Address, Email, Contact) VALUES (?, ?, ?) WHERE NRIC = " + 
                request.getParameter("memberNRIC");

        if(memberFound){
            getConnection(conn, prepStmt);
            //Insert into table
            prepStmt = conn.prepareStatement(sqlStrUpdate);
            prepStmt.setString(1, request.getParameter("memberAddress"));
            prepStmt.setString(2, request.getParameter("memberEmail"));
            prepStmt.setString(3, request.getParameter("memberContact"));
            prepStmt.execute();

            regStatus = Boolean.TRUE;
            closeConnection(conn);
        }
    }
    catch (SQLException e) {
        out.println("Error executing SQL command :" + e);
    }
%>



<table>
    <tr>
        <td>NRIC</td>
        <td><input name="memberNRIC" id="memberNRIC" type="text" size="9" 
                    value = <%= newcomer.getNRIC() %>/></td>
    </tr>
    <tr>
        <td>Full Name</td>
        <td><input name="memberName" id="memberName" type="text" size="25" 
                    value = <%= newcomer.getName() %> /></td>
    </tr>
    <tr>
        <td>Address</td>
        <td><input name="memberAddress" id="memberAddress" type="text" size="100" 
                    value = <%= newcomer.getAddress() %>/></td>
    </tr>
    <tr>
        <td>Email</td>
        <td><input name="memberEmail" id="memberEmail" type="text" size="50" 
                   value = <%= newcomer.getEmail() %>   
                   /></td>
    </tr>
    <tr>
        <td>Contact</td>
        <td><input name="memberContact" id="memberContact" type="text" size="15"
                    value = <%= newcomer.getContact() %> /></td>
    </tr>
    <tr>
        <td>Credit Card Type</td>
        <td><input name="memberCCType" id="memberCCType_Visa" type="radio" value="Visa"/>Visa</td>
        <td><input name="memberCCType" id="memberCCType_MC" type="radio" value="MasterCard"/>MasterCard</td>
    </tr>
    <tr>
        <td>Credit Card No (without any dash)</td>
        <td><input name="memberCreditCardNo" id="memberCreditCardNo" type="text" size="16" 
                    value = <%= newcomer.getCCNo() %>/></td>
    </tr>
    <tr>
        <td>Password</td>
        <td><input name="memberPassword" id="memberPassword" type="password" size="25" /></td>
    </tr>
    <tr>
        <td>
            <input type="submit" value="Submit" onclick="return isEditProfileCorrect()" />
        </td>
    </tr>
</table>
<br />

<!--picture here-->
<br/>
<p><a href="#top">Back to top</a></p>

</div>
</form>
</body>
</html>