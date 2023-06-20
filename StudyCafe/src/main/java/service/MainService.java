package service;

import java.util.List;
import java.util.Map;

import dao.BoardDao;
import dao.KateDao;
import dao.SeatDao;
import model.Board;
import model.Kategorie;
import model.Seat;

public class MainService {

	SeatDao seatDao;
	KateDao katDao;
	BoardDao brdDao;

	
	public MainService() {
		seatDao = new SeatDao();
		katDao = new KateDao();
		brdDao = new BoardDao();

	}

	public List<Kategorie> getMenu() {
		return katDao.selectAll();
	}
	
	
	public List<Seat> getSeatList(){
		return seatDao.selectAll();
		
	}
	
	public void SeatUpdate(Seat vo){
		seatDao.update(vo);
	}

	public List<Board> getBoardViewList(){
		return brdDao.selectMainViewList();
	}
	
	public Map<String,Integer> getSeatCount() {
		return seatDao.selectSeatCount();
	}
}
