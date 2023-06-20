package service;

import java.util.List;
import java.util.Map;

import dao.BoardDao;
import dao.KateDao;
import model.Board;
import model.Kategorie;

public class BoardService {

	KateDao katDao;
	BoardDao brdDao;

	
	public BoardService() {
		brdDao = new BoardDao();
		katDao = new KateDao();

	}
	
	
	public List<Kategorie> getMenu() {
		return katDao.selectAll();
	}
	
	
	public List<Board> getBoardList(Map<String,Integer> map){
		return brdDao.selectAll(map);
	}


	public void save(Board brd) {

		if(brd.getBrdNo() != 0) {
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
	
	

}
