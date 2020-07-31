package dto;

import java.io.Serializable;

/*
DROP TABLE MEMBER
CASCADE CONSTRAINTS;

CREATE TABLE MEMBER(
	EMAIL VARCHAR2(50) PRIMARY KEY,
	PWD VARCHAR2(50) NOT NULL,
	NAME VARCHAR2(50) NOT NULL,
	AUTH NUMBER(1) NOT NULL
)
*/


public class MemberDto implements Serializable{
	private String email;
	private String pwd;
	private String name;
	private int auth;
	
	public MemberDto() {
		
	}

	public MemberDto(String email, String pwd, String name, int auth) {
		super();
		this.email = email;
		this.pwd = pwd;
		this.name = name;
		this.auth = auth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [email=" + email + ", pwd=" + pwd + ", name=" + name + ", auth=" + auth + "]";
	}
}
