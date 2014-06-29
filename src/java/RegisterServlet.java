/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.swing.JOptionPane;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})


/**
 *
 * @author spstudent
 */
public class RegisterServlet extends HttpServlet {
    //Constants
    final static int SESSION_MAX_INTERVAL = 120;
    final static String URL_SQL_DB = "jdbc:odbc:SWEBAssn1";

    final static String URL_HOME = "index.jsp";
    final static String URL_REG = "Registration.html";
    final static String URL_SEARCH_ITEM = "SearchItem.jsp";
    final static String URL_VIEW_ITEM = "ViewItem.jsp";
    final static String URL_LOGIN = "Login.jsp";
    final static String URL_LOGOUT = "Logout.jsp";

    //Servlet connection objects
    Connection conn;
    Statement stmt;
    PreparedStatement prepStmt;
    HttpSession sess;
    PrintWriter out;
    StoreMember userNameBean;

    int state;

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

        //case STATE_REGISTRATION:
        StoreMember newcomer = new StoreMember(
            request.getParameter("memberNRIC"),
            request.getParameter("memberName"),
            request.getParameter("memberAddress"),
            request.getParameter("memberEmail"),
            request.getParameter("memberContact"),
            request.getParameter("memberCreditCardType"),
            request.getParameter("memberCreditCardNo"),
            request.getParameter("memberPassword"));

        out = response.getWriter();

        if(this.registerMember(newcomer)){
            response.sendRedirect(URL_LOGIN);
        }else{
            //out.println("Something wrong!");
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

    public boolean registerMember(StoreMember newMember) {
        boolean regStatus = Boolean.FALSE;
        boolean memberFound = Boolean.FALSE;
        try{
            //Must query the row containing the name first
            String sqlStrSelect = "SELECT * FROM Member";
            String sqlStrInsert = "INSERT INTO Member (NRIC, MemberName, Address, Email, Contact, CreditCardType, CreditCardNo, Password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            ResultSet rSet = stmt.executeQuery(sqlStrSelect);
            ResultSetMetaData rSetMetaData = rSet.getMetaData();

            this.out.println("Please wait while we verify your details");

            //Check using NRIC and Email that the newcomer has not registered before
            while(rSet.next()){
                if((rSet.getString("NRIC").equals(newMember.getNRIC()) ) ||
                    (rSet.getString("Email").equals(newMember.getEmail()) )){
                    //this.out.println("writer Visitor with this NRIC is already registered. If you forgot your password, please click here");
                    memberFound = Boolean.TRUE;
                    break;
                }
            }

            if(!memberFound){
                //Insert into table
                prepStmt = conn.prepareStatement(sqlStrInsert);
                prepStmt.setString(1, newMember.getNRIC());
                prepStmt.setString(2, newMember.getName());
                prepStmt.setString(3, newMember.getAddress());
                prepStmt.setString(4, newMember.getEmail());
                prepStmt.setString(5, newMember.getContact());
                prepStmt.setString(6, newMember.getCCType());
                prepStmt.setString(7, newMember.getCCNo());
                prepStmt.setString(8, newMember.getPassword());
                prepStmt.execute();

                regStatus = Boolean.TRUE;
            }
        }
        catch (SQLException e) {
            System.err.println("Error executing SQL command :" + e);
        }

        return regStatus;
    }//registerMember
}