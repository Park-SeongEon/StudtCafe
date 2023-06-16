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
import model.Board;
import model.Kategorie;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String ARTICEL_IMAGE_REPO = "D:\\file_repo";
	
	BoardDao boardDao;
	KateDao katDao;

	
	public void init(ServletConfig config) throws ServletException {
		boardDao = new BoardDao();
		katDao = new KateDao();
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

		
		
		try {
			List<Board> list = null;
			
			if(action == null) {
				
				nextPage = "/view/list.jsp";
			} else if("/main.do".equals(action)) {

;

				nextPage = "/view/list.jsp";

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
			} else if(action.equals("/remove.do")){
				String str = request.getParameter("brdNo");
				int brdNo = Integer.parseInt(str);
				boardDao.delete(brdNo);
				return;
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
