-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.10.4-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
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
  `FILE_NAME` varchar(100) DEFAULT NULL,
  `REG_DATE` date NOT NULL DEFAULT current_timestamp(),
  `kate_no` int(10) NOT NULL,
  `vote_no` int(5) NOT NULL DEFAULT 0,
  `cnt` int(5) DEFAULT NULL,
  PRIMARY KEY (`brd_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board:~0 rows (대략적) 내보내기

-- 테이블 studycafe.board_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_comment` (
  `parent_no` int(10) NOT NULL,
  `com_no` int(10) NOT NULL,
  `com_content` varchar(50) NOT NULL,
  `regData` date NOT NULL DEFAULT current_timestamp(),
  `modeData` date DEFAULT NULL,
  PRIMARY KEY (`com_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.board_comment:~0 rows (대략적) 내보내기

-- 테이블 studycafe.kategorie 구조 내보내기
CREATE TABLE IF NOT EXISTS `kategorie` (
  `kate_no` int(10) NOT NULL AUTO_INCREMENT,
  `kate_name` varchar(10) NOT NULL,
  `user_type_cd` varchar(2) NOT NULL,
  PRIMARY KEY (`kate_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.kategorie:~2 rows (대략적) 내보내기
INSERT INTO `kategorie` (`kate_no`, `kate_name`, `user_type_cd`) VALUES
	(1, '게시판', ''),
	(2, '공지사항', ''),
	(3, '유저목록', '');

-- 테이블 studycafe.user 구조 내보내기
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
INSERT INTO `user` (`user_id`, `user_pwd`, `user_name`, `user_email`, `user_cp`, `user_addr`, `user_daddr`, `regData`, `joinData`, `user_grade`, `user_type_cd`) VALUES
	('admin', '12345', '관리자', '관리자', '관리자', '관리자', '관리자', '2023-06-13', NULL, 'E', '01');

-- 테이블 studycafe.user_type_cd 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_type_cd` (
  `user_type_cd` varchar(2) NOT NULL,
  `USER_TYPE_NAME` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 studycafe.user_type_cd:~2 rows (대략적) 내보내기
INSERT INTO `user_type_cd` (`user_type_cd`, `USER_TYPE_NAME`) VALUES
	('01', '관리자'),
	('02', '일반');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
