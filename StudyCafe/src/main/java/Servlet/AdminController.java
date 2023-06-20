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
import model.User;
import service.AdminService;
import service.BoardService;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String ARTICEL_IMAGE_REPO = "D:\\file_repo";

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
		String action = request.getPathInfo();
		
		
        if(request.getSession().getAttribute("userId") == null) {
            response.sendRedirect("/member/main.do");
            return;
        }
		
		
		List<Kategorie> katlist  = adminService.getMenu();
		request.setAttribute("katlist", katlist);

		
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
			
				nextPage = "/view/list.jsp";
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

				nextPage = "/view/admin_list.jsp";

			} else if(action.equals("/memberlist.do")) {      // 회원목록
				userlist = adminService.getUserList();
				request.setAttribute("list", userlist);
				nextPage = "/view/listMembers.jsp";
				
			} else if(action.equals("/kate.do")) {            // 카테고리
				katlist = adminService.getKateList();
				request.setAttribute("list", katlist);
				nextPage = "/view/kate.jsp";
				
			}else if(action.equals("/Form.do")) {
				nextPage = "/view/Form.jsp";
				
			} else if (action.equals("/add.do")){			  // 글 작성
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				
				Board brd =new Board();
				brd.setTitle(title);
				brd.setContent(content);
				brd.setKateNo(katNo);
				
				adminService.save(brd);
				
				nextPage = "/admin/list.do";
			} else if(action.equals("/view.do")){
				String no = request.getParameter("brdNO");
				Board vo = adminService.getBoardView(Integer.parseInt(no));
				request.setAttribute("vo", vo);
				nextPage = "/view/view.jsp";
				
			} else if(action.equals("/mod.do")) {
				return;
			} else if(action.equals("/remove.do")){			   // 회원 삭제
				String str = request.getParameter("brdNo");
				int brdNo = Integer.parseInt(str);
				adminService.removeBoard(brdNo);
				nextPage="/admin/list.do";
				
			} else if(action.equals("/remove2.do")){			   // 카테고리 삭제
				String str = request.getParameter("kateNo");
				int kateNo = Integer.parseInt(str);
				adminService.removeKategorie(kateNo);
				nextPage="/admin/kate.do";
				
			}else if (action.equals("/replyForm.do")) {
				
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
