/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.*;
//import java.io.IOException;
import java.io.PrintWriter;

//import java.sql.*;

/**
 *
 * @author spstudent
 */
public class HTMLUtils {
    //Constants

    //Class variables and methods prototype

    //Instance variables and methods prototype

    //Constructor
    HTMLUtils(String title){
        String htmlString = title;
    }

    //Instance methods
    public String tagTable(String cssClass, String content){
        String classTag = "";
        String tagged = "";

        if(!(cssClass.equals (""))){
            classTag = " class = \"" + cssClass + "\"";
        }
        tagged = "<table" + classTag + ">" + "\n" + content + "\n" + "</table>";
        return tagged;
    }

    public String tagTableRow(String cssClass, String content){
        String classTag = "";
        String tagged = "";

        if(!(cssClass.equals (""))){
            classTag = " class = \"" + cssClass + "\"";
        }
        tagged = "<tr" + classTag + ">" + "\n" + content + "\n" + "</tr>";
        return tagged;
    }

    public String tagTableHeading(String cssClass, String content){
        String cssClassTag = "";
        String tagged = "";

        if(!(cssClass.equals (""))){
            cssClassTag = " class = \"" + cssClass + "\"";
        }
        tagged = "<th" + cssClassTag + ">" + content + "</th>" + "\n";
        return tagged;
    }

    public String tagTableData(String cssClass, String content){
        String classTag = "";
        String tagged = "";

        if(!(cssClass.equals (""))){
            classTag = " class = \"" + cssClass + "\"";
        }
        tagged = "<td" + classTag + ">" + content + "</td>" + "\n";
        return tagged;
    }

}
