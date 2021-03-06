package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/view/register.jsp").forward(request, response);
    }

    protected  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        //PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("name");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setName(username);
        user.setPassword(password);
        user.setRole(role);
        UserDAo userDAo = new UserDAo();
        userDAo.addUser(user);
        System.out.println("註冊成功");
        PrintWriter out = response.getWriter();
//        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request,response);
        out.print("<meta http-equiv='refresh' content='2;url=/register' /><body >\n" +
                        "<div style=\"font-size:2em; font-family:DFKai-sb;\" >註冊成功</div>\n" +
                        "</body>");
//        response.sendRedirect("/register");
    }
}
