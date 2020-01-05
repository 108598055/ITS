package controller;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;

public class MainDisplay{
    Connection connection = null;
    Statement statement = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    ResultSet resultSet1 = null;
    String sql;
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
//            ResultSet resultSet1 = null;
            GetParameter getParameter = new GetParameter();
//            Connection connection = null;
//            PreparedStatement preparedStatement = null;
//            ResultSet resultSet = null;
            connection = JdbcUtils.getconn();
            sql = "select * from its_db.project_manage where projectName = ?";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1,getParameter.projectname);
            resultSet1 = preparedStatement.executeQuery();
//            resultSet1 = statement.executeQuery("select * from its_db.project_manage where projectName = " + getParameter.projectname);
            if(resultSet1.next()) {
                sql = "select * from its_db.issue where projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setInt(1, resultSet1.getInt(1));
                resultSet = preparedStatement.executeQuery();
//                resultSet = statement.executeQuery("select * from its_db.issue where projectID = " + resultSet1.getInt(1));
//                if(resultSet1.getString(4)!=null) {
                    while (resultSet.next()) {
                        count = count + 1;
                    }
//                }
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
//            resultSet = statement.executeQuery("select * from its_db.issue");
            GetParameter getParameter = new GetParameter();
//            Connection connection = null;
//            PreparedStatement preparedStatement = null;
//            ResultSet resultSet = null;
            connection = JdbcUtils.getconn();
            sql = "select * from its_db.project_manage where projectName = ?";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1,getParameter.projectname);
            resultSet1 = preparedStatement.executeQuery();
//            resultSet1 = statement.executeQuery("select * from its_db.project_manage where projectName = " + getParameter.projectname);
            if(resultSet1.next()) {
                sql = "select * from its_db.issue where projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setInt(1, resultSet1.getInt(1));
                resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    if (resultSet.getString("state").equals("TO DO")) {
                        count = count + 1;
                    }
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
//            resultSet = statement.executeQuery("select * from its_db.issue");
            GetParameter getParameter = new GetParameter();
//            Connection connection = null;
//            PreparedStatement preparedStatement = null;
//            ResultSet resultSet = null;
            connection = JdbcUtils.getconn();
            sql = "select * from its_db.project_manage where projectName = ?";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1,getParameter.projectname);
            resultSet1 = preparedStatement.executeQuery();
//            resultSet1 = statement.executeQuery("select * from its_db.project_manage where projectName = " + getParameter.projectname);
            if(resultSet1.next()) {
                sql = "select * from its_db.issue where projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setInt(1, resultSet1.getInt(1));
                resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    if (resultSet.getString("state").equals("DOING")) {
                        count = count + 1;
                    }
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
            GetParameter getParameter = new GetParameter();
            connection = JdbcUtils.getconn();
            sql = "select * from its_db.project_manage where projectName = ?";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1,getParameter.projectname);
            resultSet1 = preparedStatement.executeQuery();
            if(resultSet1.next()) {
                sql = "select * from its_db.issue where projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setInt(1, resultSet1.getInt(1));
                resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    if (resultSet.getString("state").equals("DONE")) {
                        count = count + 1;
                    }
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public ArrayList<String> member(){
//        HttpSession session = request.getSession();
        ArrayList<String> result = new ArrayList();
        try {
            resultSet = statement.executeQuery("select * from its_db.user");
            while(resultSet.next()) {
                int id = resultSet.getInt(1);
                String member = resultSet.getString("name");
                GetParameter getParameter = new GetParameter();
                connection = JdbcUtils.getconn();
                String sql = "select * from its_db.project where name = ? and memberID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setString(1, getParameter.projectname);
                preparedStatement.setInt(2, id);
                ResultSet resultSet2 = null;
                resultSet2 = preparedStatement.executeQuery();
                while(resultSet2.next()) {
                    result.add(member);
                }
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
}
