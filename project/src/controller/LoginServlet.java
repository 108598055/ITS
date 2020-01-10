package controller;

//import javax.jws.WebService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        session.invalidate();
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserDAo userDAo = new UserDAo();
        User user = userDAo.login(username,password);
        if(user != null){
            int id = userDAo.login_user(username, password);
            String role = userDAo.login_user_role(username, password);
            HttpSession session = request.getSession();
            session.setAttribute("username",username);
            session.setAttribute("user_pass", password);
            session.setAttribute("userid", id);
            session.setAttribute("user_role", role);
//            request.getRequestDispatcher("/view/call.jsp").forward(request,response);
            response.sendRedirect("/call");
        }
        else {
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        }
    }
}
