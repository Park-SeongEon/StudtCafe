package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDao extends SuperDao{

	public UserDao() {

	}

	public List<User> selectAll() {

		List<User> list = new ArrayList<>();

		try {
			Connection conn = getConnection();
			String sql = "select * from user";

			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				User vo = new User();
				vo.setUserId(re.getString("user_id"));
				vo.setUserPwd(re.getString("user_pwd"));
				vo.setUserName(re.getString("user_name"));
				vo.setUserEmail(re.getString("user_email"));
				vo.setUserCp(re.getString("user_cp"));
				vo.setUserAddr(re.getString("user_addr"));
				vo.setUserDaddr(re.getString("user_DAddr"));
				vo.setRegDate(re.getDate("regDate"));
				vo.setJoinDate(re.getDate("joinDate"));
				vo.setUserGrade(re.getString("user_grade"));
				list.add(vo);
			}
			re.close();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

		return list;
	}

	public User selectById(String userId) {
		
		User vo = null;

		try {
			Connection conn = getConnection();
			String sql = "select * from user where user_id=?";

			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, userId);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				vo = new User();
				vo.setUserId(re.getString("user_id"));
				vo.setUserPwd(re.getString("user_pwd"));
				vo.setUserName(re.getString("user_name"));
				vo.setUserEmail(re.getString("user_email"));
				vo.setUserCp(re.getString("user_cp"));
				vo.setUserAddr(re.getString("user_addr"));
				vo.setUserDaddr(re.getString("user_DAddr"));
				vo.setRegDate(re.getDate("regDate"));
				vo.setJoinDate(re.getDate("joinDate"));
				vo.setUserGrade(re.getString("user_grade"));
			}
			re.close();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

		

		return vo;
	}

	public boolean create(User vo) {

		try {
			Connection conn = getConnection();
			String sql = "insert into user(user_id,user_name,user_pwd,user_email,user_addr,user_DAddr,user_cp) values(?,?,?,?,?,?,?)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, vo.getUserId());
			stmt.setString(2, vo.getUserName());
			stmt.setString(3, vo.getUserPwd());
			stmt.setString(4, vo.getUserEmail());
			stmt.setString(5, vo.getUserAddr());
			stmt.setString(6, vo.getUserDaddr());
			stmt.setString(7, vo.getUserCp());

			stmt.executeUpdate(); // 여기서 에러
			stmt.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return false;
	}

	public void update(User vo) {
		try {
			Connection conn = getConnection();
			

			String sql = "update user set  user_name = ?, user_addr = ?,user_DAddr = ?, user_email = ?, user_cp= ?, user_grade = ?,user_pwd = ? where user_id=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo.getUserName());
			stmt.setString(2, vo.getUserAddr());
			stmt.setString(3, vo.getUserDaddr());
			stmt.setString(4, vo.getUserEmail());
			stmt.setString(5, vo.getUserCp());
			stmt.setString(6, vo.getUserGrade());

			if(vo.getUserPwd() != null) {
				stmt.setString(7, vo.getUserPwd());
				stmt.setString(8, vo.getUserId());				
			}
			else {
				stmt.setString(7, vo.getUserPwd());
				stmt.setString(8, vo.getUserId());				
			}				

			
			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	public void gradeUpdate(String userid, int grade) {
		try {
			
			Connection conn = getConnection();
			
			String sql = "update user set user_grade = ? where user_id=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, grade);
			stmt.setString(2, userid);

			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void joinDateUpdate(String userid, Date date) {
		try {
			
			Connection conn = getConnection();
			
			String sql = "update user set joinDate = ? where user_id=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setDate(1, date);
			stmt.setString(2, userid);

			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}



	public void delete(String vo) {

		try {
			Connection conn = getConnection();
			String sql = "delete from user where user_id=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo);
			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public boolean authenticateUser(String userId, String userPwd) {
	    boolean isAuthenticated = false;
	    
	    try {
	        Connection conn = getConnection();
	        String sql = "SELECT * FROM user WHERE user_id = ? AND user_pwd = ?";
	        
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, userId);
	        stmt.setString(2, userPwd);
	        
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            // 해당 사용자가 존재하고 비밀번호가 일치하는 경우
	            isAuthenticated = true;
	        }
	        
	        rs.close();
	        stmt.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close();
	    }
	    
	    return isAuthenticated;
	}

	public boolean idCheck(String userId) {
	    boolean isAuthenticated = false;
	    
	    try {
	        Connection conn = getConnection();
	        String sql = "SELECT * FROM user WHERE user_id = ?";
	        
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, userId);
	        
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            // 해당 사용자가 존재하고 비밀번호가 일치하는 경우
	            isAuthenticated = true;
	        }
	        
	        rs.close();
	        stmt.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close();
	    }
	    
	    return isAuthenticated;
	}

}


