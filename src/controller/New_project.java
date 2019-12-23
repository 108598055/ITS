package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/call")
public class New_project extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
//    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/view/call.jsp").forward(request, response);
    }

    protected  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        //PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
//        int id = Integer.valueOf(request.getParameter("id"));
        String projectName = request.getParameter("project_name");
        String person = request.getParameter("person");

        System.out.println(projectName);
        System.out.println(person);
        if(!projectName.equals("") && !person.equals("")) {
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            try {
                connection = JdbcUtils.getconn();
                String sql = "insert into its_db.project_manage ( projectName, ownerID) values ( ?, ?);";
                preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
//            preparedStatement.setInt(1,user.getId());
                preparedStatement.setString(1, projectName);
                preparedStatement.setString(2, person);
//            preparedStatement.setString(4,user.getRole());
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                JdbcUtils.close(preparedStatement, connection);
            }
            System.out.println("新增專案成功"+projectName+"負責人"+person);
        }
        else{
            System.out.println("新增專案失敗");
        }

//        UserDAo userDAo = new UserDAo();
//        userDAo.addUser(user);
//        System.out.println("新增成功");
//        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request,response);
//        response.sendRedirect("/call");
         response.sendRedirect("/view/call.jsp");
    }
}