# WHERE절 연산자


- 비교 연산자 `>,<,>=,<=`  등가 비교 연산자  `=,!=,<>,^=`

```sql
HR계정

--이름이 줄리아인 사원만 추출
SELECT first_name, last_name, salary
FROM EMPLOYEES
WHERE FIRST_NAME = 'Julia';

--급여가 $9000이상인 사원
SELECT first_name, salary
FROM EMPLOYEES
WHERE salary >= 9000;

--이름이 Shanta보다 큰 이름
--아스키코드가 큰 이름
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME >= 'Shanta';

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME >= 'a';  --a의 아스키 코드는 97이다.
--데이터에 있는 이름은 대문자로 시작하기때문에 97보다 큰 값이 없어 출력되지 않는다.

```

<br>

### IS NULL 연산자

```sql
--빈문자 확인
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE MANAGER_ID = ''; --이건 빈문자이다. NULL과 빈문자는 다름. 따라서 출력값이 없음.

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL; --이건 빈문자가 아니다. 따라서 출력값이 없음.

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL; --Steven만 빼고 나머지 데이터 모두 출력 됨.
```
<br>


### AND, OR연산자

논리연산자를 사용해 여러 개의 조건식을 사용

```sql
--AND
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME = 'Shanta'
    AND LAST_NAME = 'Volluman';
    
--OR
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME = 'Shanta'
    OR LAST_NAME = 'John';

--이름 Jhon, 월급이 5000이상
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'John'
    AND SALARY >= 5000 ;
    
-- 2007년 12월 31일 이후에 입사한 사원을 출력
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE > '07/12/31';--날짜는 다음처럼 표현해주어야 한다. 문자열로 비교(날짜 형식에 맞춘 문자열)

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE > TO_DATE('20021231','YYYYMMDD'); --DATE형식으로 비교
```

<br>

### ALL(AND), ANY(OR)

```sql
--ALL
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = ALL('Shanta','Volluman');

--ANY
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = ANY('Shanta','John');
--WHERE FIRST_NAME = 'Shanta' OR FIRST_NAME = 'John'; 와 동일

SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = ANY(8000,3200,6000);
```

<br>

### IN, NOT IN

특정 열에 포함된 데이터를 여러 개 조회할 때 활용

```sql
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY IN(8000,3200,6000); --ANY와 동일. 8000 3200 6000 중 하나라면 모두 조회

SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT IN(8000,3200,6000); --조건을 제외한 나머지 , 지정된 금액 외의 다른 금액만 출력된다.

-- 다음 이름을 가진 사원의 정보만 추출하고 싶을 때
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME IN('Julia','John');
```

<br>

### BETWEEN 범위 연산자

일정 범위 내의 데이터를 조회할 때 사용

```sql
-- SALARY >= 3200 AND SALARY <= 9000
-- SALARY BETWEEN 3200 AND 9000

SELECT *
FROM EMPLOYEES
WHERE SALARY >= 3200 AND SALARY <= 9000;

SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN 3200 AND 9000;

-- SALARY < 3200 AND SALARY > 9000
-- SALARY NOT BETWEEN 3200 AND 9000
SELECT *
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 3200 AND 9000;
```

<br>

### LIKE / NOT LIKE

검색할 때 많이 사용 됨 > 사용 빈도수 엄청 높음

이메일이나 게시판 제목 또는 내용 검색 기능처럼 일부 문자열이 포함된 데이터를 조회할 때 사용

- _ : 어떤 값이든 상관없이 한 개의 문자 데이터를 의미
- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미

CF) -, %와 같이 특정 문자 또는 문자열을 대체하거나 문자열 데이터의 패턴을 표기하는 특수 문자를 와이드 카드라고 한다.

```sql
-- % : 글자 수에 관계없이 모두 허용
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'K%y'; --K로 시작하고 y로 끝나는 모든 사람

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'K%'; -- K로 시작하는 모든 사람

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%y'; -- Y로 끝나는 모든 사람.

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%e%'; -- 위치에 상관없이 e가 들어간 모든 사람.

--06년도 1월에 입사한 사람을 찾고 싶을 때
--AND 문법을 사용하면
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE > '05/12/31' AND HIRE_DATE < '06/02/01';

--LIKE를 사용하면
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '06/01%';

SELECT FIRST_NAME, PHONE_NUMBER
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '590%'; --전화번호를 통해 뉴욕에 있는 사람들을 추출할 수 있다.

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAM NOT LIKE '%AM%'; --사원 이름에 AM이 포함되어 있지 않은 사원 데이터 출력
```

만약 그 A_A문자를 가지고 있는 데이터를 찾고 싶다면?

```sql
SELECT *
FROM SOME_TABLE
WHERE SOME_COLUMN LIKE 'A￦_A%' ESCAPE '￦';
```

**ESCAPE문자**
'A￦_A%'에서 ￦문자 바로 뒤에 있는 _는 와이드 카드 기호가 아닌 데이터에 포함된 문자로 인식하라는 의미이다. ESCAPE문자 ￦는 EACAPE절에서 지정할 수 있다. (￦외 다른 문자도 지정하여 사용할 수 있다.)

<br>

### 집합연산자

**UNION**

```sql
SELECT job_id
FROM employees
WHERE job_id IN ('AD_VP', 'FI_ACCOUNT')
UNION ALL
SELECT job_id
FROM jobs
WHERE job_id IN('AD_VP', 'FI_ACCOUNT');
```

**INTERSECT**

```sql
SELECT employee_id
FROM employees
INTERSECT
SELECT manager_id
FROM employees;
```

- JOIN self

    ```sql
    SELECT DISTINCT b.employee_id
    FROM employees a, employees b
    WHERE a.manager_id = b.employee_id;
    ```

MINUS

```sql
-- 매니저가 아닌 사원
SELECT employee_id
FROM employees
MINUS
SELECT manager_id 
FROM employees;
```

- 차집합을 Join으로 표현

    ```sql
    SELECT e.first_name, e.department_id, d.department_id
    FROM employees e, departments d
    WHERE e.department_id = d.department_id(+)
    AND e.department_id IS NULL;
    ```