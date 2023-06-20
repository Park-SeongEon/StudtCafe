package model;

import java.util.Date;
import lombok.Data;

@Data
public class User {

	private String userId;

	private String userPwd;
	
	private String userName;

	private String userEmail;
	
	private String userCp;

	private String userAddr;
	
	private String userDaddr;

	private Date regDate;

	private Date joinDate;

	private String userGrade = "E";

}
