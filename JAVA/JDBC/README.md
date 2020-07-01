# JDBC

JDBC(Java Database Connectivity)는 자바에서 데이터베이스에 접속할 수 있도록 하는 자바 API이다. 자바 언어로 다양한 종류의 관계형 데이터베이스에 접속하고 SQL문을 수행하여 처리할 수 있다. 접속하려는 DBMS서버에 맞는 JDBC드라이버가 필요하다.

자바 어플리케이션 -JDBC API(인터페이스) - JDBC 드라이버 - 데이터 베이스 

</br>

### 1) JDBC 드라이버 로딩(생략가능)

```java
Class.forName(“oracle.jdbc.driver.OracleDriver”);

//오라클 : oracle.jdbc.driver.OracleDriver
//MySQL : com.mysql.jdbc.Driver
//MSSQL : com.microsoft.sqlserver.jdbc.SQLServerDriver
//JDBC드라이버 파일 안에서 드라이버 인터페이스를 상속하고 있는 클래스이름을 패키지 이름과 함께 정확하게 명시해 주어야 한다.
```

Class.forName( ) 에 의해  "com.mysql.jdbc.Driver" 클래스가 JVM이 할당하는 메모리에 로드되고, Driver클래스의 static절이 실행된다. 이때 DriverManager.registerDriver() 메소드를 통해 **DriverManager**에 해당 드라이버가 레지스터 된다. (= Class.forName() 메소드 호출로 JDBC 드라이버 인스턴스가 생성되어 초기화되는 이유 )

- Driver클래스

    ```java
    public class SomeDriver implements Driver {
      static {
        try {
    			//인스턴스를 생성하고, DriverManager에 등록한다.
          DriverManager.registerDriver(new SomeDriver());
        } catch (SQLException e) {
          // TODO Auto-generated catch block
        }
      }
      //etc: implemented methods
    }
    ```

cf) JDBC API 4.0부터 DriverManager.getConnection() 메소드가 개선되어 드라이버를 자동으로 로드할 수 있다.

```java
//로딩 직후 바로 실행되도록 static으로 설정
public static void initConnection() {
	try {
		//Class.forName()을 이용해서 드라이버 로드 > JDBC 드라이버 인스턴스가 생성
		Class.forName("oracle.jdbc.driver.OracleDriver"); //forName() : 클래스의 유뮤를 파악하는 함수		
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		System.out.println("Driver Loading Success");
	} 
}
```

</br>

### 2) DBMS 서버 접속

 **DriverManager**에 해당 드라이버가 레지스터되었기 때문에 DriverManager는 이 정보를 가지고 getConnection을 할 수있다. DriverManager.getConnection( )은 실제 자바 프로그램과 데이터베이스를 네트워크상에서 연결해주는 메소드이며, 연결에 성공하면 **DB와 연결된 상태를 Connection 객체로 표현하여 반환**한다.

```java
//데이터 베이스와 연결하는 객체
Connection conn = DriverManager.getConnection
                  ("jdbc:oracle:thin:@localhost:1521:xe","hr","hr");

//String url : 접속할 서버의 URL이며, 프로토콜, 서버주소,서버포트, DB이름으로 구성된다.
//String user : DB서버에 로그인할 계정
//String password : DB서버에 로그인할 비밀번호
```

</br>

### 3) Statement, PreparedStatement 객체 생성

Statement는 고정된 SQL문을 실행하거나 그것이 만들어낸 결과들을 반환하는데 사용하는 오브젝트이다. 일종의 쿼리를 보내기 위해 필요한 권한을 얻는 과정 정도로 생가하면 된다. Statement에서 제공하는 메서드는 다음과 같다.

- `ResultSet executeQuery(String sql)` : executeQuery( ) 메소드가 반환하는 ResultSet은 select한 결과값을을 가지고 있습니다.
- `int executeUpate(String sql)` : executeUpdate( ) 메소드가 반환하는 숫자값은 SQL문이 실행된(update,delete,insert) 후 영양받은 레코드의 개수입니다.

**statement**

SQL문을 실행할 때 마다 SQL을 매 번 구문을 새로 작성해야하고 해석해야한다.

```java
//sql문 작성시 뛰어쓰기에 유의하자!
String sql = "SELECT ID, NAME, AGE, JOINDATE"
							+ " FROM USERTEST"
							+ " WHERE ID = '"+ id + "' ";

//쿼리 수행을 위한 Statement 객체 생성
//Connection 클래스의 createStatement( ) 메소드를 통해 Statement 객체 생성
Statement stmt = conn.createStatement(); //쿼리 실행 준비 완료

//쿼리 실행 결과를 가져온다. 
ResultSet rs = stmt.executeQuery(sql);
```

