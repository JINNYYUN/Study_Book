/*scott계정*/
--각 사원의 이름을 표시하고 근무 달 수(입사일로부터 현재까지의 달수)를 계산하여 열 레이블을 MONTHS_WORKED로 지정하시오. 
--결과는 정수로 반올림하여 표시하고 근무달 수를 기준으로 오름차순으로 정렬하시오.
SELECT ENAME, ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS MONTHS_WORKED
FROM EMP
ORDER BY  MONTHS_WORKED ASC;

-- emp테이블에서 이름, 업무, 근무연차를 출력하시오.
SELECT ENAME, JOB, TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12) AS 근무연차
FROM EMP;


--emp테이블에서 사원이름, 월급, 월급과 커미션을 더한 값을 컬럼명 실급여라고 해서 출력.
--단, NULL값은 나타나지 않게 작성하시오.
SELECT ENAME, SAL, SAL+NVL(COMM,0) AS 실급여
FROM EMP;


--월급과 커미션을 합친 금액이 2,000이상인 급여를 받는 사원의 이름,업무,월급,커미션,고용날짜 를 출력하시오.\
--단, 고용날짜는 1980-12-17 형태로 출력하시오.
SELECT ENAME, JOB, SAL, COMM, to_char(hiredate, 'YYYY-MM-DD')
FROM EMP
WHERE SAL+NVL(COMM,0) >= 2000;


--모든 사원의 급여의 최고액, 최저액, 총액 및 평균액을 표시하시오. 
--열 레이블을 각각maximum,minimum, 및 average로 지정하고 결과를 정수로 반올림하고 세자리 단위로,를 명시하시오.
SELECT TO_CHAR(ROUND(MAX(SAL)), '999,999,999') AS maximum, 
        TO_CHAR(ROUND(MIN(SAL)), '999,999,999') AS minimum, 
        TO_CHAR(ROUND(SUM(SAL)), '999,999,999') AS sum,
        TO_CHAR(ROUND(AVG(SAL)), '999,999,999') AS average
FROM EMP;


-- 업무가 동일한 사원 수를 표시하는 질의를 작성하시오.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB;

-- emp테이블에서 30번부서의 사원수를 구하시오.
SELECT COUNT(*)
FROM EMP
WHERE DEPTNO =30;

--emp테이블에서 업무별 최고 월급을 구하고 업무,최고 월급을 출력하시오.
SELECT JOB, MAX(SAL)
FROM EMP
GROUP BY JOB;

--emp테이블에서 20번부서의 급여 합계를 구하고 급여 합계 금액을 출력하시오.
SELECT SUM(SAL) AS "20번 부서의 급여 합계"
FROM EMP
WHERE DEPTNO =20;

--emp테이블에서 부서별로 지급되는 총월급에서 금액이 7,000이상인 부서번호, 총월급을
    출력하시오.
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)>=7000;


--emp테이블에서 업무별로 사번이 제일 늦은 사람을 구하고 그 결과 내에서 사번이 79로 시작하는
    결과만 보여주시오.
SELECT job, MAX(empno)
FROM emp
GROUP BY job
HAVING MAX(empno) LIKE '79%';
    

--emp테이블에서 업무별 총월급을 출력하는데 업무가 'MANAGER'인 사원들은 제외하고 
    총월급이 5,000보다 큰 업무와 총월급만 출력하시오.
SELECT JOB, SUM(SAL)
FROM EMP
WHERE JOB != 'MANAGER'
GROUP BY JOB
HAVING SUM(SAL)>5000;


--emp테이블에서 업무별로 사원수가 4명 이상인 업무와 인원수를 출력하시오.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(*)>=4;

--emp테이블에서 사원수가 5명이 넘는 부서의 부서번호와 사원수를 구하시오.
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*)>5;


--emp테이블에서 부서별 급여평균을 구할 때 소수점 3자리에서 반올림해서 2자리까지 구하고 부서번호, 급여평균을 출력하시오.
SELECT  DEPTNO,ROUND(AVG(SAL),2)
FROM EMP
GROUP BY DEPTNO;


/*HR계정*/
--문제1) EMPLOYEES 테이블에서 모든 SALESMAN(SA_MAN)에 대하여 급여의 평균, 최고액, 최저액, 합계를 구하여 출력하여라.
SELECT AVG(SALARY), MAX(SALARY), MIN(SALARY), SUM(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'SA_%';

--문제2) EMPLOYEES 테이블에 등록되어 있는 인원수, 보너스가 NULL이 아닌 인원수, 보너스의 평균, 등록되어 있는 부서의 수를 구하여 출력하라.
SELECT COUNT(*), COUNT(COMMISSION_PCT), ROUND(AVG(COMMISSION_PCT),3), COUNT(DISTINCT(DEPARTMENT_ID))
FROM EMPLOYEES;


--문제3) EMPLOYEES 테이블에서 부서별로 인원수, 평균 급여, 최저급여, 최고 급여, 급여의 합을 구하여 출력하라.
SELECT DEPARTMENT_ID, COUNT(*), AVG(SALARY), MIN(SALARY), MAX(SALARY), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

--문제4) EMPLOYEES 테이블에서 각 부서별로 인원수,급여의 평균, 최저 급여, 최고 급여, 급여의 합을 구하여 급여의 합이 많은 순으로 출력하여라.
SELECT DEPARTMENT_ID, COUNT(*), AVG(SALARY), MIN(SALARY), MAX(SALARY), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY SUM(SALARY) DESC;

--문제5) EMPLOYEES 테이블에서 부서별, 업무별 그룹하여 결과를 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하여 출력하여라.
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*), TRUNC(AVG(SALARY)), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID;


-- 문제6) EMPLOYEES 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호,인원수, 급여의 합을 구하여 출력하여라.(GROUP BY, HAVING)
SELECT DEPARTMENT_ID, COUNT(*), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>4;

--문제7) EMPLOYEES 테이블에서 급여가 최대 10000이상인 부서에 대해서 부 서번호, 평균 급여, 급여의 합을 구하여 출력하여라.
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY)), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY)>= 10000;


-- 문제8) EMPLOYEES 테이블에서 업무별 급여의 평균이 10000 이상인 업무에 대해서 업무명,평균 급여, 급여의 합을 구하여 출력하라.
SELECT JOB_ID, TRUNC(AVG(SALARY)), SUM(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY)>= 10000;


--문제9) EMPLOYEES 테이블에서 젂체 월급이 10000을 초과하는 각 업무에 대해서 업무와 월급여 합계를 출력하라. 
--단 판매원은 제외하고 월 급여 합계로  정렬(내림차순)하라.(SA_)
SELECT JOB_ID,SUM(SALARY)
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA_%'
GROUP BY JOB_ID
HAVING AVG(SALARY)> 10000
ORDER BY SUM(SALARY) DESC;