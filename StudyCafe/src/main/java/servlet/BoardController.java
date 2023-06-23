package servlet;

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

import com.google.gson.Gson;

import model.Board;
import model.Comment;
import model.Kategorie;
import service.BoardService;

@WebServlet("/board/*")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	private static String ARTICEL_IMAGE_REPO = "D:\\file_repo";

	
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
		String action = request.getPathInfo();

        if(request.getSession().getAttribute("userId") == null) {
            response.sendRedirect("/member/main.do");
            return;
        }

		
		List<Kategorie> katlist  = brdService.getMenu();
		request.setAttribute("katlist", katlist);

		
		String strKatNo = request.getParameter("katNo");
		int katNo = -1;
		if(strKatNo != null) {
			katNo = Integer.parseInt(strKatNo);
			request.setAttribute("katTargetNo", katNo);
		}
			
		for(Kategorie kat : katlist)
			if(katNo == kat.getKateNo())
				request.setAttribute("katTargetName", kat.getKateName());

		
		try {
			List<Board> list = null;
			
			if(action == null) {
				String _section = request.getParameter("setion");
				String _pageNum = request.getParameter("pageNum");
				String searchId = request.getParameter("searchId");
				String searchText = request.getParameter("searchText");

				
				//페이징처리
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));

				Map<String,Object> pagingMap = new HashMap<String,Object>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				pagingMap.put("katNo", katNo);
				pagingMap.put("searchId", searchId);
				pagingMap.put("searchText", searchText);

				if(searchId != null)
					list  = brdService.getBoardSearchList(pagingMap);
				else 
					list  = brdService.getBoardList(pagingMap);

				request.setAttribute("section", section);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("list", list);
				 			
				nextPage = "/view/board/board.jsp";
			} else if("/list.do".equals(action)) {

				String _section = request.getParameter("setion");
				String _pageNum = request.getParameter("pageNum");
				String searchId = request.getParameter("searchId");
				String searchText = request.getParameter("searchText");

				
				//페이징처리
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				
				Map<String,Object> pagingMap = new HashMap<String,Object>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				pagingMap.put("katNo", katNo);
				pagingMap.put("searchId", searchId);
				pagingMap.put("searchText", searchText);

				
				list  = brdService.getBoardList(pagingMap);

				request.setAttribute("section", section);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("list", list);
				pagingMap.put("katNo", 1);	// 게시판 ID 설정

				//게시판 내용 불러오기
				List<Board> noticelist  = brdService.getBoardList(pagingMap);  // 게시판 리스트와 총건수를 받음
				request.setAttribute("noticelist", noticelist); 

				
				if(list.size() > 0)
					request.setAttribute("tot", list.get(0).getTotalCount());


				nextPage = "/view/board/board.jsp";

			} else if("/searchlist.do".equals(action)) {

				// 페이징 값 세팅
				String _section = request.getParameter("setion");  // request getParameter을 통해 jsp setion 값 가져오기. prev, next 값으로 그 페이지로 이동
				String _pageNum = request.getParameter("pageNum"); // request getParameter을 통해 jsp pageNum 값 가져오기. 현재 페이지 번호
				String searchId = request.getParameter("searchId"); //검색 속성 제목인이 유저인지 등
				String searchText = request.getParameter("searchText"); // 검색어

				
				//페이징 값 int 값으로 변환
				int section = Integer.parseInt(((_section == null) ? "1" : _section)); // _section 값 확인하여 값이 존재하지 않을 시 1로 세팅
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum)); // _pageNum 값 확인하여 값이 존재하지 않을 시 1로 세팅
				
				//매개변수로 페이징, 검색 값설정
				Map<String,Object> pagingMap = new HashMap<String,Object>();
				pagingMap.put("section", section); // 검색할때 페이징 처리를 위해 "section"에 section값을  세팅
				pagingMap.put("pageNum", pageNum); // 검색할때 페이징 처리를 위해  "pageNum"에 pageNum값을  세팅
				pagingMap.put("katNo", katNo);	// 게시판 ID 설정
				pagingMap.put("searchId", searchId); // 검색 속성 설정
				pagingMap.put("searchText", searchText); //검색어 설정

				//게시판 내용 불러오기
				list  = brdService.getBoardSearchList(pagingMap);  // 게시판 리스트와 총건수를 받음

				pagingMap.put("katNo", 1);	// 게시판 ID 설정

				//게시판 내용 불러오기
				List<Board> noticelist  = brdService.getBoardSearchList(pagingMap);  // 게시판 리스트와 총건수를 받음
				request.setAttribute("noticelist", noticelist); 
				
				
				//jsp에 페이징값 세팅
				request.setAttribute("section", section);
				request.setAttribute("pageNum", pageNum);

				//최신 글 세팅
				request.setAttribute("list", list); 

				
				//총건수 세팅
				if(list.size() > 0)
					request.setAttribute("tot", list.get(0).getTotalCount());

				//view 설정
				nextPage = "/view/board/list.jsp";

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
				brd.setUserId((String)request.getSession().getAttribute("userId"));
				
				brdService.save(brd);
				nextPage = "/board/list.do";
			}else if (action.equals("/save.do")){
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String brdNo = request.getParameter("brdNo");

				//String imageFileName = request.getParameter("imageFileName");
				System.out.println(title + "," + content);

				Board brd =new Board();
				brd.setTitle(title);
				brd.setContent(content);
				brd.setKateNo(katNo);
				brd.setUserId((String)	request.getSession().getAttribute("userId"));
				brd.setBrdNo(Integer.parseInt(brdNo));
				brdService.save(brd);
				nextPage = "/board/list.do";
				
			} else if(action.equals("/view.do")){
				String no = request.getParameter("brdNo");
				brdService.CntUpdate(Integer.parseInt(no));
				Board vo = brdService.getBoardView(Integer.parseInt(no));
				request.setAttribute("info", vo);
				List<Comment> comlist= brdService.getCommentList(Integer.parseInt(no));
				
				request.setAttribute("list", comlist);

				nextPage = "/view/board/view.jsp";
				
			} else if(action.equals("/mod.do")) {// 글 수정 부분 여기에 추가해 주세요
				String brdNo = request.getParameter("brdNo");

				Board fix = brdService.getBoardView(Integer.parseInt(brdNo));
				request.setAttribute("info", fix);
				
				request.setAttribute("update", fix);
				nextPage = "/view/board/viewmod.jsp";
				
			} else if(action.equals("/remove.do")){  // 게시판 삭제								  
			    String str = request.getParameter("brdNo");
			    
			    int brdNo = Integer.parseInt(str);
			    
			    brdService.removeBoard(brdNo);   
			    nextPage="/board/list.do";
				
				
			} else if (action.equals("/replyForm.do")) {// 댓글 쓰는 기능 여기에 추가해 주세요
				
				
				
				nextPage = "/board/view.do";
			} else if (action.equals("/addReply.do")) {	//댓글 추가 부분 여기에 추가해주세요
				int brdNo = Integer.parseInt(request.getParameter("brdNo"));
				String content = request.getParameter("content");

				Comment comment = new Comment();
				
				comment.setBrdNo(brdNo);
				comment.setComContent(content);
				comment.setUserId((String)request.getSession().getAttribute("userId"));

				brdService.saveComment(comment);
				
				request.setAttribute("brdNo", brdNo);
				
				nextPage = "/board/view.do";
			} else if ("/Updatevote.do".equals(action)) {
				PrintWriter out = response.getWriter();
				String brdNo = request.getParameter("brdNo");

				Board brd =new Board();
				brd.setUserId((String)request.getSession().getAttribute("userId"));
				brd.setBrdNo(Integer.parseInt(brdNo));

				//추천 표시
				int check = brdService.VoteUpdate(brd); // 추천 여부 확인
				int voteCnt = brdService.getVote(brd.getBrdNo()); // 추천 카운트 가져오기

		        // Map. 추천 정보 세팅
		        Map<String, Integer> map = new HashMap<>();
		        map.put("check", check);
		        map.put("voteCnt", voteCnt);
		 
		        // Map -> Json 문자열
		        Gson gson = new Gson();
		        String jsonStr = gson.toJson(map);
				
		        //ajax로 전달
				out.print(jsonStr);				
				
				return;
			} 
			

			RequestDispatcher dis = request.getRequestDispatcher(nextPage);
			dis.forward(request, response);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}

