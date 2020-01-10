package controller;

//import javax.jws.WebService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
import java.sql.*;

@WebServlet("/pjnameget")
public class GetParameter extends HttpServlet {
    static String projectname;
    static int pjid;
    Connection connection = null;
    ResultSet resultSet = null;
    PreparedStatement preparedStatement = null;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        projectname = request.getParameter("key");

        try {
            connection = JdbcUtils.getconn();
            String sql = "select * from its_db.project_manage where projectName = ?";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setString(1, projectname);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()) {
                pjid = resultSet.getInt(1);
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }

        HttpSession session = request.getSession();
        session.setAttribute("projectname", projectname);
        session.setAttribute("pjid", pjid);
        response.sendRedirect("/view/tree_view.jsp");
    }
}
