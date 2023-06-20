package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import model.User;

@WebServlet("/member/*")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDao userDao;

	public UserController() {
		super();
	}

	@Override
	public void init() throws ServletException {

		userDao = new UserDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session;

		String action = request.getPathInfo();

		if (action == null) {
			nextPage = "/view/login.jsp";

		}else if("/main.do".equals(action)) {
			nextPage = "/view/login.jsp";

		} else if (action.equals("/save.do")) {
			// 회원 가입
			String userID = request.getParameter("userID");
			String userPW = request.getParameter("userPW");
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String user_addr = request.getParameter("user_addr");
			
			String hashedPassword = sha256Hash(userPW);

			User user = new User();
			user.setUserId(userID);
			user.setUserPwd(hashedPassword);
			user.setUserEmail(email);
			user.setUserName(name);
			user.setUserAddr(user_addr);
			user.setUserCp(tel);

			userDao.create(user);
			

			nextPage = "/member/main.do";
		} else if (action.equals("/update.do")) {
			// 회원정보수정
			String userPW = request.getParameter("userPW");
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String user_addr = request.getParameter("user_addr");
			
			String hashedPassword = sha256Hash(userPW);

			User user = new User();

			user.setUserPwd(hashedPassword);
			user.setUserEmail(email);
			user.setUserName(name);
			user.setUserAddr(user_addr);
			user.setUserCp(tel);

			userDao.update(user);
			

			nextPage = "/member/main.do";
		} else if (action.equals("/join.do")) {
			nextPage = "/view/join.jsp";
		} else if (action.equals("/mod.do")) {
			User vo = new User();

//			dao.update(vo);
			nextPage = "/member/list.do";
		} else if (action.equals("/del.do")) { // 회원 삭제부분 여기에 추가
			String id = request.getParameter("id");
//			User vo = dao.selectById(id);

			nextPage = "/member/main.do";
		} else if ("/login.do".equals(action)) {
			String userID = request.getParameter("userID");
			String userPW = request.getParameter("userPW");
			
			String hashedPassword = sha256Hash(userPW);

			
			// 로그인 처리
			boolean isAuthenticated = userDao.authenticateUser(userID, hashedPassword);

			if (isAuthenticated) {
				// 로그인 성공
				request.getSession().setAttribute("userId", userID);
				// response.sendRedirect(request.getContextPath() + "/main/main.do");
				nextPage = "/main/main.do";

			} else {
				// 로그인 실패
				PrintWriter out = response.getWriter();				
				out.print("<script>" 
				+ "  alert('아이디 또는 비밀번호가 올바르지 않습니다.');"   // 알림창 
				+ " location.href='" + request.getContextPath() + "/member/main.do';"  // 전체글 보기 페이지로 이동
				+ "</script>");

				return;
			}
		} else if ("/checkId.do".equals(action)) {
			PrintWriter out = response.getWriter();

			String userId = request.getParameter("userId");

			boolean checkID = userDao.idCheck(userId);
			if (checkID)
				out.print("fail");
			else
				out.print("success");

			return;
		}else if (action.equals("/updatefrom.do")) {
			
			session=request.getSession();
			String userId = (String) session.getAttribute("userId");
			
			User user= userDao.selectById(userId);
			request.setAttribute("user", user);
			nextPage = "/view/update.jsp";
		}
		
		
		else {
			List<User> memList = userDao.selectAll();
			request.setAttribute("memList", memList);
			nextPage = "/view/member.jsp";

		}
		
		
		RequestDispatcher dis = request.getRequestDispatcher(nextPage);
		dis.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}


	public static String sha256Hash(String input) {
	    try {
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
	
	        // 해시 값을 16진수 문자열로 변환
	        StringBuilder hexString = new StringBuilder();
	        for (byte b : hash) {
	            String hex = Integer.toHexString(0xff & b);
	            if (hex.length() == 1) {
	                hexString.append('0');
	            }
	            hexString.append(hex);
	        }
	
	        return hexString.toString();
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
}

