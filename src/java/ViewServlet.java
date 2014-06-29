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

@WebServlet(name = "ViewServlet", urlPatterns = {"/ViewServlet"})


/**
 *
 * @author spstudent
 */
public class ViewServlet extends HttpServlet {
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

        this.viewItem("");

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

    public void viewItem(String keyword) {
        //boolean memberFound = Boolean.FALSE;
        String toBePrinted="";
        try{
            //Must query the row containing the name first
            String sqlStrSelect = "SELECT * FROM CD";

            ResultSet rSet = stmt.executeQuery(sqlStrSelect);
            ResultSetMetaData rSetMetaData = rSet.getMetaData();

            this.out.println("Please wait while we retrieve our catalogue...");

            HTMLUtils itemTable = new HTMLUtils(keyword);
            //toBePrinted = itemTable.tagTable("tablefordisplay", "\n\n\n");
            //String[] dataRowArray;    //for each row of table contents to be printed
            //Do a for loop until the total columns or max-of-1-page-display is reached

            //this.out.print(toBePrinted);

            //Print column names - Some formatting needed
            for (int i = 1; i <= rSetMetaData.getColumnCount(); i++) {
                //this.out.print(rSetMetaData.getColumnName(i) + "\t");
                toBePrinted += rSetMetaData.getColumnName(i) + "\t";
            }
            toBePrinted = itemTable.tagTableHeading("headingfordisplay", toBePrinted);
            toBePrinted += "\n";
            //this.out.println();

            while(rSet.next()){
                toBePrinted += itemTable.tagTableHeading("rowfordisplay",
                //Print column contents - Some formatting needed
                (rSet.getString("Genre")) +
                (rSet.getString("Title")) +
                (rSet.getString("Singer")) +
                (rSet.getString("DYear")) +
                (rSet.getString("Tracks")) +
                (rSet.getString("TotalTime")) +
                (rSet.getString("Price")));
                toBePrinted += "\n";
            }

            this.out.println(toBePrinted);
        }
        catch (SQLException e) {
            System.err.println("Error executing SQL command :" + e);
        }

        //If no exception raised
        //writer.println("You have been successfully registered");
    }//viewItem
}
