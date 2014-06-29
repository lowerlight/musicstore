/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author spstudent
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    //Constants
    final static String URL_HOME = "index.jsp";
    final static String URL_REG = "Registration.html";
    final static String URL_SEARCH_ITEM = "SearchItem.jsp";
    final static String URL_VIEW_ITEM = "ViewItem.jsp";
    final static String URL_LOGIN = "Login.jsp";
    final static String URL_LOGOUT = "Logout.jsp";

    final static int SESSION_MAX_INTERVAL = 120;
    final static String URL_SQL_DB = "jdbc:odbc:SWEBAssn1";

    //Servlet connection objects
    Connection conn;

    //SQL statements
    Statement stmt;
    PreparedStatement prepStmt;

    //HTTP session objects
    HttpSession sess;
    //RequestDispatcher dispatcher;
    PrintWriter out;
                    
    //Instance objects
    String email = "";
    String password = "";
    String userName = "";

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        this.out = response.getWriter();
        response.setContentType("text/html");

        //Connect to SQL database
        this.getConnection(URL_SQL_DB);

        //Get HTML Form input
        this.email = request.getParameter("memberEmail");
        this.password = request.getParameter("memberPassword");

        //StoreMember userNameBean=this.verifyLogin(email, password);
        if(this.verifyLogin(email, password)){
            this.sess = request.getSession();
            this.sess.setAttribute("memberOfGloriousWithName", this.userName);

          //  this.sess.setMaxInactiveInterval(SESSION_MAX_INTERVAL);

        //    Cookie[] userCookies = null;
            for(int i=0; i<2; i++){
                if(i==0){
                    //Set memberName cookie 
//                    userCookies[i] = new Cookie("memberOfGloriousWithName", this.userName);
                }
                if(i==1){
                    //Set browsing cookie 
  //                  userCookies[i] = new Cookie("alreadyAuthen", "yes");
                }
    //            userCookies[i].setMaxAge(SESSION_MAX_INTERVAL);
      //          response.addCookie(userCookies[i]);
            }

            out.println(this.sess.getAttribute("memberOfGloriousWithName") + ", you have successfully logged in!");
            response.sendRedirect(URL_HOME);
        }
        else{
            response.sendRedirect(URL_LOGIN);
        }

        //Close SQL DB connection
        this.closeConnection();
        out.println("Closed connection");
        out.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doPost(request, response);
    }// doGet

    public void getConnection(String URL_SQL_DB) {
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
          
          //JOptionPane.showMessageDialog(null, e);
        }
       
    }// getConnection

    public void closeConnection() {
        try {
            conn.close();
        }
        catch (SQLException e) {
            System.err.println("Error executing SQL command :" + e);
        }
    }//closeConnection

    public boolean verifyLogin(String userEmail, String password) {
        boolean memberFound = Boolean.FALSE;
        
        try{
            //Must query the row containing the name first
            String sqlStrSelect = "SELECT * FROM Member";
            ResultSet rSet = stmt.executeQuery(sqlStrSelect);
            ResultSetMetaData rSetMetaData = rSet.getMetaData();

            while(rSet.next()){
                if(rSet.getString("Email").equals(userEmail)){
                    if(rSet.getString("Password").equals(password)){
                        memberFound = Boolean.TRUE;
                        break;
                    }
                    else{
                        //out.println("Wrong password!");
                    }
                }else{
                    //out.println("Email not found!");
                }
            }

            if(memberFound == Boolean.TRUE){
                this.userName = rSet.getString("MemberName");
                //out.println("Member found, redirecting...");
            }
            else{
                //out.println("Member not found!");
            }
        }
        catch (SQLException e) {
            System.err.println("Error executing SQL command :" + e);
        }
        return memberFound;
    }//verifyLogin
}
