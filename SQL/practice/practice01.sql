/*scott계정*/
--EMP테이블에서 사원번호, 사원이름, 월급을 출력하시오.
SELECT EMPNO AS 사원번호, ENAME AS 사원이름, SAL AS 월급
FROM EMP;

--EMP테이블에서 사원이름과 월급을 출력하는데 컬럼명은 이름, 월급으로 바꾸어 출력
SELECT ENAME AS 사원이름, SAL AS 월급
FROM EMP;

--EMP테이블에서 사원번호, 사원이름, 월급, 연봉을 구하고 각각 컬럼명은 사원번호, 사원이름, 월급, 연봉으로 출력
SELECT EMPNO AS 사원번호, ENAME AS 사원이름, SAL AS 월급, SAL*12 AS 연봉
FROM EMP;

--EMP테이블의 업무를 중복되지 않게 표시하시오
SELECT DISTINCT JOB
FROM EMP;

--EMP테이블의 사원명과 업무로 연결(SMITH,CLERK)해서 표시하고 컬럼명은 EMPLOYEE AND JOB로 표시
SELECT '('|| ENAME || ','|| JOB ||')' AS "EMPLOYEE AND JOB"
FROM EMP;

--emp 테이블에서 사원번호가 7698 인 사원의 이름, 업무, 급여를 출력하시오.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE EMPNO = 7698;

-- emp 테이블에서 사원이름이 SMITH인 사람의 이름과 월급, 부서번호를 구하시오.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE ENAME = 'SMITH';

--월급이 2500이상 3500미만인 사원의 이름, 입사일, 월급을 구하시오.
SELECT ENAME, HIREDATE, SAL
FROM EMP
WHERE SAL >=2500 AND SAL <3500;
-- WHERE SAL BETWEEN 2500 AND 3500; 3500'미만'이기 때문에 비교 연산자를 사용.

--  급여가 2000에서 3000사이에 포함되지 않는 사원의 이름, 업무, 급여를 출력하시오.
SELECT ENAME, HIREDATE, SAL
FROM EMP
WHERE SAL NOT BETWEEN 2500 AND 3500;

--81년05월01일과 81년12월03일 사이에 입사한 사원의 이름, 급여, 입사일을 출력하시오
SELECT ENAME, HIREDATE, SAL
FROM EMP
WHERE HIREDATE >= '81/05/01' AND HIREDATE <= '81/12/03';

--emp테이블에서 사원번호가 7566,7782,7934인 사원을 제외한 사람들의 사원번호,이름, 월급을 출력하시오.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN(7566,7782,7934);

-- 부서번호 30(deptno)에서 근무하며 월 2,000달러 이하를 받는 81년05월01일 이전에 입사한 사원의 이름, 급여, 부서번호, 입사일을 출력하시오.
SELECT ENAME, SAL, DEPTNO, HIREDATE
FROM EMP
WHERE DEPTNO=30 
    AND SAL<=2000 
    AND HIREDATE < '81/05/01';
	--AND HIREDATE < TO_DATE('19810501', 'YYYYMMDD'); 로도 쓸 수 있다

--emp테이블에서 급여가 2,000와 5,000 사이고 부서번호가 10 또는 30인 사원의 이름과 급여,부서번호를 나열하시오.
SELECT ENAME, SAL, DEPTNO 
FROM EMP
WHERE (SAL BETWEEN 2000 AND 5000) --헷갈릴 수도 있으니, '()'를 사용해서 구별해주자.
    AND (DEPTNO = 10 OR DEPTNO = 30);

/*서브쿼리 이용*/
SELECT * 
FROM (SELECT ENAME, SAL, DEPTNO 
    FROM EMP
    WHERE SAL BETWEEN 2000 AND 5000)
WHERE DEPTNO = 10 OR DEPTNO = 30;

--업무가 SALESMAN 또는 MANAGER이면서 급여가 1,600, 2,975 또는 2,850이 (아닌) 모든 사원의 이름, 업무 및 급여를 표시하시오.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE JOB IN('SALESMAN', 'MANAGER') AND SAL NOT IN(1600, 2975, 2850);

-- emp테이블에서 사원이름 중 S가 포함되지 않은 사람들 중 부서번호가 20인 사원들의 이름과 부서번호를 출력하시오.
SELECT ENAME, DEPTNO 
FROM EMP
WHERE ENAME NOT LIKE('%S%');

-- emp테이블에서 이름에 A와 E가 있는 모든 사원의 이름을 표시하시오.
SELECT ENAME
FROM EMP
WHERE ENAME LIKE('%A%') OR ENAME LIKE('%E%');

--emp테이블에서 관리자가 없는 모든 사원의 이름과 업무를 표시하시오.
SELECT ENAME, JOB
FROM EMP
WHERE MGR IS NULL;

--emp테이블에서 커미션 항목이 입력된 사원들의 이름과 급여, 커미션을 구하시오.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM IS NOT NULL;


/*HR계정*/
--EMPLOYEES Table의 모든 자료를 출력하여라.
SELECT * FROM employees;

