package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Board;
import model.Kategorie;
import model.Seat;
import service.MainService;

@WebServlet("/main/*")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MainService mainService;
	
	public void init(ServletConfig config) throws ServletException {
		mainService = new MainService();
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

		List<Kategorie> katlist  = mainService.getMenu();
		request.setAttribute("katlist", katlist);		
		request.setAttribute("katTargetNo", 0);
		request.setAttribute("katTargetName", "Dashboard");

		try {
			if(action == null){
				
				List<Seat> list = mainService.getSeatList(); // 좌석 정보 가져오기
				request.setAttribute("list", list);	// VIEW에 좌석 정보 세팅

				List<Board> viewlist = mainService.getBoardViewList(); // 최신글 가져오기
				request.setAttribute("viewlist", viewlist); //최신글 세팅

				Map<String,Integer> statis = mainService.getSeatCount();
				request.setAttribute("statis", statis);
				
				nextPage = "/view/main/main.jsp";
				
			} else if("/main.do".equals(action)) {
				List<Seat> list = mainService.getSeatList();// 좌석 정보 가져오기
				request.setAttribute("list", list);// VIEW에 좌석 정보 세팅

				List<Board> viewlist = mainService.getBoardViewList();  // 최신글 가져오기
				request.setAttribute("viewlist", viewlist);  //최신글 세팅

				Map<String,Integer> statis = mainService.getSeatCount(); // 좌석 카운트 가져오기
				request.setAttribute("statis", statis); // 좌석 가운트 세팅

				
				nextPage = "/view/main/main.jsp";
			} else if(action.equals("/change.do")){
				
				PrintWriter out = response.getWriter();

				// 좌석 정보 세팅
				Seat seat = new Seat();
				String userId = request.getParameter("userId"); 
				seat.setUserId(userId);
				seat.setSeatNo(request.getParameter("SeatNo"));
				seat.setSeatComment("02");

				//저장
				mainService.SeatUpdate(seat);
				out.print("success");
			}

			RequestDispatcher dis = request.getRequestDispatcher(nextPage);
			dis.forward(request, response);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
