package service;

import java.util.List;

import dao.KateDao;
import dao.SeatDao;
import model.Kategorie;
import model.Seat;

public class MainService {

	SeatDao seatDao;
	KateDao katDao;

	
	public MainService() {
		seatDao = new SeatDao();
		katDao = new KateDao();

	}
	
	
	public List<Kategorie> getMenu() {
		return katDao.selectAll();
	}
	
	
	public List<Seat> getSeatList(){
		return seatDao.selectAll();
		
	}
	
	
	

}
