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
import model.User;
import service.AdminService;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	private static String ARTICEL_IMAGE_REPO = "D:\\file_repo";

	AdminService adminService;
	
	public void init(ServletConfig config) throws ServletException {
		adminService = new AdminService();
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

		String action = request.getPathInfo(); // url 확인

		
		// 관리자 계정만 접근
        if(!request.getSession().getAttribute("userId").equals("admin")) {   
            response.sendRedirect("/main/main.do");
            return;
        }

		
		// 로그인 되어 있지 않다면 로그인 페이지로 이동
        if(request.getSession().getAttribute("userId") == null) {   
            response.sendRedirect("/member/main.do");
            return;
        }
		
		//메뉴 가져오기
		List<Kategorie> katlist  = adminService.getMenu();
		request.setAttribute("katlist", katlist); // 메뉴 세팅

		
		int katNo = Integer.parseInt(request.getParameter("katNo"));
		request.setAttribute("katTargetNo", katNo);
		
		String KatName = katNo == 1 ? "공지사항" : "회원목록";
		request.setAttribute("katTargetName", KatName);

		
		try {
			List<Board> list = null;
			List<User> userlist = null;

			
			if(action == null) {
				String _section = request.getParameter("setion");
				String _pageNum = request.getParameter("pageNum");
				
				//페이징처리
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				
				Map<String,Object> pagingMap = new HashMap<String,Object>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);

				list  = adminService.getBoardList(pagingMap);

				request.setAttribute("section", section);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("list", list);
			
				nextPage = "/view/notices/admin_list.jsp";
			} else if("/list.do".equals(action)) {            // 공지사항

				String _section = request.getParameter("setion");
				String _pageNum = request.getParameter("pageNum");
				
				//페이징처리
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				
				Map<String,Object> pagingMap = new HashMap<String,Object>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				pagingMap.put("katNo", katNo);
				
				list  = adminService.getBoardList(pagingMap);

				request.setAttribute("section", section);
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("list", list);

				nextPage = "/view/notices/admin_list.jsp";

			} else if(action.equals("/memberlist.do")) {      // 회원목록
				userlist = adminService.getUserList();
				request.setAttribute("list", userlist);
				nextPage = "/view/member/listMembers.jsp";
				
			} else if(action.equals("/kate.do")) {            // 카테고리
				katlist = adminService.getKateList();
				request.setAttribute("list", katlist);
				nextPage = "/view/notices/kate.jsp";
				
			}else if(action.equals("/Form.do")) {
				nextPage = "/view/Form.jsp";
				
			} else if (action.equals("/add.do")){			  // 글 작성
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				
				Board brd =new Board();
				brd.setTitle(title);
				brd.setContent(content);
				brd.setKateNo(katNo);
				brd.setUserId((String)request.getSession().getAttribute("userId"));
				
				
				adminService.save(brd);
				
				nextPage = "/admin/list.do";
			} else if (action.equals("/katadd.do")){		  // 카테고리 작성
				String kateName = request.getParameter("kateName");
				String kateDetail = request.getParameter("kateDetail");
				
				Kategorie kat = new Kategorie();
				kat.setKateName(kateName);
				kat.setKateDetail(kateDetail);
				
				adminService.savekat(kat);
				
				nextPage = "/admin/kate.do";
			}else if(action.equals("/view.do")){
				String no = request.getParameter("brdNo");
				Board vo = adminService.getBoardView(Integer.parseInt(no));
				request.setAttribute("info", vo);
				adminService.CntUpdate(vo.getBrdNo());
				vo.setCnt(vo.getCnt()+1);
				List<Comment> comlist= adminService.getCommentList(Integer.parseInt(no));
				request.setAttribute("list", comlist);
				
				nextPage = "/view/notices/admin_view.jsp";
				
			} else if(action.equals("/mod.do")) {
/*				String kateName = request.getParameter("kateName");
				String kateDetail = request.getParameter("kateDetail");
				String kateSearchNo = request.getParameter("kateSearchNo");
*/
				
				return;
			} else if(action.equals("/remove.do")){			   // 공지사항 삭제
				String str = request.getParameter("brdNo");
				int brdNo = Integer.parseInt(str);
				adminService.removeBoard(brdNo);
				nextPage="/admin/list.do";
				
			} else if(action.equals("/remove2.do")){			   // 회원 삭제
				String str = request.getParameter("id");
				adminService.removeUser(str);
				nextPage="/admin/memberlist.do";
				
			} else if(action.equals("/remove3.do")){			   // 카테고리 삭제
				String str = request.getParameter("kateSearchNo");
				
				adminService.removeKategorie(Integer.parseInt(str));
				
				nextPage="/admin/kate.do";
				
			} else if (action.equals("/katmod.do")) {		      // 카테고리 수정
				PrintWriter out = response.getWriter();
				String katSearchNo = request.getParameter("katNo");


				//추천 표시
				Kategorie kat = adminService.getKateView(Integer.parseInt(katSearchNo)); // 추천 여부 확인


				// Gson 객체 생성
		        Gson gson = new Gson();
		 
		        // Student 객체 -> Json 문자열
		        String studentJson = gson.toJson(kat);
		 
		        //ajax로 전달
				out.print(studentJson);				
				
				return;
				
				
			} else if (action.equals("/katsave.do")) {
				String kateName = request.getParameter("kateName");
				String kateDetail = request.getParameter("kateDetail");
				String kateSearchId = request.getParameter("katSearchId");

				Kategorie kat = new Kategorie();
				kat.setKateName(kateName);
				kat.setKateDetail(kateDetail);
				kat.setKateNo(Integer.parseInt(kateSearchId));

				adminService.savekat(kat);
				nextPage = "/admin/kate.do";
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