**PreparedStatement**

 SQL문을 미리 준비해 놓고 바인딩 변수 (?연산자)를 사용해서 반복되는 SQL문을 쉽게 처리할 수 있다.

```java
String sql = "SELECT ID, NAME, AGE, JOINDATE"
						+ " FROM USERTEST"
						+ " WHERE ID = ? "; //기존에 변수를 넣었던 부분에 ?연산자를 넣는다.

//Connection 클래스의 prepareStatement() 메소드를 사용해서 객체를 생성
PreparedStatement psmt = conn.prepareStatement(sql);
//인덱스를 String 값으로 지정한다.
psmt.setString(1, id);

//쿼리 실행 결과를 가져온다.
ResultSet rs=psmt.executeQuery();
```

</br>

### 4) ResultSet

executeQuery( ) 메소드에서 실행된 select 문의 결과값을 테이블 형태로 받아 가지고 있는 객체

```java
//next()다음에 레코드가 있는지 판단하여 없으면 false, 있으면 true를 반환하 다음에 커서를 다음 레코드로 이동
	if(rs.next()) { //데이터가 있는 경우
			String _id = rs.getString("ID"); //USERTEST 테이블에 있는 컬럼 명을 매개변수로 입력
			String _name = rs.getString("name");
			int _age = rs.getInt("age");
			String _joindate = rs.getString("joindate");
		}
```

</br>

### 5) 자원해제

객체들을 이용해 DB관련 처리 작업이 완료된 다음에는 사용했던 객체들을 메모리에서 해제해야 한다.

```java
try {
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
			if(rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
```

</br>

### SELECT 쿼리(다중행)

```java
//DTO클래스를 통해 객체로 관리할 것이다!
public List<UserDto> getUserList(){
		String sql = "SELECT ID, NAME, AGE, JOINDATE"
							+ " FROM USERTEST";
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<UserDto> list = new ArrayList<UserDto>();
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			//데이터가 있는지 확인하고 계속해서 반복한다.
			while(rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				int age = rs.getInt("age");
				String joindate = rs.getString("joindate");
				
				UserDto dto = new UserDto(id, name, age, joindate);
				
				//list뒤에 추가하자!
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return list;
	}
```

</br>

### INSERT 쿼리

```java
public int insertData(String id, String name, int age) {
		
		//Query -> String
		String sql = " INSERT INTO USERTEST(ID, NAME, AGE, JOINDATE)"
						+ " VALUES('"+id + "','" + name + "',"+ age + ", SYSDATE)";
		
		System.out.println("sql:" + sql);
		
		Connection conn = DBConnection.getConnection();
		Statement stat = null;
		
		int count = 0;	//몇 개가 변경되었는지 확인

		//현재 상태를 얻어온다.
		try {
			stat = conn.createStatement();

			//SQL문이 실행된 횟수를 반환
			count = stat.executeUpdate(sql);
			
			System.out.println("성공적으로 추가 되었습니다.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("데이터가 추가되지 않았습니다.");
		} finally {
			DBClose.close(stat, conn, null);
		}		
		return count;
	}

public static void main(String[] args) {
		DBConnection.initConnection();
		
		InsertTest it = new InsertTest();
		
		int count = it.insertData("asd", "정수동", 26);
		if(count==1) {
			System.out.println("데이터가 추가되었습니다.");
		}
	}
```

### UPDATE 쿼리

```java
//boolean을 반환해 UPDATE가 실행되었는지 확인한다.
public boolean Update(String id, int age) {
		String sql = " UPDATE USERTEST "
				+ " SET AGE = " + age + " "
				+ " WHERE ID = '" + id +"' ";
		System.out.println("sql:" + sql);
		
		Connection conn = DBConnection.getConnection();
		Statement stmt = null;
		
		int count = 0;
		
		try {
			/* Connection 객체가 제공하는 createStatement( ) 메소드를 사용*/
			stmt = conn.createStatement();
			
			//executeUpdate( ) 메소드가 반환하는 숫자값은 SQL문이 실행된(update,delete,insert) 후 영양받은 레코드의 개수
			count = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(stmt, conn, null);
		}
		
		return count>0 ? true : false;
}

public static void main(String[] args) {
		DBConnection.initConnection();
		
		UpdateTest ut = new UpdateTest();
		
		String id = "abc";
		int age = 23;
		
		boolean b = ut.Update(id, age);
		if(b == true) {
			System.out.println("정상적으로 수정되었습니다.");
		}
	}
```

### 참고

[https://opentutorials.org/module/3569/21377](https://opentutorials.org/module/3569/21377)

[https://stackoverflow.com/questions/4202252/how-does-class-forname-work](https://stackoverflow.com/questions/4202252/how-does-class-forname-work)

[https://kyun2.tistory.com/22?category=732999](https://kyun2.tistory.com/22?category=732999)