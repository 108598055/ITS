package contoller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JdbcUtils {
    private static String url = null;
    private static String user = null;
    private static String password = null;
    private static String dv = null;

    static{
        Properties prop = new Properties();
        InputStream in = JdbcUtils.class.getResourceAsStream("/a.properties");//不能是a.properties，因為在IDEA中檔名字就是a,與eclipse不同

        try {
            //以下四步避免了以後資料庫名字等資訊改變後來修改原始碼
            prop.load(in);
            url = prop.getProperty("url");
            user = prop.getProperty("user");
            password = prop.getProperty("password");
            dv = prop.getProperty("driver");

            //註冊驅動
            Class.forName(dv);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getconn() throws SQLException {
        Connection connection = DriverManager.getConnection(url, user, password);
        return connection;
    }

    public static void close(Statement statement, Connection connection){
        if(statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(connection != null){
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void close(PreparedStatement preparedStatement, Connection connection, ResultSet result) {
        if(preparedStatement != null){
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(connection != null){
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(result != null){
            try {
                result.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
