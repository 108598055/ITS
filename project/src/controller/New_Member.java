package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/newmember")
public class New_Member extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/view/main.jsp").forward(request, response);
    }

    protected  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("pjid"));
        String projectName = request.getParameter("pjname");
        int member = 0;
        if(request.getParameter("member") != null) {
            member = Integer.parseInt(request.getParameter("member"));
        }
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        if(member != 0) {
            try {
                connection = JdbcUtils.getconn();
                String sql = "insert into its_db.project (id, name, memberID) values (?, ?, ?)";
                preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
                preparedStatement.setInt(1, id);
                preparedStatement.setString(2, projectName);
                preparedStatement.setInt(3, member);
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                JdbcUtils.close(preparedStatement, connection);
            }
        }
        response.sendRedirect("/view/main.jsp");
    }
}