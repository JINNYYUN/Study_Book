DROP TABLE MEMBER
CASCADE CONSTRAINTS;

CREATE TABLE MEMBER(
	EMAIL VARCHAR2(50) PRIMARY KEY,
	PWD VARCHAR2(50) NOT NULL,
	NAME VARCHAR2(50) NOT NULL,
	AUTH NUMBER(1) NOT NULL
)
