package controller;

//import javax.jws.WebService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/reply")
public class ReplyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("view/issue.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int pjid = Integer.parseInt(request.getParameter("pjid"));
        String content = request.getParameter("content");
        String state = request.getParameter("state");
        System.out.println(pjid);
        System.out.println(state);
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = JdbcUtils.getconn();
            String sql = "update its_db.issue set state = ? , reply = ? where id = ?";
//            statement = connection.createStatement();
//            resultSet = statement.executeQuery(sql);
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1,state);
            preparedStatement.setInt(3,pjid);
            preparedStatement.setString(2,content);
            preparedStatement.executeUpdate();
            response.sendRedirect("/view/issue.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            JdbcUtils.close(preparedStatement,connection);
//            JdbcUtils.close(statement,connection);
        }
    }
}
