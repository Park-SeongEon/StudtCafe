package service;

import java.util.List;
import java.util.Map;

import dao.BoardDao;
import dao.KateDao;
import dao.UserDao;
import model.Board;
import model.Kategorie;
import model.User;

public class AdminService {

	BoardDao brdDao;
	KateDao katDao;
	UserDao userDao; 

	
	public AdminService() {
		brdDao = new BoardDao();
		katDao = new KateDao();
		userDao = new UserDao();
	}
	
	
	public List<Kategorie> getMenu() {
		return katDao.selectAll();
	}
	
	
	public List<Board> getBoardList(Map<String,Integer> map){
		return brdDao.selectAll(map);
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
	
	
	public List<User> getUserList() {
		return userDao.selectAll();
	}
	
	
	public List<Kategorie> getKateList() {
		return katDao.selectAll();
	}

	public void removeKategorie(int kateNo) {
		katDao.delete(kateNo);
	}
	
	
	
}
