package controller;

//import com.sun.org.apache.xerces.internal.impl.dv.dtd.IDDatatypeValidator;

import java.sql.*;
import java.util.ArrayList;

public class IssueDisplay {
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    public IssueDisplay(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://140.124.181.19:3306/its_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", "root", "root");
            statement = connection.createStatement();
        }
        catch (Exception ex) {
            System.out.println("Error: " + ex);
        }
    }

    public ArrayList<Issue> toDoIssue(){
        ArrayList<Issue> result = new ArrayList();
        try {
            resultSet = statement.executeQuery("select * from its_db.issue");
            while(resultSet.next()) {
                if(resultSet.getString("state").equals("TO DO")) {
                    Issue issue = new Issue();
                    issue.id = resultSet.getInt("id");
                    issue.projectID = resultSet.getInt("projectID");
                    issue.ownerID = resultSet.getInt("ownerID");
                    issue.name = resultSet.getString("name");
                    issue.content = resultSet.getString("content");
                    issue.creatDate = resultSet.getDate("date");
                    result.add(issue);
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
    public ArrayList<Issue> doingIssue(){
        ArrayList<Issue> result = new ArrayList();
        try {
            resultSet = statement.executeQuery("select * from its_db.issue");
            while(resultSet.next()) {
                if(resultSet.getString("state").equals("DOING")) {
                    Issue issue = new Issue();
                    issue.id = resultSet.getInt("id");
                    issue.projectID = resultSet.getInt("projectID");
                    issue.ownerID = resultSet.getInt("ownerID");
                    issue.name = resultSet.getString("name");
                    issue.content = resultSet.getString("content");
                    issue.creatDate = resultSet.getDate("date");
                    issue.reply = resultSet.getString("reply");
                    result.add(issue);
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
    public ArrayList<Issue> doneIssue(){
        ArrayList<Issue> result = new ArrayList();
        try {
            resultSet = statement.executeQuery("select * from its_db.issue");
            while(resultSet.next()) {
                if(resultSet.getString("state").equals("DONE")) {
                    Issue issue = new Issue();
                    issue.id = resultSet.getInt("id");
                    issue.projectID = resultSet.getInt("projectID");
                    issue.ownerID = resultSet.getInt("ownerID");
                    issue.name = resultSet.getString("name");
                    issue.content = resultSet.getString("content");
                    issue.creatDate = resultSet.getDate("date");
                    issue.reply = resultSet.getString("reply");
                    result.add(issue);
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
}
