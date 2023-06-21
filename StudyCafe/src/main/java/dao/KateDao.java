package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Kategorie;

public class KateDao extends SuperDao{

	public KateDao() {

	}

	public List<Kategorie> selectAll() {

		List<Kategorie> list = new ArrayList<>();

		try {
			Connection conn = getConnection();
			String sql = "select * from Kategorie where user_type_cd = '02'";

			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				Kategorie vo = new Kategorie();
				vo.setKateNo(re.getInt("kate_no"));
				vo.setKateName(re.getString("kate_name"));
				vo.setKateDetail(re.getString("kate_detail"));
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

	public Kategorie selectById(int kateNo) {
		
		Kategorie vo = null;

		try {
			Connection conn = getConnection();
			String sql = "select * from Kategorie where kate_no=?";

			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, kateNo);
			ResultSet re = stmt.executeQuery();
			while (re.next()) {
				vo = new Kategorie();
				vo.setKateNo(re.getInt("kate_no"));
				vo.setKateName(re.getString("kate_name"));
				vo.setKateDetail(re.getString("kate_detail"));
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

	public boolean create(Kategorie vo) {


		try {
			Connection conn = getConnection();
			String sql = "insert into Kategorie(kate_name,kate_detail) values(?,?)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, vo.getKateName());
			stmt.setString(2, vo.getKateDetail());

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

	public void update(Kategorie vo) {
		try {
			Connection conn = getConnection();
			

			String sql = "update Kategorie set kate_name = ?, kate_detail = ? where kate_no=? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo.getKateName());
			stmt.setString(2, vo.getKateDetail());
			stmt.setInt(3, vo.getKateNo());
			

			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

	}


	public void delete(int katNo) {

		try {
			Connection conn = getConnection();
			

			String sql = "delete from Kategorie where kate_no=?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, katNo);
			stmt.executeUpdate();
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}

		
	}

	
	

}
