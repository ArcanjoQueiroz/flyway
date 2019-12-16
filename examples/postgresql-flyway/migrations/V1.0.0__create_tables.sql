CREATE TABLE COUNTRY (
ID          INTEGER       NOT NULL,
NAME        VARCHAR(255)  NOT NULL,
CONSTRAINT PK_COUNTRY PRIMARY KEY (ID));

CREATE TABLE PROFESSION (
ID          INTEGER       NOT NULL,
NAME        VARCHAR(255)  NOT NULL,
CONSTRAINT PK_PROFESSION PRIMARY KEY (ID));

CREATE TABLE PERSON (
ID 		      INTEGER		    NOT NULL,
NAME		    VARCHAR(200)	NOT NULL,
GENDER		  VARCHAR(1)	  NOT NULL,
BIRTH		    DATE		      NOT NULL,
PROFESSION	INTEGER,
ADDRESS		  VARCHAR(200),
CITY		    VARCHAR(200),
STATE		    VARCHAR(200),
ZIP_CODE	  VARCHAR(9),
COUNTRY		  INTEGER,
CONSTRAINT PK_PERSON      PRIMARY KEY (ID),
CONSTRAINT CHK_GENDER     CHECK (GENDER = 'M' OR GENDER = 'F'),
CONSTRAINT FK_PROFESSION  FOREIGN KEY (PROFESSION)  REFERENCES PROFESSION (ID),
CONSTRAINT FK_COUNTRY     FOREIGN KEY (COUNTRY)     REFERENCES COUNTRY (ID));

CREATE TABLE CONTACT_TYPE (
ID		      INTEGER		    NOT NULL,
NAME		    VARCHAR(100)	NOT NULL,
CONSTRAINT PK_CONTACT_TYPE PRIMARY KEY (ID));

CREATE TABLE CONTACT (
ID 		        SERIAL		    NOT NULL,
PERSON		    INTEGER		    NOT NULL,
CONTACT_TYPE	INTEGER		    NOT NULL,
VALUE		      VARCHAR(255)	NOT NULL,
CONSTRAINT PK_CONTACT PRIMARY KEY (ID),
CONSTRAINT FK_TYPE    FOREIGN KEY (CONTACT_TYPE)  REFERENCES CONTACT_TYPE (ID),
CONSTRAINT FK_PERSON  FOREIGN KEY (PERSON)        REFERENCES PERSON (ID));
