package service;

import java.util.List;
import java.util.Map;

import dao.BoardDao;
import dao.CommentDao;
import dao.KateDao;
import model.Board;
import model.Comment;
import model.Kategorie;

public class BoardService {

	KateDao katDao;
	BoardDao brdDao;
	CommentDao comDao;
	
	public BoardService() {
		brdDao = new BoardDao();
		katDao = new KateDao();
		comDao = new CommentDao();
	}
	
	
	public List<Kategorie> getMenu() {
		return katDao.selectAll();
	}
	
	
	public List<Board> getBoardList(Map<String,Object> map){
		return brdDao.selectAll(map);
	}

	
	public List<Board> getBoardSearchList(Map<String,Object> map){
		return brdDao.selectSearchAll(map);
	}


	public void save(Board brd) {

		if(brd.getBrdNo() == 0) {
			brdDao.create(brd);
		} else {
			brdDao.update(brd);			
		}
		
	}
	
	public void removeBoard(int brdNo) {
		brdDao.delete(brdNo);	
	}
	
	public Board getBoardView(int brdNo) {
		return brdDao.selectById(brdNo);
	}

	
	public void saveComment(Comment com) {
		comDao.create(com);
	}

	
	
	public List<Comment> getCommentList(int brdNo) {
		return comDao.selectById(brdNo);
	}
	
	public int VoteUpdate(Board vo) {

		int check = brdDao.VoteCheck(vo);	

		if(check == 0)
			brdDao.insertVote(vo);

		return check;
	}

	public int getVote(int brdNo) {
		return brdDao.selectVote(brdNo);
	}
	
	public void CntUpdate(int brdNo) {
		
		
		brdDao.CntUpdate(brdNo);	
	}

	
	

	

}
