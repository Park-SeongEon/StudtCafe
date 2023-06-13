package Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.User;



@WebServlet("/member/*")
public class UserConroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDao userdao;   
	
    public UserConroller() {
        super();
    }
    
	@Override
	public void init() throws ServletException {
		
		userdao = new UserDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		String action = request.getPathInfo();		
		
		if(action == null || "list.do".equals(action))
		{
			List<User> memList = userdao.selectAll();
			request.setAttribute("memList", memList);
			nextPage = "/view/member.jsp";
			
		} else if (action.equals("/add.do")){
			User vo = new User();

			

			nextPage = "/member/list.do";
			
		} else if(action.equals("/memberForm.do")) {
			nextPage = "/view/memberForm.jsp";
			
		}else if(action.equals("/modForm.do")) {
			String id = request.getParameter("id");
			User vo = userdao.selectById(id);
			request.setAttribute("info", vo);
			nextPage = "/view/modMemberForm.jsp";
		} else if(action.equals("/mod.do")) {
			User vo = new User();

			
			
			

			userdao.update(vo);
			nextPage = "/member/list.do";			
		} else if(action.equals("/del.do")) {
			String id = request.getParameter("id");
			User vo = userdao.selectById(id);
			userdao.delete(vo);
			request.setAttribute("msg", "del");
			nextPage = "/member/list.do";			
		}
		else {
			List<User> memList = userdao.selectAll();
			request.setAttribute("memList", memList);
			nextPage = "/view/member.jsp";
			
		}

		RequestDispatcher dis = request.getRequestDispatcher(nextPage);
		dis.forward(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}


}
