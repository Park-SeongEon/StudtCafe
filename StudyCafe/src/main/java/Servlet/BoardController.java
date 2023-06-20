package Servlet;

import java.io.IOException;
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

import model.Board;
import model.Kategorie;
import service.BoardService;

@WebServlet("/board/*")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String ARTICEL_IMAGE_REPO = "D:\\file_repo";

	
	BoardService brdService;
	
	public void init(ServletConfig config) throws ServletException {
		brdService = new BoardService();
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

        if(request.getSession().getAttribute("userId") == null) {
            response.sendRedirect("/member/main.do");
            return;
        }

		
		List<Kategorie> katlist  = brdService.getMenu();
		request.setAttribute("katlist", katlist);

		int katNo = Integer.parseInt(request.getParameter("katNo"));
		request.setAttribute("katTargetNo", katNo);
		
		for(Kategorie kat : katlist)
			if(katNo == kat.getKateNo())
				request.setAttribute("katTargetName", kat.getKateName());

		
		try {
			List<Board> list = null;
			
			if(action == null) {
				String _section = request.getParameter("setion");
				String _pageNum = request.getParameter("pageNum");
				
				//페이징처리
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				
				Map<String,Integer> pagingMap = new HashMap<String,Integer>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				pagingMap.put("katNo", katNo);

				list  = brdService.getBoardList(pagingMap);

				request.setAttribute("section", section);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("list", list);
				 			
				nextPage = "/view/list.jsp";
			} else if("/list.do".equals(action)) {

				String _section = request.getParameter("setion");
				String _pageNum = request.getParameter("pageNum");
				
				//페이징처리
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				
				Map<String,Integer> pagingMap = new HashMap<String,Integer>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				pagingMap.put("katNo", katNo);

				
				list  = brdService.getBoardList(pagingMap);

				request.setAttribute("section", section);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("list", list);

				if(list.size() > 0)
					request.setAttribute("tot", list.get(0).getTotalCount());


				nextPage = "/view/list.jsp";

			} else if(action.equals("/Form.do")) {
				nextPage = "/view/modaltest.jsp";
				
			} else if (action.equals("/add.do")){
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				//String imageFileName = request.getParameter("imageFileName");
				System.out.println(title + "," + content);

				Board brd =new Board();
				brd.setTitle(title);
				brd.setContent(content);
				brd.setKateNo(katNo);
				
				brdService.save(brd);
				nextPage = "/board/list.do";
			} else if(action.equals("/view.do")){
				String no = request.getParameter("brdNo");
				Board vo = brdService.getBoardView(Integer.parseInt(no));
				request.setAttribute("info", vo);
				nextPage = "/view/view.jsp";
				
			} else if(action.equals("/mod.do")) {// 글 수정 부분 여기에 추가해 주세요
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String brdNo = request.getParameter("brdNo");

				
				Board fix =new Board();
				fix.setBrdNo(Integer.parseInt(brdNo));
				fix.setTitle(title);
				fix.setContent(content);
				brdService.save(fix);
				
				request.setAttribute("msg", fix);
				nextPage = "/view/articleForm.jsp";
				
				
				return;
			
			} else if(action.equals("/remove.do")){ // 글 삭제 부분 여기에 추가해 주세요
				brdService.removeBoard(katNo);
				
				request.setAttribute("msg", "deleted");
				nextPage = "/view/list.jsp";
				
				return;
			} else if (action.equals("/replyForm.do")) {// 댓글 쓰는 기능 여기에 추가해 주세요
				int parentNO = Integer.parseInt(request.getParameter("parentNO"));
				session = request.getSession();
				session.setAttribute("parentNO", parentNO);
				
				
				nextPage = "/view/articleForm.jsp";
			} else if (action.equals("/addReply.do")) {	//댓글 추가 부분 여기에 추가해주세요
				session = request.getSession();
				
				session.removeAttribute("parentNO");
				
				
				
				String content = request.getParameter("comContent");
				//String imageFileName = request.getParameter("imageFileName");
				System.out.println(content);

				
				
				
			
				String comment = request.getParameter("comment");
				
				
				
				nextPage = "/view/articleForm.jsp";
				return;
			}

			RequestDispatcher dis = request.getRequestDispatcher(nextPage);
			dis.forward(request, response);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}

