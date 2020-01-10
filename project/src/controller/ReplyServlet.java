package controller;

//import javax.jws.WebService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

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
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = JdbcUtils.getconn();
            if(state.equals("DONE")) {
                String sql = "update its_db.issue set state = ? , reply = ? ,endDate =? where id = ?";
                preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
                preparedStatement.setString(1, state);
                preparedStatement.setInt(4, pjid);
                preparedStatement.setString(2, content);
                preparedStatement.setDate(3, Date.valueOf(LocalDate.now().plusDays(1)));
            }
            else {
                String sql = "update its_db.issue set state = ?, reply = ? where id = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setString(1, state);
                preparedStatement.setString(2, content);
                preparedStatement.setInt(3, pjid);
            }
            preparedStatement.executeUpdate();
            response.sendRedirect("/view/issue.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            JdbcUtils.close(preparedStatement,connection);
        }
    }
}
