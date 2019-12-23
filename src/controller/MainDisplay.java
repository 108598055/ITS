package controller;

import java.sql.*;
import java.util.ArrayList;

public class MainDisplay{
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    public MainDisplay(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://140.124.181.19:3306/its_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC", "root", "root");
            statement = connection.createStatement();
        }
        catch (Exception ex) {
            System.out.println("Error: " + ex);
        }
    }

    public Integer allIssue(){
        Integer count = 0;
        try {
            resultSet = statement.executeQuery("select * from its_db.issue");
            while(resultSet.next()) {
                count = count + 1;
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public Integer toDo(){
        Integer count = 0;
        try {
            resultSet = statement.executeQuery("select * from its_db.issue");
            while(resultSet.next()) {
                if(resultSet.getString("state").equals("TO DO")) {
                    count = count + 1;
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public Integer doing(){
        Integer count = 0;
        try {
            resultSet = statement.executeQuery("select * from its_db.issue");
            while(resultSet.next()) {
                if(resultSet.getString("state").equals("DOING")) {
                    count = count + 1;
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public Integer done(){
        Integer count = 0;
        try {
            resultSet = statement.executeQuery("select * from its_db.issue");
            while(resultSet.next()) {
                if(resultSet.getString("state").equals("DONE")) {
                    count = count + 1;
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public ArrayList<String> member(){
        ArrayList<String> result = new ArrayList();
        try {
            resultSet = statement.executeQuery("select * from its_db.user");
            while(resultSet.next()) {
                String member = resultSet.getString("name");
                result.add(member);
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
}
