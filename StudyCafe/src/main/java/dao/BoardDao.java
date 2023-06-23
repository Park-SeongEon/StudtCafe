package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import model.Board;

public class BoardDao extends SuperDao{

	public BoardDao() {

	}

	public List<Board> selectAll(Map<String,Object> map) {

		List<Board> list = new ArrayList<>();

		int katNo = (Integer) map.get("katNo");
		int section = (Integer) map.get("section");
		int pageNum = (Integer) map.get("pageNum");

		
		
		try {
			Connection conn = getConnection();
			String sql = "SELECT * FROM ( "
					+ "SELECT  "
					+ "	* "
					+ "	,ROW_NUMBER() over(ORDER BY regDate desc) AS rownum"
					+ "	,count(1) over() AS totalCount "
					+ "from board  "
					+ "where kate_no=? "
					+ "order by regDate DESC "
					+ ") c "
					+ "WHERE rownum BETWEEN (?-1)*10*100+(?-1)*10+1 AND (?-1)*100+?*10 "
					+ "order by rownum";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, katNo);
			stmt.setInt(2, section);
			stmt.setInt(3, pageNum);
			stmt.setInt(4, section);
			stmt.setInt(5, pageNum);
			
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				Board vo = new Board();
				vo.setBrdNo(re.getInt("brd_no"));
				vo.setTitle(re.getString("title"));
				vo.setContent(re.getString("content"));
				vo.setFilename(re.getString("file_name"));
				vo.setRegDate(re.getDate("regdate"));
				vo.setKateNo(re.getInt("kate_no"));
				vo.setVoteNo(re.getInt("vote_no"));
				vo.setCnt(re.getInt("cnt"));
				vo.setTotalCount(re.getInt("totalCount"));
				vo.setRownum(re.getInt("rownum"));
				vo.setUserId(re.getString("user_id"));

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
	
	
	public List<Board> selectSearchAll(Map<String,Object> map) {

		List<Board> list = new ArrayList<>();

		int katNo = (Integer) map.get("katNo");
		int section = (Integer) map.get("section");
		int pageNum = (Integer) map.get("pageNum");
		String searchId = (String) map.get("searchId");
		String searchText = (String) map.get("searchText");

		
		
		try {
			Connection conn = getConnection();
			String sql = null;
			
			
			if(searchId.equals("title"))
				sql = "SELECT * FROM ( "
					+ "SELECT  "
					+ "	* "
					+ "	,ROW_NUMBER() over(ORDER BY regDate desc) AS rownum"
					+ "	,count(1) over() AS totalCount "
					+ "from board  "
					+ "where kate_no=? "
					+ "and title like ? "
					+ "order by regDate DESC "
					+ ") c "
					+ "WHERE rownum BETWEEN (?-1)*10*100+(?-1)*10+1 AND (?-1)*100+?*10 "
					+ "order by rownum";
			else 
				sql = "SELECT * FROM ( "
					+ "SELECT  "
					+ "	* "
					+ "	,ROW_NUMBER() over(ORDER BY regDate desc) AS rownum"
					+ "	,count(1) over() AS totalCount "
					+ "from board  "
					+ "where kate_no=? "
					+ "and user_id like? "
					+ "order by regDate DESC "
					+ ") c "
					+ "WHERE rownum BETWEEN (?-1)*10*100+(?-1)*10+1 AND (?-1)*100+?*10 "
					+ "order by rownum";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, katNo);
			stmt.setString(2, "%" + searchText +"%");
			stmt.setInt(3, section);
			stmt.setInt(4, pageNum);
			stmt.setInt(5, section);
			stmt.setInt(6, pageNum);
			System.out.println(stmt);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				Board vo = new Board();
				vo.setBrdNo(re.getInt("brd_no"));
				vo.setTitle(re.getString("title"));
				vo.setContent(re.getString("content"));
				vo.setFilename(re.getString("file_name"));
				vo.setRegDate(re.getDate("regdate"));
				vo.setKateNo(re.getInt("kate_no"));
				vo.setVoteNo(re.getInt("vote_no"));
				vo.setCnt(re.getInt("cnt"));
				vo.setUserId(re.getString("user_id"));
				vo.setTotalCount(re.getInt("totalCount"));
				vo.setRownum(re.getInt("rownum"));

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

	
	public List<Board> selectMainViewList() {
		List<Board> list = new ArrayList<>();

		try {
			Connection conn = getConnection();
			String sql = "SELECT "
					+ "	t1.* "
					+ "FROM "
					+ "("
					+ "    SELECT b.brd_no, CONCAT('[공지]',title) AS title, b.content,b.file_name,b.regDate,b.kate_no,b.vote_no,b.cnt,b.user_id"
					+ "	 FROM board b "
					+ "	 WHERE kate_no = 1 "
					+ "	 ORDER BY regDate asc "
					+ "	 LIMIT 2 "
					+ ") AS t1 "
					+ "UNION "
					+ "SELECT "
					+ "	t2.* "
					+ "FROM ("
					+ "    SELECT * "
					+ "	 FROM board "
					+ "	 WHERE kate_no != 1"
					+ "	 ORDER BY regDate desc"
					+ "	 LIMIT 3 "
					+ ") AS t2 ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				Board vo = new Board();
				vo.setBrdNo(re.getInt("brd_no"));
				vo.setTitle(re.getString("title"));
				vo.setContent(re.getString("content"));
				vo.setFilename(re.getString("file_name"));
				vo.setRegDate(re.getDate("regdate"));
				vo.setKateNo(re.getInt("kate_no"));
				vo.setVoteNo(re.getInt("vote_no"));
				vo.setCnt(re.getInt("cnt"));
				vo.setUserId(re.getString("user_id"));

				list.add(vo);
			}
			
			
			re.close();
			stmt.close();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	
		return list;
	}

	public Board selectById(int brdNo) {
		
		Board vo = null;

		try {
			Connection conn = getConnection();
			String sql = "select *,(select count(*) from board_vote where brd_no=?) as vote2 from board where brd_no=?";

			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, brdNo);
			stmt.setInt(2, brdNo);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				vo = new Board();
				vo.setBrdNo(re.getInt("brd_no"));
				vo.setTitle(re.getString("title"));
				vo.setContent(re.getString("content"));
				vo.setFilename(re.getString("file_name"));
				vo.setRegDate(re.getDate("regdate"));
				vo.setKateNo(re.getInt("kate_no"));
				vo.setVoteNo(re.getInt("vote2"));
				vo.setCnt(re.getInt("cnt"));
				vo.setUserId(re.getString("user_id"));

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
			String sql = "insert into board(title,content,file_name,user_id,kate_no) values(?,?,?,?,?)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, vo.getTitle());
			stmt.setString(2, vo.getContent());
			stmt.setString(3, vo.getFilename());
			stmt.setString(4, vo.getUserId());
			stmt.setInt(5, vo.getKateNo());

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

	public void update(Board vo) {
		try {
			Connection conn = getConnection();
			

			String sql = "update board set title = ?,content = ?, file_name = ? where brd_no=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo.getTitle());
			stmt.setString(2, vo.getContent());
			stmt.setString(3, vo.getFilename());
			stmt.setInt(4, vo.getBrdNo());				
			
			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	}
	public void CntUpdate(int brdNo) {
		try {
			
			Connection conn = getConnection();
			
			String sql = "update board set cnt = cnt+1 where brd_no=? ";

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

	public void insertVote(Board vo) {
		try {
			
			Connection conn = getConnection();
			
			String sql = "insert into board_vote values(?,?) ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, vo.getUserId());
			stmt.setInt(2, vo.getBrdNo());

			stmt.executeUpdate();
			stmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	}

	public int VoteCheck(Board vo) {
		int isAuthenticated = 0;

		try {

			Connection conn = getConnection();

			String sql = "select count(*) as cnt from board_vote where brd_no = ? and user_id=?  ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, vo.getBrdNo());
			stmt.setString(2, vo.getUserId());

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				
				isAuthenticated = rs.getInt("cnt");
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

	
	public int selectVote(int brdNo) {
		int isAuthenticated = 0;

		try {

			Connection conn = getConnection();

			String sql = "select count(*) as cnt from board_vote where brd_no = ?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, brdNo);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				
				isAuthenticated = rs.getInt("cnt");
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