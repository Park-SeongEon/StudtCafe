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
  `user_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`brd_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`brd_no`, `title`, `content`, `file_name`, `regDate`, `kate_no`, `vote_no`, `cnt`, `user_id`) VALUES
	(1, '132', '123', NULL, '2023-06-14 00:00:00', 3, 0, 0, '0'),
	(2, 'title', 'content', NULL, '2023-06-14 00:00:00', 3, 0, 0, '0');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 studycafe.board_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_comment` (
  `parent_no` int(10) NOT NULL,
  `com_no` int(10) NOT NULL,
  `com_content` varchar(50) NOT NULL,
  `regData` datetime NOT NULL DEFAULT current_timestamp(),
  `modeData` datetime DEFAULT NULL,
  PRIMARY KEY (`com_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board_comment:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_comment` ENABLE KEYS */;

-- 테이블 studycafe.kategorie 구조 내보내기
CREATE TABLE IF NOT EXISTS `kategorie` (
  `kate_no` int(10) NOT NULL AUTO_INCREMENT,
  `kate_name` varchar(10) NOT NULL,
  `user_type_cd` varchar(2) NOT NULL DEFAULT '02',
  PRIMARY KEY (`kate_no`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.kategorie:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `kategorie` DISABLE KEYS */;
INSERT INTO `kategorie` (`kate_no`, `kate_name`, `user_type_cd`) VALUES
	(1, '공지사항', '01'),
	(2, '유저목록', '01'),
	(3, '게시판', '02');
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
	('03', '01', '01', NULL, '2023-06-14 00:00:00'),
	('04', '01', '01', NULL, '2023-06-14 00:00:00'),
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
	('16', '01', '01', NULL, '2023-06-14 00:00:00'),
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

-- 테이블 데이터 studycafe.user:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `user_pwd`, `user_name`, `user_email`, `user_cp`, `user_addr`, `user_daddr`, `regDate`, `joinDate`, `user_grade`, `user_type_cd`) VALUES
	('1234', '8fda6fd2cfc0477f803d4dc87d20b16a03ad76988796ef68dd8c61b31489dfa3', '1234', NULL, '1234', NULL, NULL, '2023-06-19 20:05:19', NULL, 'E', '02'),
	('admin', '12345', '관리자', '관리자', '관리자', '관리자', '관리자', '2023-06-13 00:00:00', NULL, 'E', '01'),
	('test', 'test1234', '지완', NULL, '', '', NULL, '2023-06-15 19:16:03', NULL, 'E', '02'),
	('test00', 'test1111', '성언', NULL, '01096864790', NULL, NULL, '2023-06-19 16:18:03', NULL, 'E', '02'),
	('test1', 'test1111', '성언', NULL, '01096864790', NULL, NULL, '2023-06-16 17:28:33', NULL, 'E', '02'),
	('test22', 'test1234', '박성언', NULL, '1111', NULL, NULL, '2023-06-16 17:24:35', NULL, 'E', '02');
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
