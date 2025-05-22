# 앞에서 정의한 3개의 테이블을 이용해서 다음을 처리하세요.
# ○ 학생 테이블, 동아리 테이블, 학생 동아리 테이블을 이용해서 학생을 기준으로
# 학생 이름/지역/가입한 동아리/동아리방을 출력하세요.
USE sqldb;
SELECT
    s.stdName AS 학생이름,
    s.addr AS 지역,
    c.clubName AS 동아리명,
    c.roomNo AS 동아리방
FROM
    stdtbl s
        JOIN stdclubtbl sc
            ON s.stdName = sc.stdName
        JOIN clubtbl c
            ON sc.clubName = c.clubName;

# 동아리를 기준으로 가입한 학생의 목록을 출력하세요.
#  출력정보: clubName, roomNo, stdName, addr
SELECT c.clubName 동아리명, c.roomNo 동아리방, s.stdName 학생이름, s.addr 지역
FROM clubtbl c
JOIN stdclubtbl sc On c.clubName = sc.clubName
JOIN stdtbl s ON sc.stdName = s.stdName;

# 앞에서 추가한 테이블에서 '우대리'의 상관 연락처 정보를 확인하세요.
#  출력할 정보: 부하직원, 직속상관, 직속상관연락처
SELECT e1.emp 부하직원, e1.manager 직속상관, e1.empTel 직속상관연락처
FROM emptbl e1
JOIN emptbl e2 ON e1.manager = e2.emp
WHERE e1.emp = '우대리';

# 현재 재직 중인 직원의 정보를 출력하세요
# ○ 출력 항목: emp_no, first_name, last_name, title
USE employees;
SELECT e.emp_no, e.first_name, e.last_name, t.title
FROM employees e
JOIN titles t On e.emp_no = t.emp_no;

# 현재 재직 중인 직원 정보를 출력하세요
# ○ 출력항목: 직원의 기본 정보 모두, title, salary
SELECT e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, t.title, s.salary
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
JOIN salaries s ON t.emp_no = s.emp_no;

# 현재 재직중인 직원의 정보를 출력하세요.
# ○ 출력항목: emp_no, first_name, last_name, department
# ○ 정렬: emp_no 오름 차순
SELECT e.emp_no, e.first_name, e.last_name, d.dept_no
FROM employees e
JOIN dept_emp d ON e.emp_no = d.emp_no
ORDER BY emp_no;

# 부서별 재직중인 직원의 수를 출력하세요.
# ○ 출력 항목: 부서 번호, 부서명, 인원수
# ○ 정렬: 부서 번호 오름차순
SELECT d.dept_no 부서번호, dt.dept_name 부서명, COUNT(e.emp_no) 인원수
FROM employees e
JOIN dept_emp d ON e.emp_no = d.emp_no
JOIN departments dt ON d.dept_no = dt.dept_no
WHERE d.to_date = '9999-01-01' -- 현재 재직중인 직원 조건
GROUP BY d.dept_no, dt.dept_name
ORDER BY d.dept_no;


# 직원 번호가 10209인 직원의 부서 이동 히스토리를 출력하세요.
# ○ 출력항목: emp_no, first_name, last_name, dept_name, from_date, to_date
SELECT e.emp_no 직원번호, e.first_name 이름, e.last_name 성, de.from_date 입사일, de.to_date 퇴사일
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments dt ON de.dept_no = dt.dept_no
WHERE e.emp_no = '10209';