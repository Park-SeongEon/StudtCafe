package model;

import java.util.Date;

import lombok.Data;

@Data
public class Board {

	private int brdNo;
	
	private String title;

	private String content;

	private String filename;

	private Date regDate;
	
	private int kateNo;

	private int voteNo;

	private int cnt;

}