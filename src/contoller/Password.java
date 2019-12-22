package contoller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/password")
public class Password extends HttpServlet {
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
        String old_pass = request.getParameter("old_pass");
       String new_pass = request.getParameter("new_pass");
       String new_pass2 = request.getParameter("new_pass2");

//        System.out.println(projectName);
        HttpSession session = request.getSession();
//        System.out.println(person);
//        if(!projectName.equals("") && !person.equals("")) {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if(session.getAttribute("user_pass").equals(old_pass)) {
            if(new_pass.equals(new_pass2)) {
                Connection connection = null;
                PreparedStatement preparedStatement = null;
                try {
                    connection = JdbcUtils.getconn();

                    String sql = "update its_db.user set password = ? where name = ?";
                    preparedStatement = (PreparedStatement) connection.prepareStatement(sql);
//            preparedStatement.setInt(1,user.getId());
                    preparedStatement.setString(1, new_pass);
                    preparedStatement.setString(2, (String)session.getAttribute("username"));
//                    preparedStatement.setString(2, person);
//            preparedStatement.setString(4,user.getRole());
                    preparedStatement.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    JdbcUtils.close(preparedStatement, connection);
                }
                System.out.println("修改密碼成功");
                session.invalidate();
                response.sendRedirect("/login");
            }
            else {
                System.out.println("兩次密碼不同");

//out.print("<div>There is some text here</div>");
//                response.sendRedirect("/view/call.jsp");
                out.print("<meta http-equiv='refresh' content='3;url=/view/call.jsp' /><body >\n" +
                        "<div style=\"font-size:2em; font-family:DFKai-sb;\" >確認密碼輸入錯誤</div>\n" +
                        "</body>");
            }
//        }
        }
        else {
            System.out.println("現在密碼錯誤");
            out.print("<meta http-equiv='refresh' content='3;url=/view/call.jsp' /><body >\n" +
                    "<div style=\"font-size:2em; font-family:DFKai-sb;\" >原始密碼輸入錯誤</div>\n" +
                    "</body>");
        }
//        else{
//            System.out.println("新增專案失敗");
//        }

//        UserDAo userDAo = new UserDAo();
//        userDAo.addUser(user);
//        System.out.println("新增成功");
//        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request,response);
//        response.sendRedirect("/call");

    }
}
