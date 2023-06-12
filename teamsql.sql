
CREATE TABLE `Kategorie` (
	`kate_no` INT(10) NOT NULL AUTO_INCREMENT, 
	`kate_name` VARCHAR(10) NOT NULL,  
	PRIMARY KEY (`kate_no`) 
);

CREATE TABLE board(
	brd_no INT(10) NOT NULL AUTO_INCREMENT,
	title VARCHAR(500) NOT NULL,
	content VARCHAR(4000),
	file_name VARCHAR(100),
	regdate DATE NOT NULL DEFAULT CURRENT_TIMESTAMP() '등록일자',
	kate_no INT(10) NOT NULL COMMENT '카테고리 번호',
	vote_no INT(5) NOT NULL DEFAULT 0 COMMENT '좋아요수', 
	cnt INT(5) NOT NULL DEFAULT 0 COMMENT '조회수',
	PRIMARY KEY (`brd_no`) 
);


CREATE TABLE `user` (
	`user_id` VARCHAR(10) NOT NULL ,
	`user_pwd` VARCHAR(10) NOT NULL,
	`user_name` VARCHAR(50) NOT NULL,
	`user_email` VARCHAR(50) NOT NULL,
	`user_cp` VARCHAR(50) NOT NULL,
	`user_addr` VARCHAR(50) NOT NULL,
	`user_daddr` VARCHAR(50) NOT NULL,
	`regData` DATE NOT NULL DEFAULT current_timestamp(),
	`joinData` DATE,
	user_grade VARCHAR(50) NOT NULL DEFAULT 'E',
	PRIMARY KEY (`id`) 
);



CREATE TABLE board_comment (
	`parent_no` INT(10) NOT NULL ,
	`com_no` INT(10) NOT NULL,
	brd_no INT(10) NOT NULL
	`com_content` VARCHAR(50) NOT NULL,
	`regData` DATE NOT NULL DEFAULT current_timestamp(),
	`modData` DATE,	
	PRIMARY KEY (`com_no`) 
);



