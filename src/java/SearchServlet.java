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
import javax.servlet.http.*;
//import javax.swing.JOptionPane;

@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})


/**
 *
 * @author spstudent
 */
public class SearchServlet extends HttpServlet {
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

        String key = request.getParameter("itemKeyword");
        String attribute = request.getParameter("itemAttribute");
        this.searchItem(attribute, key);

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

    public void searchItem(String attr, String keyword) {
        boolean itemFound = Boolean.FALSE;
        String sqlStrSubQuery, strVar = "";
        try{
            //Query the rows of CD table
            String sqlStrSelect = "SELECT * FROM CD";

            if(attr.equals("artist")){
                out.println("attr equals artist");
                sqlStrSubQuery = " WHERE Singer LIKE ?";
                strVar = "%"+keyword+"%";
            }else if (attr.equals("year")){
                out.println("attr equals year");
                sqlStrSubQuery = " WHERE DYear = ?";
                strVar = keyword;
            }else if (attr.equals("title")){
                out.println("attr equals title");
                sqlStrSubQuery = " WHERE Title LIKE ?";
                strVar = "%"+keyword+"%";
            }else{
                out.println("attr equals else");
                sqlStrSubQuery = " WHERE Title LIKE ?";
                strVar = "%"+keyword+"%";
            }

            prepStmt = conn.prepareStatement(sqlStrSelect + sqlStrSubQuery);
            //this.out.println(strVar);
            prepStmt.setString(1, strVar);
            ResultSet rSet = prepStmt.executeQuery();
            ResultSetMetaData rSetMetaData = rSet.getMetaData();

            this.out.println("Please wait while we execute your query");
            //Print column names - Some formatting needed
            //for (int i = 1; i <= rSetMetaData.getColumnCount(); i++) {
            //    writer.print(rSetMetaData.getColumnName(i) + "\t");
            //}
            //writer.println();

            while(rSet.next()){
                //Print column contents - Some formatting needed
                this.out.print(rSet.getString("Genre"));
                this.out.print(rSet.getString("Title"));
                this.out.print(rSet.getString("Singer"));
                this.out.print(rSet.getString("DYear"));
                this.out.print(rSet.getString("Tracks"));
                this.out.print(rSet.getString("TotalTime"));
                this.out.print(rSet.getString("Price"));
                this.out.println();
            }
        }
        catch (SQLException e) {
            System.err.println("Error executing SQL command :" + e);
        }

        //If no exception raised
        //writer.println("You have been successfully registered");
    }// searchItem
    
    private boolean contains(String mainString, String subString){
        return(mainString.indexOf(subString) != -1);
    }
}
