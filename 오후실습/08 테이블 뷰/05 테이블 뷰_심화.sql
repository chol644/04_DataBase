-- 심화1
USE tabledb;
-- 다음 컬럼을 가지는 userTBL과 buyTBL을 정의하세요.
-- 기존에 테이블이 존재하면 삭제함
DROP TABLE IF EXISTS buytbl; -- 외래키 때문에 먼저 buyTBL 삭제
DROP TABLE IF EXISTS usertbl;

-- userTBL
CREATE TABLE usertbl
(
    userID    CHAR(8)     NOT NULL,
    name      VARCHAR(10) NOT NULL,
    birthyear INT         NOT NULL,
    PRIMARY KEY (userID)
);
-- buyTBL
CREATE TABLE buytbl
(
    num      INT     NOT NULL AUTO_INCREMENT,
    userID   CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    PRIMARY KEY (num),
    FOREIGN KEY (userID) REFERENCES usertbl (userID)
);

-- 다음 조건을 만족하는 userTBL 테이블을 정의하세요
-- 기존 userTBL 삭제
DROP TABLE IF EXISTS usertbl;
-- userTBL
CREATE TABLE usertbl
(
    userID    CHAR(8) NOT NULL PRIMARY KEY,
    name      VARCHAR(10),
    birthYear INT CHECK (birthYear BETWEEN 1900 AND 2023),
    mobile    CHAR(3) NOT NULL
);

-- 다음 조건을 만족하는 userTBL 테이블을 정의하세요.
-- 기존 userTBL 삭제
DROP TABLE IF EXISTS usertbl;
-- userTBL
CREATE TABLE usertbl
(
    userID    CHAR(8)     NOT NULL PRIMARY KEY,
    name      VARCHAR(10) NOT NULL,
    birthYear INT         NOT NULL DEFAULT -1,
    addr      CHAR(2)     NOT NULL DEFAULT '서울',
    mobile1   CHAR(3),
    mobile2   CHAR(8),
    height    SMALLINT             DEFAULT 170,
    mDate     DATE
);
-- 기본 값 추가 확인할 데이터 추가
INSERT INTO usertbl (userID, name)
VALUES ('hyejin', '김혜진');
SELECT * FROM userTBL;

-- mobile1 컬럼 삭제
ALTER TABLE userTBL
    DROP COLUMN mobile1;

-- name 컬럼명 uName으로 변경
ALTER TABLE userTBL
    CHANGE COLUMN name uName VARCHAR(10);

-- 기본키 제거
ALTER TABLE userTBL
    DROP PRIMARY KEY;
-- 심화2
USE employees;
-- 다음 정보를 가지는 직원 정보를 출력하는 EMPLOYEES_INFO 뷰를 작성하세요
CREATE OR REPLACE VIEW EMPLOYEES_INFO AS
SELECT e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date,
       t.title, t.from_date AS t_from, t.to_date AS t_to, s.salary, s.from_date AS s_from, s.to_date AS s_to
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
JOIN salaries s ON e.emp_no = s.emp_no;
-- EMPLOYEES_INFO 뷰에서 재직자의 현재 정보만 출력하세요.
SELECT * FROM EMPLOYEES_INFO
WHERE DATE(t_to) = '9999-01-01';
-- 다음 정보를 가지는 부서 정보를 출력하는 EMP_DEPT_INFO 뷰를 작성하세요
CREATE OR REPLACE VIEW EMP_DEPT_INFO AS
SELECT de.emp_no, de.dept_no, dm.dept_name, de.from_date, de.to_date
FROM dept_emp de
JOIN departments dm ON de.dept_no = dm.dept_no;

