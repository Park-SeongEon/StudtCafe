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

	public List<Board> selectAll(Map<String,Integer> map) {

		List<Board> list = new ArrayList<>();

		int katNo = (Integer) map.get("katNo");
		int section = (Integer) map.get("section");
		int pageNum = (Integer) map.get("pageNum");
		try {
			Connection conn = getConnection();
			String sql = "SELECT * FROM ( "
					+ "SELECT  "
					+ "	* "
					+ "	,ROW_NUMBER() over(ORDER BY regDate) AS rownum"
					+ "	,count(1) over() AS totalCount "
					+ "from board  "
					+ "where kate_no=? "
					+ "order by regDate DESC "
					+ ") c "
					+ "WHERE rownum BETWEEN (?-1)*10*100+(?-1)*10+1 AND (?-1)*100+?*10";

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
					+ "    SELECT *"
					+ "	 FROM board"
					+ "	 WHERE kate_no = 1"
					+ "	 ORDER BY regDate desc"
					+ "	 LIMIT 2"
					+ ") AS t1 "
					+ "UNION ALL "
					+ "SELECT "
					+ "	t2.* "
					+ "FROM ( "
					+ "    SELECT * "
					+ "	 FROM board "
					+ "	 ORDER BY regDate desc"
					+ "	 LIMIT 3 "
					+ ") AS t2";

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

	public void update(Board vo) {
		try {
			Connection conn = getConnection();
			

			String sql = "update board set title = ?,content = ?, file_name = ? where brd_no=? cnt=? vote_no=?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo.getTitle());
			stmt.setString(2, vo.getContent());
			stmt.setString(3, vo.getFilename());
			stmt.setInt(4, vo.getBrdNo());				
			stmt.setInt(5, vo.getCnt());
			stmt.setInt(6, vo.getVoteNo());
			
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
			
			String sql = "update board set vote_no = ? where brd_no=?  ";

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