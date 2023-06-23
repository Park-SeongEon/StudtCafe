package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

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
			nextPage = "/view/member/login.jsp";

		}else if("/main.do".equals(action)) {
			nextPage = "/view/member/login.jsp";

		} else if (action.equals("/save.do")) {
			// 회원 가입
			String userID = request.getParameter("userID");
			String userPW = request.getParameter("userPW");
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			String addr2 = request.getParameter("addr2");
			
			//password 암호화
			String hashedPassword = sha256Hash(userPW);
	
			//정보 세팅
			User user = new User();
			user.setUserId(userID);
			user.setUserPwd(hashedPassword);
			user.setUserEmail(email);
			user.setUserName(name);
			user.setUserAddr(addr);
			user.setUserDaddr(addr2);
			user.setUserCp(tel);
			//저장
			userDao.create(user);
			
			nextPage = "/member/main.do";
		} else if (action.equals("/update.do")) {
			// 회원정보수정
			String userPW = request.getParameter("userPW");
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			String addr2 = request.getParameter("addr2");
			

			User user = new User();
			
			user.setUserId((String)	request.getSession().getAttribute("userId"));

			if(userPW == null)
			{
				User user2=userDao.selectById(user.getUserId());
				user.setUserPwd(user2.getUserPwd());				
			} else {
				String hashedPassword = sha256Hash(userPW);
				user.setUserPwd(hashedPassword);								
			}
			
			user.setUserEmail(email);
			user.setUserName(name);
			user.setUserAddr(addr);
			user.setUserDaddr(addr2);
			user.setUserCp(tel);

			userDao.update(user);
			

			nextPage = "/main/main.do";
		} else if (action.equals("/join.do")) {
			nextPage = "/view/member/join.jsp";
		} else if ("/login.do".equals(action)) {
			String userID = request.getParameter("userID");
			String userPW = request.getParameter("userPW");
			
			//password 암호화
			String hashedPassword = sha256Hash(userPW);
			
			// 로그인 처리
			boolean isAuthenticated = userDao.authenticateUser(userID, hashedPassword);

			if (isAuthenticated) {
				// 로그인 성공
				request.getSession().setAttribute("userId", userID);
				//로그인 성공시 접속날짜 업데이트. sql에서 SYSDATE() 또는 now() 함수를 써도됨
				Date utilDate = new Date();
				java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());				
				userDao.joinDateUpdate(userID, sqlDate);

				nextPage = "/main/main.do";

			} else {
				// 로그인 실패
				PrintWriter out = response.getWriter();				
				out.print("<script>" 
				+ "  alert('아이디 또는 비밀번호가 올바르지 않습니다.');"   // 알림창 
				+ " location.href='" + request.getContextPath() + "/member/main.do';"  // 로그인 페이지로 이동
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
			
			session = request.getSession();
			String userId = (String) session.getAttribute("userId");
			
			User user= userDao.selectById(userId);
			request.setAttribute("user", user);
			nextPage = "/view/member/update.jsp";
		}
		//로그아웃
		else if (action.equals("/logout.do")) {
		    session = request.getSession(false); // 세션 객체 생성하지 않고 기존 세션을 가져옴
		    if (session != null) {
		        session.removeAttribute("userId"); // 세션에서 userId 속성 제거
		        session.invalidate(); // 세션 무효화
		    }
		    nextPage = "/member/main.do";
		}else {
			nextPage = "/view/member/login.jsp";
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

