package service;

import java.util.List;
import java.util.Map;

import dao.BoardDao;
import dao.CommentDao;
import dao.KateDao;
import dao.UserDao;
import model.Board;
import model.Comment;
import model.Kategorie;
import model.User;

public class AdminService {

	BoardDao brdDao;
	KateDao katDao;
	UserDao userDao; 
	CommentDao comDao;

	
	public AdminService() {
		brdDao = new BoardDao();
		katDao = new KateDao();
		userDao = new UserDao();
		comDao = new CommentDao();
	}
	
	
	public List<Kategorie> getMenu() {
		return katDao.selectAll();
	}
	
	
	public List<Board> getBoardList(Map<String,Object> map){
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

	
	public Kategorie getKateView(int katNo) {
		return katDao.selectById(katNo);
	}

	
	public void savekat(Kategorie kat) {
		if (kat.getKateNo() == 0) {
			katDao.create(kat);
		} else {
			katDao.update(kat);
		}
	}
	
	public void removeUser(String id) {
		userDao.delete(id);
	}
	
	public void removeKategorie(int katNo) {
		katDao.delete(katNo);
	}
	
	public void CntUpdate(int brdNo) {
		
		
		brdDao.CntUpdate(brdNo);	
	}
	
	public List<Comment> getCommentList(int brdNo) {
		return comDao.selectById(brdNo);
	}

	
}
