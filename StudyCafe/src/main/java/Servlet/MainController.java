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

import model.Kategorie;
import model.Seat;
import service.MainService;

@WebServlet("/main/*")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String ARTICEL_IMAGE_REPO = "D:\\file_repo";
	
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
		HttpSession session;
		String action = request.getPathInfo();

		
		
		List<Kategorie> katlist  = mainService.getMenu();
		request.setAttribute("katlist", katlist);		

		request.setAttribute("katTargetNo", 0);

		
		try {			
			if(action == null){
				
			//	List<Seat> list = mainService.getSeatList();
			//	request.setAttribute("list", list);
				nextPage = "/view/main.jsp";
			} else if("/main.do".equals(action)) {
				List<Seat> list = mainService.getSeatList();
				request.setAttribute("list", list);
				nextPage = "/view/main.jsp";
			} else if(action.equals("/change.do")){
				
			}

			RequestDispatcher dis = request.getRequestDispatcher(nextPage);
			dis.forward(request, response);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
