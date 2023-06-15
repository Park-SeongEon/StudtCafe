package Servlet;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/board/*")
public class BoardController extends HttpServlet {
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

		int katNo = Integer.parseInt(request.getParameter("katNo"));
		request.setAttribute("katTargetNo", katNo);
		
		try {
			List<Board> list = null;
			
			if(action == null) {
				
				/*페이징처리
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				
				Map<String,Integer> pagingMap = new HashMap<String,Integer>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				Map<String,Object> map = boardService.listArticleVO(pagingMap);
				map.put("section", section);
				map.put("pageNum", pageNum);
				request.setAttribute("map", map);
				 */ 				
	
				list = boardDao.selectAll(katNo);
				request.setAttribute("list", list);

				nextPage = "/view/list.jsp";
			} else if("/list.do".equals(action)) {

				String _section = request.getParameter("setion");
				String _pageNum = request.getParameter("pageNum");


				/*
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				
				Map<String,Integer> pagingMap = new HashMap<String,Integer>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				Map<String,Object> map = boardService.listArticleVO(pagingMap);
				map.put("section", section);
				map.put("pageNum", pageNum);				
				request.setAttribute("map", map);
				*/
				list = boardDao.selectAll(katNo);
				
				request.setAttribute("list", list);
				
				nextPage = "/view/list.jsp";

			} else if(action.equals("/Form.do")) {
				nextPage = "/view/articleForm.jsp";
				
			} else if (action.equals("/add.do")){
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String imageFileName = request.getParameter("imageFileName");
				System.out.println(title + "," + content);

				Board brd =new Board();
				brd.setTitle(title);
				brd.setContent(content);
				brd.setKateNo(katNo);
				boardDao.create(brd);
				nextPage = "/board/list.do";
			} else if(action.equals("/view.do")){
				String no = request.getParameter("brdNO");
				Board vo = boardDao.selectById(Integer.parseInt(no));
				request.setAttribute("vo", vo);
				nextPage = "/view/view.jsp";
			} else if(action.equals("/mod.do")) {// 글 수정 부분 여기에 추가해 주세요


				return;
			} else if(action.equals("/remove.do")){ // 글 삭제 부분 여기에 추가해 주세요
				
				
				String str = request.getParameter("brdNo");
				int brdNo = Integer.parseInt(str);
				boardDao.delete(brdNo);
				return;
			} else if (action.equals("/replyForm.do")) {// 댓글 쓰는 기능 여기에 추가해 주세요
				
			} else if (action.equals("/addReply.do")) {	//댓글 추가 부분 여기에 추가해주세요
				return;
			}

			RequestDispatcher dis = request.getRequestDispatcher(nextPage);
			dis.forward(request, response);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
