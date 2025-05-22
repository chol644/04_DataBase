DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl
(
    userID    CHAR(8)     NOT NULL PRIMARY KEY,
    name      VARCHAR(10) NOT NULL,
    birthYear INT         NOT NULL,
    addr      CHAR(2)     NOT NULL,
    mobile1   CHAR(3)     NULL,
    mobile2   CHAR(8)     NULL,
    height    SMALLINT    NULL,
    mDate     DATE        NULL
);