--EMPLOYEES Table의 컬럼들을 모두 출력하라.
DESC EMPLOYEES;

--EMPLOYEES Table에서 사원 번호, 이름, 급여, 담당업무를 출력하여라.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM EMPLOYEES;

--모든 종업원의 급여를 $300증가 시키기 위해서 덧셈 연산자를 사용하고 결과에 SALARY+300을 디스플레이 합니다.
SELECT FIRST_NAME, SALARY, SALARY+300
FROM EMPLOYEES;

--EMP 테이블에서 사원번호, 이름, 급여, 보너스, 보너스 금액을 출력하여라. (참고로 보너스는 월급 + (월급*커미션))
SELECT EMPLOYEE_ID,FIRST_NAME, SALARY, COMMISSION_PCT+SALARY, SALARY+(COMMISSION_PCT+SALARY)
FROM EMPLOYEES;

--EMPLOYEES 테이블에서 LAST_NAME을 이름으로 SALARY을 급여로 출력하여라.
SELECT LAST_NAME AS 이름, SALARY AS 급여
FROM EMPLOYEES;

--EMPLOYEES 테이블에서 LAST_NAME을 Name으로 SALARY *12를 Annual Salary(연봉)로 출력하여라
SELECT LAST_NAME AS "NAME", SALARY *12 AS "Annual Salary(연봉)"
FROM EMPLOYEES;

--EMPLOYEES 테이블에서 이름과 업무를 연결하여 출력하여라.
SELECT FIRST_NAME || ' ' || JOB_ID AS EMPLOYEES
FROM EMPLOYEES;

--EMPLOYEES 테이블에서 이름과 업무를 “KING is a PRESIDENT” 형식으로 출력하여라.
SELECT FIRST_NAME || ' is a ' || JOB_ID AS "Employees details"
FROM EMPLOYEES;

--EMPLOYEES 테이블에서 이름과 연봉을 “KING: 1 Year salary = 60000” 형식으로 출력하여라.
SELECT FIRST_NAME || ': 1 Year salary = ' || SALARY *12 AS "MONTHLY"
FROM EMPLOYEES;

--EMPLOYEES 테이블에서 JOB을 모두 출력하라.
SELECT JOB_ID FROM EMPLOYEES;

--EMPLOYEES 테이블에서 급여가 3000이상인 사원의 정보를 사원번호,이름, 담당업무, 급여를 출력하라.
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY >=3000;

--EMPLOYEES 테이블에서 담당 업무가 Manager인 사원의 정보를 사원번호, 성명, 담당업무, 급여, 부서번호를 출력하라
--(Manager == ST_MAN)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID = 'ST_MAN';

--EMPLOYEES 테이블에서 입사일자가 1982년 1월 1일 이후에 입사한 사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라.
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_ID
FROM EMPLOYEES
WHERE HIRE_DATE > '82/01/01';

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_ID
FROM EMPLOYEES
WHERE HIRE_DATE > TO_DATE('20060101','YYYYMMDD');


--EMPLOYEES 테이블에서 급여가 3000에서 5000사이의 정보를 성명, 담당업무, 급여, 부서번호를 출력하라.
--(AND만 사용, BETWEEN도 함께 사용)
SELECT LAST_NAME, JOB_ID, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY BETWEEN 3000 AND 5000;

--EMPLOYEES 테이블에서 사원번호가 145,152,203인 사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자를 출력하라
--(IN만 사용, OR만 사용)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(145, 152, 203);


--EMPLOYEES 테이블에서 입사일자가 05년도에 입사한 사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라.
--(LIKE 사용)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_ID
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '05%';

--EMPLOYEES 테이블에서 보너스가 NULL인 사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자, 보너스, 부서번호를 출력하라.
--(IS 사용)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT_ID
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

-- EMPLOYEES 테이블에서 급여가 1100이상이고 JOB이 Manager인 사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라
--(AND사용, ST_MAN)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY >= 1100 AND JOB_ID ='ST_MAN';

--EMPLOYEES 테이블에서 급여가 10000이상이거나 JOB이 Manager인사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라 
--(OR사용, ST_MAN)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, HIRE_DATE, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY >= 10000 OR JOB_ID ='ST_MAN';

-- EMPLOYEES 테이블에서 급여가 JOB이 ST_MAN, SA_MAN, SA_REP 가 아닌 사원의 정보를 사원번호, 성명, 담당업무, 급여, 부서번호를 출력하라
--(NOT IN 사용)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID NOT IN('ST_MAN', 'SA_MAN', 'SA_REP');

--업무가 PRESIDENT이고 급여가 12000이상이거나 업무가 SALESMAN인 사원의 정보를 사원번호, 이름, 업무, 급여를 출력하라.
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'AD_PRES'
    AND SALARY >=12000
    OR JOB_ID ='SA_MAN';

-- 업무가 PRESIDENT또는 SALESMAN이고 급여가 12000이상이거나 사원의 정보를 사원번호, 이름, 업무, 급여를 출력하라.
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'AD_PRES'
    OR JOB_ID ='SA_MAN'
    AND SALARY >=12000;