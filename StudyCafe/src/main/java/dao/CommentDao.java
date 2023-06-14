package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Comment;


public class CommentDao extends SuperDao{

	public CommentDao() {

	}

	public List<Comment> selectAll() {

		List<Comment> list = new ArrayList<>();

		try {
			Connection conn = getConnection();
			String sql = "select * from board_comment order by regDate desc";

			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				Comment vo = new Comment();
				vo.setParentNo(re.getInt("parent_no"));
				vo.setComNo(re.getInt("com_no"));
				vo.setComNo(re.getInt("brd_no"));
				vo.setComContent(re.getString("com_content"));
				vo.setRegDate(re.getDate("regdate"));
				vo.setModDate(re.getDate("moddate"));
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

	public Comment selectById(int brdNo) {
		
		Comment vo = null;

		try {
			Connection conn = getConnection();
			String sql = "select * from board_comment where brd_no=?";

			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, brdNo);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				vo = new Comment();
				vo.setParentNo(re.getInt("parent_no"));
				vo.setComNo(re.getInt("com_no"));
				vo.setBrdNo(re.getInt("brd_no"));
				vo.setComContent(re.getString("com_content"));
				vo.setRegDate(re.getDate("regdate"));
				vo.setModDate(re.getDate("moddate"));
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

	public boolean create(Comment vo) {


		try {
			Connection conn = getConnection();
			String sql = "insert into board_comment(parent_no,brd_no,com_content) values(?,?,?)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setInt(1, vo.getParentNo());
			stmt.setInt(2, vo.getBrdNo());
			stmt.setString(3, vo.getComContent());

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

	public void update(Comment vo) {
		try {
			Connection conn = getConnection();
			

			String sql = "update board_comment set com_content = ? where com_no=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo.getComContent());
			stmt.setInt(2, vo.getComNo());
			
			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	}
	

	public void delete(Comment vo) {

		try {
			Connection conn = getConnection();
			

			String sql = "delete from board where com_no=?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, vo.getComNo());
			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

		
	}

	
	

}
