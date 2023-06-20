package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Board;
import model.Seat;

public class SeatDao extends SuperDao{

	public SeatDao() {

	}

	public List<Seat> selectAll() {

		List<Seat> list = new ArrayList<>();

		try {
			Connection conn = getConnection();
			String sql = "	SELECT "
					+ "		s.*,"
					+ "		t.seat_type_name,"
					+ "		c.seat_comment_data"
					+ "	FROM seat s "
					+ "	INNER JOIN seat_type t ON(s.seat_type = t.seat_type)"
					+ "	INNER JOIN seat_comment c ON(s.seat_comment = c.seat_comment)";

			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				Seat vo = new Seat();
				vo.setSeatNo(re.getString("seat_no"));
				vo.setSeatComment(re.getString("seat_comment"));
				vo.setSeatType(re.getString("seat_type"));
				vo.setUserId(re.getString("user_id"));
				vo.setSeatCommentData(re.getString("seat_comment_data"));
				vo.setSeatTypeName(re.getString("seat_type_name"));
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

	
	public Map<String,Integer> selectSeatCount(){

		
		Map<String,Integer> map = null;
		
		try {
			Connection conn = getConnection();
			String sql = "SELECT "
					+ "	COUNT(*)  AS totalcnt "
					+ "	, COUNT(*) - (select COUNT(*) FROM seat WHERE seat_comment != '01') AS seatcnt "
					+ "FROM seat ";

			
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {				
				map = new HashMap<String,Integer>();
				map.put("totalcnt", re.getInt("totalcnt"));
				map.put("seatcnt", re.getInt("seatcnt"));
			}
			re.close();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

		return map;
	}

	
	public Board selectById(int brdNo) {
		
		Board vo = null;

		try {
			Connection conn = getConnection();
			String sql = "select * from board where brd_no=?";

			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, brdNo);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				vo = new Board();
				vo.setBrdNo(re.getInt("brd_no"));
				vo.setTitle(re.getString("title"));
				vo.setContent(re.getString("content"));
				vo.setFilename(re.getString("file_name"));
				vo.setRegDate(re.getDate("regdate"));
				vo.setKateNo(re.getInt("kate_no"));
				vo.setVoteNo(re.getInt("vote_no"));
				vo.setCnt(re.getInt("cnt"));
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

	public boolean create(Board vo) {


		try {
			Connection conn = getConnection();
			String sql = "insert into board(title,content,file_name,kate_no) values(?,?,?,?)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, vo.getTitle());
			stmt.setString(2, vo.getContent());
			stmt.setString(3, vo.getFilename());
			stmt.setInt(4, vo.getKateNo());

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

	public void update(Seat vo) {
		try {
			Connection conn = getConnection();
			

			String sql = "update seat set seat_comment = ?,user_id = ? where seat_no=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo.getSeatComment());
			stmt.setString(2, vo.getUserId());
			stmt.setString(3, vo.getSeatNo());

			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	}
	public void CntUpdate(int brdNo, int cnt) {
		try {
			
			Connection conn = getConnection();
			
			String sql = "update board set cnt = ? where brd_no=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, cnt);
			stmt.setInt(2, brdNo);

			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	}
	
	public void VoteUpdate(int brdNo, int vote) {
		try {
			
			Connection conn = getConnection();
			
			String sql = "update board set vote_no = ? where brd_no=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, vote);
			stmt.setInt(2, brdNo);

			stmt.executeUpdate();
			stmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	}

	public void delete(int brdNo) {

		try {
			Connection conn = getConnection();
			

			String sql = "delete from board where brd_no=?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, brdNo);
			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

		
	}

	
	

}
