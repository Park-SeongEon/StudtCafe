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
DROP DATABASE IF EXISTS `studycafe`;
CREATE DATABASE IF NOT EXISTS `studycafe` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `studycafe`;

-- 테이블 studycafe.board 구조 내보내기
DROP TABLE IF EXISTS `board`;
CREATE TABLE IF NOT EXISTS `board` (
  `brd_no` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `content` varchar(4000) DEFAULT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  `regDate` date NOT NULL DEFAULT current_timestamp(),
  `kate_no` int(10) NOT NULL,
  `vote_no` int(5) NOT NULL DEFAULT 0,
  `cnt` int(5) DEFAULT NULL,
  PRIMARY KEY (`brd_no`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board:~18 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`brd_no`, `title`, `content`, `file_name`, `regDate`, `kate_no`, `vote_no`, `cnt`) VALUES
	(1, '132', '123', NULL, '2023-06-14', 0, 0, NULL),
	(2, '132', '123', NULL, '2023-06-14', 0, 0, NULL),
	(3, '132', '123', NULL, '2023-06-14', 0, 0, NULL),
	(4, '132', '123', NULL, '2023-06-14', 0, 0, NULL),
	(5, '132', '123', NULL, '2023-06-14', 0, 0, NULL),
	(6, '123', '132', NULL, '2023-06-14', 3, 0, NULL),
	(7, '123', '132', NULL, '2023-06-14', 3, 0, NULL),
	(8, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(9, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(10, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(11, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(12, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(13, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(14, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(15, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(16, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(17, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL),
	(18, 'title', 'content', NULL, '2023-06-14', 3, 0, NULL);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 studycafe.board_comment 구조 내보내기
DROP TABLE IF EXISTS `board_comment`;
CREATE TABLE IF NOT EXISTS `board_comment` (
  `parent_no` int(10) NOT NULL,
  `com_no` int(10) NOT NULL,
  `com_content` varchar(50) NOT NULL,
  `regData` date NOT NULL DEFAULT current_timestamp(),
  `modeData` date DEFAULT NULL,
  PRIMARY KEY (`com_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board_comment:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_comment` ENABLE KEYS */;

-- 테이블 studycafe.kategorie 구조 내보내기
DROP TABLE IF EXISTS `kategorie`;
CREATE TABLE IF NOT EXISTS `kategorie` (
  `kate_no` int(10) NOT NULL AUTO_INCREMENT,
  `kate_name` varchar(10) NOT NULL,
  `user_type_cd` varchar(2) NOT NULL DEFAULT '02',
  PRIMARY KEY (`kate_no`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.kategorie:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `kategorie` DISABLE KEYS */;
INSERT INTO `kategorie` (`kate_no`, `kate_name`, `user_type_cd`) VALUES
	(1, '공지사항', '01'),
	(2, '유저목록', '01'),
	(3, '게시판', '02');
/*!40000 ALTER TABLE `kategorie` ENABLE KEYS */;

-- 테이블 studycafe.seat 구조 내보내기
DROP TABLE IF EXISTS `seat`;
CREATE TABLE IF NOT EXISTS `seat` (
  `seat_no` varchar(2) NOT NULL,
  `seat_comment` varchar(2) NOT NULL DEFAULT '01',
  `seat_type` varchar(50) NOT NULL DEFAULT '',
  `user_id` varchar(10) DEFAULT NULL,
  `regdate` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`seat_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.seat:~21 rows (대략적) 내보내기
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` (`seat_no`, `seat_comment`, `seat_type`, `user_id`, `regdate`) VALUES
	('01', '01', '01', NULL, '2023-06-14'),
	('02', '01', '01', NULL, '2023-06-14'),
	('03', '01', '01', NULL, '2023-06-14'),
	('04', '01', '01', NULL, '2023-06-14'),
	('05', '01', '01', NULL, '2023-06-14'),
	('06', '01', '01', NULL, '2023-06-14'),
	('07', '01', '01', NULL, '2023-06-14'),
	('08', '01', '01', NULL, '2023-06-14'),
	('09', '01', '01', NULL, '2023-06-14'),
	('10', '01', '01', NULL, '2023-06-14'),
	('11', '01', '01', NULL, '2023-06-14'),
	('12', '01', '01', NULL, '2023-06-14'),
	('13', '01', '01', NULL, '2023-06-14'),
	('14', '01', '01', NULL, '2023-06-14'),
	('15', '01', '01', NULL, '2023-06-14'),
	('16', '01', '01', NULL, '2023-06-14'),
	('17', '01', '01', NULL, '2023-06-14'),
	('18', '01', '01', NULL, '2023-06-14'),
	('19', '01', '02', NULL, '2023-06-14'),
	('20', '01', '02', NULL, '2023-06-14'),
	('21', '01', '02', NULL, '2023-06-14');
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;

-- 테이블 studycafe.seat_comment 구조 내보내기
DROP TABLE IF EXISTS `seat_comment`;
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
DROP TABLE IF EXISTS `seat_type`;
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
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` varchar(10) NOT NULL,
  `user_pwd` varchar(10) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_cp` varchar(50) NOT NULL,
  `user_addr` varchar(50) NOT NULL,
  `user_daddr` varchar(50) NOT NULL,
  `regData` date NOT NULL DEFAULT current_timestamp(),
  `joinData` date DEFAULT NULL,
  `user_grade` varchar(50) NOT NULL DEFAULT 'E',
  `user_type_cd` varchar(2) NOT NULL DEFAULT '02',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.user:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `user_pwd`, `user_name`, `user_email`, `user_cp`, `user_addr`, `user_daddr`, `regData`, `joinData`, `user_grade`, `user_type_cd`) VALUES
	('admin', '12345', '관리자', '관리자', '관리자', '관리자', '관리자', '2023-06-13', NULL, 'E', '01');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- 테이블 studycafe.user_type_cd 구조 내보내기
DROP TABLE IF EXISTS `user_type_cd`;
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
