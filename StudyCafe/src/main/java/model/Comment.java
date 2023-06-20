package model;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {

	private int parentNo;

	private int comNo;

	private int brdNo;
	
	private String comContent;
	
	private Date regDate;

	private Date modDate;
	
	private String userId;
}