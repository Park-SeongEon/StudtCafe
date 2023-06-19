package model;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	

	private int brdNo = 0;
	
	private String title;

	private String content;

	private String filename;

	private Date regDate;
	
	private int kateNo;

	private int voteNo;

	private int cnt;
	
	private String comment;

	private String userId;

	private int totalCount;

	private int rownum;

	
}