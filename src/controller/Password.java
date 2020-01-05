package controller;

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/view/call.jsp").forward(request, response);
    }

    protected  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String old_pass = request.getParameter("old_pass");
       String new_pass = request.getParameter("new_pass");
       String new_pass2 = request.getParameter("new_pass2");
        HttpSession session = request.getSession();
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
                    preparedStatement.setString(1, new_pass);
                    preparedStatement.setString(2, (String)session.getAttribute("username"));
                    preparedStatement.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    JdbcUtils.close(preparedStatement, connection);
                }
                System.out.println("修改密碼成功");
                out.print("<meta http-equiv='refresh' content='2;url=/login' /><body >\n" +
                        "<div style=\"font-size:2em; font-family:DFKai-sb;\" >更改密碼成功</div>\n" +
                        "</body>");
                session.invalidate();
            }
            else {
                System.out.println("兩次密碼不同");
                out.print("<meta http-equiv='refresh' content='2;url=/view/call.jsp' /><body >\n" +
                        "<div style=\"font-size:2em; font-family:DFKai-sb;\" >確認密碼輸入錯誤</div>\n" +
                        "</body>");
            }
        }
        else {
            System.out.println("原始密碼錯誤");
            out.print("<meta http-equiv='refresh' content='2;url=/view/call.jsp' /><body >\n" +
                    "<div style=\"font-size:2em; font-family:DFKai-sb;\" >原始密碼輸入錯誤</div>\n" +
                    "</body>");
        }
    }
}
