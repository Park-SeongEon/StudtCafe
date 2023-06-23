-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.11.2-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- studycafe 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `studycafe` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `studycafe`;

-- 테이블 studycafe.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `brd_no` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `content` varchar(4000) DEFAULT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `kate_no` int(10) NOT NULL,
  `vote_no` int(5) NOT NULL DEFAULT 0,
  `cnt` int(5) NOT NULL DEFAULT 0,
  `user_id` varchar(10) NOT NULL,
  PRIMARY KEY (`brd_no`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board:~5 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`brd_no`, `title`, `content`, `file_name`, `regDate`, `kate_no`, `vote_no`, `cnt`, `user_id`) VALUES
	(2, '안녕하십니까 Spring 공부하고 있습니다', 'content', NULL, '2023-06-14 00:00:00', 3, 0, 3, 'admin'),
	(3, '안녕하세요', '123', NULL, '2023-06-14 00:00:06', 3, 0, 6, 'admin'),
	(4, '테스트합니다.', '1234567890213213213\r\n213\r\n213\r\n213\r\n213\r\n21\r\n321\r\n3\r\n12\r\n21321', NULL, '2023-06-20 20:14:14', 3, 2, 45, 'admin'),
	(11, 'test진행중입니다.', 'testdsfㅡㅇㄴ,ㄹ ㅡㅇ누 ㅡㄿ헝누 ㅡㄹ하ㅓㅁㄹ하ㅓㅠㅇ나ㅓㅠㅎ', NULL, '2023-06-21 20:10:16', 3, 2, 50, 'admin'),
	(12, '공지사항 테스트', '공지사항 테스트', NULL, '2023-06-22 11:59:38', 1, 1, 23, 'admin'),
	(13, '333333333333333', '131', NULL, '2023-06-23 14:58:19', 1, 0, 2, 'admin');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 studycafe.board_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_comment` (
  `com_no` int(10) NOT NULL AUTO_INCREMENT,
  `parent_no` int(10) NOT NULL,
  `com_content` varchar(50) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `regData` datetime NOT NULL DEFAULT current_timestamp(),
  `modData` datetime DEFAULT NULL,
  PRIMARY KEY (`com_no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board_comment:~15 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_comment` DISABLE KEYS */;
INSERT INTO `board_comment` (`com_no`, `parent_no`, `com_content`, `user_id`, `regData`, `modData`) VALUES
	(1, 2, 'test', 'admin', '2023-06-20 19:39:02', NULL),
	(2, 1, 'test', 'admin', '2023-06-20 19:48:32', NULL),
	(3, 1, 'test', 'admin', '2023-06-20 20:01:01', NULL),
	(4, 1, '12312321', 'admin', '2023-06-20 20:05:58', NULL),
	(5, 1, '12321321', 'admin', '2023-06-20 20:06:32', NULL),
	(6, 1, '12321321', 'admin', '2023-06-20 20:06:38', NULL),
	(7, 1, '12321321', 'admin', '2023-06-20 20:06:39', NULL),
	(8, 1, '12321321', 'admin', '2023-06-20 20:06:39', NULL),
	(9, 1, '12321321', 'admin', '2023-06-20 20:06:39', NULL),
	(10, 1, '12321321', 'admin', '2023-06-20 20:06:39', NULL),
	(11, 2, 'test', 'admin', '2023-06-21 10:24:44', NULL),
	(12, 4, '123', 'admin', '2023-06-21 16:10:50', NULL),
	(13, 8, '213', 'admin', '2023-06-21 17:18:22', NULL),
	(14, 4, '123', 'admin', '2023-06-21 19:57:15', NULL),
	(15, 9, 'adadada', 'admin', '2023-06-21 20:02:37', NULL);
/*!40000 ALTER TABLE `board_comment` ENABLE KEYS */;

-- 테이블 studycafe.board_vote 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_vote` (
  `user_id` varchar(10) NOT NULL,
  `brd_no` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board_vote:~5 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_vote` DISABLE KEYS */;
INSERT INTO `board_vote` (`user_id`, `brd_no`) VALUES
	('admin', 12),
	('admin', 11),
	('admin', 4),
	('admin', 3),
	('admin', 2),
	('test00', 11);
/*!40000 ALTER TABLE `board_vote` ENABLE KEYS */;

-- 테이블 studycafe.kategorie 구조 내보내기
CREATE TABLE IF NOT EXISTS `kategorie` (
  `kate_no` int(10) NOT NULL AUTO_INCREMENT,
  `kate_name` varchar(10) NOT NULL,
  `user_type_cd` varchar(2) NOT NULL DEFAULT '02',
  `kate_detail` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kate_no`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.kategorie:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `kategorie` DISABLE KEYS */;
INSERT INTO `kategorie` (`kate_no`, `kate_name`, `user_type_cd`, `kate_detail`) VALUES
	(1, '공지사항', '01', '공지사항입니다'),
	(2, '유저목록', '01', '유저목록입니다.'),
	(3, '게시판', '02', '게시판'),
	(4, 'Dashboard', '01', '메인화면입니다');
/*!40000 ALTER TABLE `kategorie` ENABLE KEYS */;

-- 테이블 studycafe.seat 구조 내보내기
CREATE TABLE IF NOT EXISTS `seat` (
  `seat_no` varchar(2) NOT NULL,
  `seat_comment` varchar(2) NOT NULL DEFAULT '01',
  `seat_type` varchar(50) NOT NULL DEFAULT '',
  `user_id` varchar(10) DEFAULT NULL,
  `regdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`seat_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.seat:~21 rows (대략적) 내보내기
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` (`seat_no`, `seat_comment`, `seat_type`, `user_id`, `regdate`) VALUES
	('01', '02', '01', '', '2023-06-14 00:00:00'),
	('02', '02', '01', 'admin', '2023-06-14 00:00:00'),
	('03', '02', '01', 'admin', '2023-06-14 00:00:00'),
	('04', '02', '01', 'test00', '2023-06-14 00:00:00'),
	('05', '01', '01', NULL, '2023-06-14 00:00:00'),
	('06', '02', '01', '', '2023-06-14 00:00:00'),
	('07', '02', '01', 'admin', '2023-06-14 00:00:00'),
	('08', '01', '01', NULL, '2023-06-14 00:00:00'),
	('09', '02', '01', '', '2023-06-14 00:00:00'),
	('10', '02', '01', '', '2023-06-14 00:00:00'),
	('11', '02', '01', '', '2023-06-14 00:00:00'),
	('12', '01', '01', NULL, '2023-06-14 00:00:00'),
	('13', '01', '01', NULL, '2023-06-14 00:00:00'),
	('14', '01', '01', NULL, '2023-06-14 00:00:00'),
	('15', '02', '01', 'admin', '2023-06-14 00:00:00'),
	('16', '02', '01', 'test', '2023-06-14 00:00:00'),
	('17', '02', '01', '', '2023-06-14 00:00:00'),
	('18', '02', '01', '', '2023-06-14 00:00:00'),
	('19', '01', '02', NULL, '2023-06-14 00:00:00'),
	('20', '01', '02', NULL, '2023-06-14 00:00:00'),
	('21', '01', '02', NULL, '2023-06-14 00:00:00');
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;

-- 테이블 studycafe.seat_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `seat_comment` (
  `seat_comment` varchar(2) DEFAULT NULL,
  `seat_comment_data` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.seat_comment:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `seat_comment` DISABLE KEYS */;
INSERT INTO `seat_comment` (`seat_comment`, `seat_comment_data`) VALUES
	('01', '빈 자리'),
	('02', '사용중'),
	('03', '예약');
/*!40000 ALTER TABLE `seat_comment` ENABLE KEYS */;

-- 테이블 studycafe.seat_type 구조 내보내기
CREATE TABLE IF NOT EXISTS `seat_type` (
  `seat_type` varchar(2) DEFAULT NULL,
  `seat_type_name` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.seat_type:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `seat_type` DISABLE KEYS */;
INSERT INTO `seat_type` (`seat_type`, `seat_type_name`) VALUES
	('01', '좌석'),
	('02', '룸');
/*!40000 ALTER TABLE `seat_type` ENABLE KEYS */;

-- 테이블 studycafe.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` varchar(10) NOT NULL,
  `user_pwd` varchar(400) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(50) DEFAULT NULL,
  `user_cp` varchar(50) DEFAULT NULL,
  `user_addr` varchar(50) DEFAULT NULL,
  `user_daddr` varchar(50) DEFAULT NULL,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `joinDate` datetime DEFAULT NULL,
  `user_grade` varchar(50) NOT NULL DEFAULT 'E',
  `user_type_cd` varchar(2) NOT NULL DEFAULT '02',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.user:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `user_pwd`, `user_name`, `user_email`, `user_cp`, `user_addr`, `user_daddr`, `regDate`, `joinDate`, `user_grade`, `user_type_cd`) VALUES
	('adadsadg', '8fda6fd2cfc0477f803d4dc87d20b16a03ad76988796ef68dd8c61b31489dfa3', '1234', NULL, '1234', NULL, NULL, '2023-06-19 20:05:19', NULL, 'E', '02'),
	('admin', '5994471ABB01112AFCC18159F6CC74B4F511B99806DA59B3CAF5A9C173CACFC5', '관리자', '관리자', '관리자', '관리자', '관리자', '2023-06-13 00:00:00', '2023-06-23 00:00:00', 'A', '01'),
	('dadqwdsad', '8fda6fd2cfc0477f803d4dc87d20b16a03ad76988796ef68dd8c61b31489dfa3', '1234', NULL, '1234', NULL, NULL, '2023-06-19 20:05:19', NULL, 'E', '02'),
	('test', '5994471ABB01112AFCC18159F6CC74B4F511B99806DA59B3CAF5A9C173CACFC5', '1234', NULL, '1234', NULL, NULL, '2023-06-19 20:05:19', '2023-06-23 00:00:00', 'E', '02'),
	('test00', '7a4d09cc57199ab3a559bb3203ea4ff733b713e098e731237c54f962a321eeae', '박성언', 'test@test11.com', '01000000000', '경기 안산시 상록구 광덕1로 293 (이동)', '111', '2023-06-23 14:31:02', '2023-06-23 00:00:00', 'E', '02');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- 테이블 studycafe.user_type_cd 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_type_cd` (
  `user_type_cd` varchar(2) NOT NULL,
  `USER_TYPE_NAME` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.user_type_cd:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user_type_cd` DISABLE KEYS */;
INSERT INTO `user_type_cd` (`user_type_cd`, `USER_TYPE_NAME`) VALUES
	('01', '관리자'),
	('02', '일반');
/*!40000 ALTER TABLE `user_type_cd` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
