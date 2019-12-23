package controller;

import java.sql.*;

public class UserDAo {
    //資料庫連線物件
    //此方法用於在資料庫中查詢資訊並與Login.jsp表格中所填資訊比較，若資料庫中存在
    //與表格所填資料一一對應相等，則登陸成功，否則登入失敗
    public User login(String username, String password){
        User u = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
//        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = JdbcUtils.getconn();
            String sql = "select * from its_db.user where binary name=? and binary password=?";
//            statement = connection.createStatement();
//            resultSet = statement.executeQuery(sql);
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,password);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                u = new User();
                u.setName(resultSet.getString("name"));
                u.setPassword(resultSet.getString("password"));
                System.out.println("登入成功");
            }
            else{
                System.out.println("使用者名稱或者密碼錯誤");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            JdbcUtils.close(preparedStatement,connection);
//            JdbcUtils.close(statement,connection);
        }
        return u;
    }

    public int login_user(String username, String password) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int id = 0;
        try {
            connection = JdbcUtils.getconn();
            String sql = "select * from its_db.user;";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                if(username.equals(resultSet.getString(2)) && password.equals(resultSet.getString(3))) {
                    id = resultSet.getInt(1);
                }
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        } finally{
            JdbcUtils.close(preparedStatement,connection);
        }
        return id;
    }

    public String login_user_role(String username, String password) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String id = "";
        try {
            connection = JdbcUtils.getconn();
            String sql = "select * from its_db.user;";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                if(username.equals(resultSet.getString(2)) && password.equals(resultSet.getString(3))) {
                    id = resultSet.getString(4);
                }
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        } finally{
            JdbcUtils.close(preparedStatement,connection);
        }
        return id;
    }

    //此方法實現註冊功能，向資料庫中寫入新使用者的資訊
    public void addUser(User user){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = JdbcUtils.getconn();
            String sql = "insert into its_db.user (name, password, role) values (?, ?, ?);";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getRole());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            JdbcUtils.close(preparedStatement,connection);
        }

    }

}