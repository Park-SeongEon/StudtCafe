package Servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.BoardDao;
import dao.KateDao;
import dao.UserDao;
import model.Board;
import model.Kategorie;
import model.User;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String ARTICEL_IMAGE_REPO = "D:\\file_repo";
	
	BoardDao boardDao;
	KateDao katDao;
	UserDao dao; 

	
	public void init(ServletConfig config) throws ServletException {
		boardDao = new BoardDao();
		katDao = new KateDao();
		dao = new UserDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session;
		String action = request.getPathInfo();
		
		
		List<Kategorie> katlist  = katDao.selectAll();
		request.setAttribute("katlist", katlist);

		
		int katNo = Integer.parseInt(request.getParameter("katNo"));
		request.setAttribute("katTargetNo", katNo);

		try {
			List<Board> list = null;
			List<User> userlist = null;

			
			if(action == null) {
				list = boardDao.selectAll(katNo);
				request.setAttribute("list", list);
				
				nextPage = "/view/list.jsp";
			} else if("/list.do".equals(action)) {            // 공지사항

				list = boardDao.selectAll(katNo);
				request.setAttribute("list", list);

				nextPage = "/view/admin_list.jsp";

			} else if(action.equals("/memberlist.do")) {      // 회원목록
				userlist = dao.selectAll();
				request.setAttribute("list", list);
				nextPage = "/view/listMembers.jsp";
				
			} else if(action.equals("/Form.do")) {
				nextPage = "/view/Form.jsp";
				
			} else if (action.equals("/add.do")){
				
			} else if(action.equals("/view.do")){
				String no = request.getParameter("brdNO");
				Board vo = boardDao.selectById(Integer.parseInt(no));
				request.setAttribute("vo", vo);
				nextPage = "/view/view.jsp";
				
			} else if(action.equals("/mod.do")) {


				return;
			} else if(action.equals("/remove.do")){            // 회원 삭제
				String str = request.getParameter("id");
				dao.delete(str);
				request.setAttribute("msg", "delete");
				nextPage="/admin/memberlist.do";
				
			} else if(action.equals("/remove2.do")){            // 공지사항 삭제
				String no = request.getParameter("brd_no");
				int brdNo= Integer.parseInt(no);
				boardDao.delete(brdNo);
				nextPage="/admin/list.do";
				
			} else if (action.equals("/replyForm.do")) {
				
			} else if (action.equals("/addReply.do")) {
				return;
			}

			RequestDispatcher dis = request.getRequestDispatcher(nextPage);
			dis.forward(request, response);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
