-- tabledb 데이터베이스를 생성하세요.
DROP DATABASE IF EXISTS tabledb;
CREATE DATABASE tabledb;
USE tabledb;

-- usertbl 테이블 생성
CREATE TABLE usertbl
(
    userID    CHAR(8)     NOT NULL PRIMARY KEY, -- 고정문자(8), 필수, 기본키
    name      VARCHAR(10) NOT NULL,             -- 가변문자(10), 필수
    birthyear INT         NOT NULL,             -- 정수, 필수
    addr      CHAR(2)     NOT NULL,             -- 고정문자(2), 필수
    mobile1   CHAR(3),                          -- 고정문자(3), 옵션
    mobile2   CHAR(8),                          -- 고정문자(8), 옵션
    height    SMALLINT,                         -- 작은정수, 옵션
    mDate     DATE                              -- 날짜, 옵션
);
-- 다음 컬럼을 가지는 buytbl 테이블을 만드세요.
CREATE TABLE buytbl
(
    num       INT      NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 정수, 필수, 기본키, 자동 증가
    userID    CHAR(8)  NOT NULL,                            -- 고정문자(8), 필수
    prodName  CHAR(6)  NOT NULL,                            -- 고정문자(6), 필수
    groupName CHAR(4),                                      -- 고정문자(4), 옵션
    price     INT      NOT NULL,                            -- 정수, 필수
    amount    SMALLINT NOT NULL,                            -- 작은정수, 필수
    FOREIGN KEY (userID) REFERENCES usertbl (userID)        -- 외래키 제약조건
);

INSERT INTO usertbl (userID, name, birthyear, addr, mobile1, mobile2, height, mDate)
VALUES ('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-08-08'),
       ('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-04-04'),
       ('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-07-07');
INSERT INTO buytbl (userID, prodName, groupName, price, amount)
VALUES ('KBS', '운동화', NULL, 30, 2),
       ('KBS', '노트북', '전자', 1000, 1);
-- 'JYP'라는 userID가 usertbl에 존재하지 않기 때문에 에러 발생함
-- 외래키 제약 조건 위반하면 삽입 시 오류 발생. 참조 무결성 위반.
-- ('JYP', '모니터', '전자', 200, 1);

-- 기존 usertbl이 존재하는 경우 삭제함
DROP TABLE IF EXISTS usertbl2;
-- 기본키는 테이블 레벨에서 정의하고 제약조건명을 함께 지정함
CREATE TABLE usertbl2
(
    userID    CHAR(8)     NOT NULL,
    name      VARCHAR(10) NOT NULL,
    birthyear INT         NOT NULL,
    PRIMARY KEY (userID) -- 테이블 레벨에서 기본키 지정
);
-- 다음 컬럼을 가지는 prodTbl 을 정의하세요.
-- 기존 prodTbl이 존재하는 경우 삭제함
DROP TABLE IF EXISTS prodTbl;

-- 테이블 생성
CREATE TABLE prodTbl
(
    prodCode CHAR(3)  NOT NULL,
    prodID   CHAR(4)  NOT NULL,
    prodDate DATETIME NOT NULL,
    proCur   CHAR(10),
    PRIMARY KEY (prodCode, prodID) -- 복합 기본키
);

-- usertbl과 buytbl을 바탕으로 다음 결과가 나오는 뷰를 정의하세요.
CREATE OR REPLACE VIEW user_buy_view AS
SELECT u.userID, u.name, b.prodName, u.addr, CONCAT(u.mobile1, u.mobile2) AS 연락처
FROM usertbl u
    JOIN buytbl b ON u.userID = b.userID;

-- 위에서 정의한 뷰에서 userid가 '김범수'인 데이터만 출력하세요.
SELECT *
FROM user_buy_view
WHERE name = '김범수';
