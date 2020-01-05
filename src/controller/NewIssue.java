package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.*;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/newissue")
public class NewIssue extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/view/call.jsp").forward(request, response);
    }

    protected  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int projectid = Integer.parseInt(request.getParameter("pjid"));
        int ownerID = Integer.parseInt(request.getParameter("ownerid"));
        String name = request.getParameter("newname");
        String content = request.getParameter("newcontent");

        if(!name.equals("") && !content.equals("")) {
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            try {
                connection = JdbcUtils.getconn();
                String sql = "insert into its_db.issue ( projectid, ownerID,name,content,date,state) values (?,?,?,?,?,?);";
                preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
                preparedStatement.setInt(1, projectid);
                preparedStatement.setInt(2, ownerID);
                preparedStatement.setString(3, name);
                preparedStatement.setString(4, content);
                preparedStatement.setDate(5, Date.valueOf(LocalDate.now().plusDays(1)));
                preparedStatement.setString(6, "TO DO");

                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                JdbcUtils.close(preparedStatement, connection);
            }
        }
        else{
            System.out.println("新增議題失敗");
        }
        response.sendRedirect("/view/issue.jsp");
    }
}