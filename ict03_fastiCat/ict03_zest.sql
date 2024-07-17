create user ict03_zest identified by tiger default tablespace users;

grant connect, resource, create view to ict03_zest;
grant create session to ict03_zest;

alter user ict03_zest account unlock;

-- 권문성 -------------------------------------------------------------------------------
-- 게시판  테이블
DROP TABLE mvc_Notice_TBL  CASCADE CONSTRAINTS;
CREATE TABLE mvc_Notice_TBL(  
  N_Board_Num   NUMBER(7)  PRIMARY KEY,      -- 글번호
   N_Title       VARCHAR2(50)  NOT NULL,      -- 글제목
   N_Content     CLOB  NOT NULL,              -- 글내용
   N_Writer      VARCHAR2(30)  NOT NULL,       -- 작성자
   N_readCnt     NUMBER(6)   DEFAULT 0,      -- 조회수
   N_WriteDate     DATE  DEFAULT sysdate,       -- 작성일
   show         VARCHAR2(10) DEFAULT 'y'
);

--공지사항 입력
INSERT INTO mvc_Notice_TBL(N_Board_Num, N_Title, N_Content, N_Writer, N_WriteDate)
 VALUES((SELECT NVL(MAX(N_Board_Num)+1,1) FROM mvc_Notice_TBL), '서버점검안내' , '2024년 07월 15일 저녁시간 22시~24시까지 서버 점검이 이루어질 예정입니다', '매니저23', sysdate);
--공지사항 상세페이지
SELECT * FROM mvc_Notice_TBL
 WHERE N_Board_Num=1;
--공지사항 수정
UPDATE mvc_Notice_TBL
   SET N_Title = '예매 관련하여 공지 올려드립니다.'
      ,N_Content ='저희는 예매일정을 알려드리는 사이트입니다. 해당 공연의 예매는 예매사이트로 접속하셔서 예매하셔야합니다.'
  WHERE N_Board_Num= 2;
--공지사항 삭제 
UPDATE mvc_Notice_TBL
   SET show ='n'
 WHERE N_Board_Num = 3;
 
--공지사항 목록조회
SELECT * 
  FROM(
      SELECT A.*,
             N_Board_Num AS rn 
        FROM 
             (SELECT *
                 FROM mvc_Notice_TBL
                WHERE show = 'y'
               ORDER BY N_Board_Num DESC
                ) A    
      ) 
 WHERE rn BETWEEN 1 AND 10;
 
 --공지사항 조회수 증가
 UPDATE mvc_Notice_TBL
    SET N_readCnt = N_readCnt+1
  WHERE N_Board_Num= 2;  
  
 --공지사항 갯수 구하기
 SELECT COUNT(*) AS cnt
 FROM mvc_Notice_TBL;

-- 김가연 -------------------------------------------------------------------------------
-- jsp_pj_ict03으로 접속
----------  공연테이블 mvc_ad_concert_tbl 생성 ----------------------------------------------------
DROP TABLE mvc_ad_concert_tbl CASCADE CONSTRAINTS;
 CREATE TABLE mvc_ad_concert_tbl(
    conNo        NUMBER(7)  PRIMARY KEY,            -- 공연번호
    conCategory  VARCHAR2(50) NOT NULL,             -- 공연카테고리
    conName      VARCHAR2(50)  NOT NULL UNIQUE,     -- 공연명
    conGrade     VARCHAR2(50) NOT NULL,             -- 관람등급
    conTime      VARCHAR2(100) NOT NULL,            -- 공연날짜/시간
    conPlace     VARCHAR2(50) NOT NULL,             -- 공연장소
    conImg       VARCHAR2(100) NOT NULL,            -- 공연이미지
    conBuy       VARCHAR2(200) NOT NULL,            -- 공연예매처
    conPrice     NUMBER(9) NOT NULL,                -- 공연가격
    conContent   CLOB,                              -- 공연설명
    conStatus    VARCHAR2(20) NOT NULL,             -- 공연상태코드
    conIndate    DATE  DEFAULT sysdate              -- 공연등록일
 );
 
-- 공연  목록 조회
SELECT * FROM mvc_ad_concert_tbl
ORDER BY conNo;

-- 공연 갯수
SELECT COUNT(*) as cnt FROM mvc_ad_concert_tbl;

-- 공연 (삭제 show 칼럼 추가)
 ALTER TABLE mvc_ad_concert_tbl
   ADD show CHAR(1) DEFAULT 'y';

 SELECT *
   FROM (
         SELECT A.*, 
               rownum AS rn  -- 일련변호 가져오기
          FROM 
            (
              SELECT *                
                FROM mvc_ad_concert_tbl 
                WHERE show = 'y'
                ORDER BY conNo DESC
            ) A
        )   
 WHERE rn BETWEEN 1 AND 10; 

---- 공연 목록 조회 -----
SELECT * FROM mvc_ad_concert_tbl 
 WHERE show = 'y'
 ORDER BY conNo;
   
-- 칼럼 수정
ALTER TABLE mvc_ad_concert_tbl 
MODIFY conTime VARCHAR2(200);
  
   
-- 공연등록
INSERT INTO mvc_ad_concert_tbl(conNo, conCategory, conName, conGrade, conTime, conPlace, conImg, conBuy, conPrice, conContent, conStatus, conIndate)
 VALUES((SELECT NVL(MAX(conNo)+1, 1) FROM mvc_ad_concert_tbl), '트로트', '콘서트이름1', '만7세이상', '2024/07/07', '체조경기장', '/js_pj_fasticat/resources/images/고양이뒷모습.jpg', '예매처', 115000, '공연설명', '판매중', sysdate); 

COMMIT;

-- 공연 삭제(update n)
UPDATE mvc_ad_concert_tbl
SET show = 'n'
WHERE conNo = 1;

-- 공연 수정
UPDATE mvc_ad_concert_tbl
SET conCategory = '케이팝'
WHERE conNo = 4;

------------------  페스티벌 테이블 ----------------------------------------------------------------------------
-- 페스티벌테이블 mvc_ad_festival_tbl 생성
DROP TABLE mvc_ad_festival_tbl CASCADE CONSTRAINTS;
 CREATE TABLE mvc_ad_festival_tbl(
    fesNo        NUMBER(7)  PRIMARY KEY,            -- 페스티벌 번호
    fesName      VARCHAR2(50)  NOT NULL UNIQUE,     -- 페스티벌명
    fesGrade     VARCHAR2(50) NOT NULL,             -- 관람등급
    fesTime      VARCHAR2(200) NOT NULL,            -- 페스티벌 날짜/시간
    fesPlace     VARCHAR2(50) NOT NULL,             -- 페스티벌 장소
    fesImg       VARCHAR2(100) NOT NULL,            -- 페스티벌 이미지
    fesBuy       VARCHAR2(200) NOT NULL,            -- 예매처
    fesPrice     NUMBER(9) NOT NULL,                -- 페스티벌 가격
    fesContent   CLOB,                              -- 페스티벌 설명
    fesStatus    VARCHAR2(20) NOT NULL,             -- 페스티벌 상태코드
    fesIndate    DATE  DEFAULT sysdate,             -- 페스티벌 등록일
    show         CHAR(1) DEFAULT 'y'     
 );
 
-- 페스티벌 목록 조회
SELECT * FROM mvc_ad_festival_tbl
WHERE show = 'y'
ORDER BY fesNo;

INSERT INTO mvc_ad_festival_tbl(fesNo, fesName, fesGrade, fesTime, fesPlace, fesImg, fesBuy, fesPrice, fesContent, fesStatus, fesIndate)
 VALUES((SELECT NVL(MAX(fesNo)+1, 1) FROM mvc_ad_festival_tbl), '서울재즈페스티벌', '전체관람가', '2024/07/07', '올림픽공원', '/js_pj_fasticat/resources/images/고양이뒷모습.jpg', '인터파크', 189000, '공연설명', '판매중', sysdate); 
COMMIT;


-- 페스티벌 갯수
SELECT COUNT(*) as cnt FROM mvc_ad_festival_tbl;


-- 페스티벌 (삭제 show 칼럼 추가)
 ALTER TABLE mvc_ad_festival_tbl
   ADD show CHAR(1) DEFAULT 'y';

 SELECT *
   FROM (
         SELECT A.*, 
               rownum AS rn  -- 일련변호 가져오기
          FROM 
            (
              SELECT *                
                FROM mvc_ad_festival_tbl 
                WHERE show = 'y'
                ORDER BY fesNo DESC
            ) A
        )   
 WHERE rn BETWEEN 1 AND 10; 


-- 페스티벌 데이터 삭제
DELETE mvc_ad_festival_tbl
WHERE fesNo = 9;

-- 페스티벌 수정
UPDATE mvc_ad_festival_tbl
SET fesNo=1, fesName='', fesGrade='', fesTime='', fesPlace='', fesImg='', fesBuy='', fesPrice='', fesContent='', fesStatus='', fesIndate=''
WHERE fesNo=1;

-- 페스티벌 삭제(update n)
UPDATE mvc_ad_festival_tbl
SET show = 'n'
WHERE fesNo = 7;

COMMIT;



----------- 배너테이블 ----------------------------------------------------------
DROP TABLE mvc_ad_banner_tbl CASCADE CONSTRAINTS;
 CREATE TABLE mvc_ad_banner_tbl(
    bannerNo        NUMBER(7)  PRIMARY KEY,            -- 배너번호
    bannerArea      VARCHAR2(50)  NOT NULL UNIQUE,     -- 배너영역(메인1,2,3)
    bannerImg       VARCHAR2(100) NOT NULL,            -- 배너 이미지
    bannerStatus    VARCHAR2(20) NOT NULL,             -- 배너 상태코드(사용함,안함)
    bannerIndate    DATE  DEFAULT sysdate,              -- 등록일
    show              CHAR(1) DEFAULT 'y'     
 );
 
-- 배너 목록 조회
SELECT * FROM mvc_ad_banner_tbl
ORDER BY bannerNo;

-- 배너 등록
INSERT INTO mvc_ad_banner_tbl(bannerNo, bannerArea, bannerImg, bannerStatus, bannerIndate)
 VALUES((SELECT NVL(MAX(bannerNo)+1, 1) FROM mvc_ad_banner_tbl), '메인배너1', '/js_pj_fasticat/resources/images/고양이뒷모습.jpg', '사용함', sysdate); 
COMMIT;

SELECT * FROM mvc_ad_banner_tbl
 WHERE show = 'y'
 ORDER BY bannerNo;

-- 배너 삭제
DELETE mvc_ad_banner_tbl
WHERE bannerNo = 3;
COMMIT;

-- 배너 수정
UPDATE mvc_ad_banner_tbl
SET bannerArea='메인배너1', bannerImg='/js_pj_fasticat/resources/images/고양이뒷모습.jpg', bannerStatus='사용함', bannerIndate=sysdate
WHERE bannerNo=1;

-- 배너 삭제(update n)
UPDATE mvc_ad_banner_tbl
SET show = 'y'
WHERE bannerNo = 2;


------ 공지사항 --------------------------------------------------------------------
-- 공지사항  테이블
DROP TABLE mvc_ad_notice_tbl  CASCADE CONSTRAINTS;
CREATE TABLE mvc_ad_notice_tbl(  
   noticeNo          NUMBER(7)  PRIMARY KEY,      -- 공지사항 번호
   noticeTitle       VARCHAR2(50)  NOT NULL,      -- 공지사항 제목
   noticeContent     CLOB  NOT NULL,              -- 공지사항 내용
   noticeImg         VARCHAR2(100) NOT NULL,      -- 첨부이미지
   noticeWriter      VARCHAR2(30)  NOT NULL,      -- 작성자(관리자)
   noticeReadCnt     NUMBER(6)   DEFAULT 0,       -- 조회수
   noticeRegDate     DATE  DEFAULT sysdate,       -- 작성일
   show              CHAR(1) DEFAULT 'y'          
);

-- 공지사항 목록 조회
SELECT * FROM mvc_ad_notice_tbl
ORDER BY noticeNo;

-- 공지사항 등록
INSERT INTO mvc_ad_notice_tbl(noticeNo, noticeTitle, noticeContent, noticeImg, noticeWriter, noticeReadCnt, noticeRegDate)
 VALUES((SELECT NVL(MAX(noticeNo)+1, 1) FROM mvc_ad_notice_tbl), '제목1', '내용', '/js_pj_fasticat/resources/images/고양이뒷모습.jpg', '관리자1', 0, sysdate); 
COMMIT;

-- 공지사항 (삭제 show 칼럼 추가)
 ALTER TABLE mvc_ad_notice_tbl
   ADD show CHAR(1) DEFAULT 'y';
   
-- 공지사항 수정
UPDATE mvc_ad_notice_tbl
SET noticeTitle='메인배너1', noticeContent='내용' , noticeImg='/js_pj_fasticat/resources/images/고양이뒷모습.jpg', noticeWriter='작성자', noticeReadCnt='0', noticeRegDate=sysdate
WHERE noticeNo=1;

-- 공지사항 삭제
UPDATE mvc_ad_notice_tbl
SET show='n'
WHERE noticeNo=1;

-- 김성태 -------------------------------------------------------------------------------
--2. 게시판 공연, 페스티벌 후기 게시판/  
DROP TABLE reviewBoard_tbl;
CREATE TABLE reviewBoard_tbl(  
     board_num         NUMBER(7),                  -- 글번호
     board_category    VARCHAR2(30) DEFAULT '공연후기',                --카테고리 
     board_title       VARCHAR2(50)  NOT NULL,      -- 글제목
     board_content     CLOB  NOT NULL,              -- 글내용
     board_image       VARCHAR2(1000),                -- 이미지파일
     board_writer      VARCHAR2(30)  NOT NULL,      -- 작성자 fk (userid)
     board_regDate     DATE  DEFAULT sysdate,       -- 작성일
     board_views       NUMBER(6)   DEFAULT 0,       -- 조회수
     board_likes       NUMBER(6)   DEFAULT 0,      -- 좋아요 
     board_show        CHAR(1) DEFAULT 'y'
);

-- 후기 게시판 내림차순, y 정렬
DROP TABLE reviewBoard_list;
CREATE TABLE reviewBoard_list
AS
    (SELECT r.*, rownum AS rn 
      FROM (
        SELECT * FROM reviewBoard_tbl
         WHERE board_show = 'y'
         ORDER BY board_num DESC  
      ) r 
  );
SELECT * FROM reviewBoard_list;


--자유 게시판 
DROP TABLE freeBoard_tbl;
CREATE TABLE freeBoard_tbl(  
     board_num         NUMBER(7),                  -- 글번호
     board_category    VARCHAR2(30) DEFAULT '자유',                --카테고리 
     board_title       VARCHAR2(50)  NOT NULL,      -- 글제목
     board_content     CLOB  NOT NULL,              -- 글내용
     board_image       VARCHAR2(1000),                -- 이미지파일 디폴트 이미지 주기 (이미지없음)
     board_writer      VARCHAR2(30)  NOT NULL,      -- 작성자 fk (userid)
     board_regDate     DATE  DEFAULT sysdate,       -- 작성일
     board_views       NUMBER(6)   DEFAULT 0,       -- 조회수
     board_likes       NUMBER(6)   DEFAULT 0,      -- 좋아요 
     board_show        CHAR(1) DEFAULT 'y'
);


-- 자유 게시판 내림차순, y 정렬
DROP TABLE freeBoard_list;
CREATE TABLE freeBoard_list
AS
    (SELECT r.*, rownum AS rn 
      FROM (
        SELECT * FROM freeBoard_tbl
         WHERE board_show = 'y'
         ORDER BY board_num DESC  
      ) r 
  );
SELECT * FROM freeBoard_list;
-- 김소연 -------------------------------------------------------------------------------
-- 공연후기 게시판
DROP TABLE reviewBoard_tbl;
CREATE TABLE reviewBoard_tbl(  
     board_num         NUMBER(7) PRIMARY KEY,           -- 글번호
     board_category    VARCHAR2(30) DEFAULT '공연후기',  -- 카테고리 
     board_title       VARCHAR2(50)  NOT NULL,          -- 글제목
     board_content     CLOB  NOT NULL,                  -- 글내용
     board_thumnail    VARCHAR2(100),                   -- default 썸네일은 목록조회시 생성됨
     board_image       VARCHAR2(100),                   -- 이미지파일
     board_writer      VARCHAR2(30) REFERENCES mvc_customer_tbl(userid),-- 작성자 
     board_regDate     DATE  DEFAULT sysdate,           -- 작성일
     board_views       NUMBER(6)   DEFAULT 0,           -- 조회수
     board_heart       NUMBER(6)   DEFAULT 0,           -- 좋아요 
     board_show        CHAR(1) DEFAULT 'y'
);

-- 공연후기 게시판 하트(toggle)
DROP TABLE heart_reviewBoard_tbl;
CREATE TABLE heart_reviewBoard_tbl(  
     heart_num          NUMBER(6) PRIMARY KEY,
     board_num          NUMBER(7) REFERENCES reviewBoard_tbl(board_num),    -- 글번호
     board_category     VARCHAR2(30) DEFAULT '공연후기',                     -- 카테고리
     userID             VARCHAR2(30) REFERENCES mvc_customer_tbl(userid),   -- 작성자 
     heart              CHAR(1)   DEFAULT 1                                 -- 좋아요
);

-- 공연후기게시판 댓글
DROP TABLE reviewComment_tbl;
CREATE TABLE reviewComment_tbl(  
    comment_num     NUMBER(7) PRIMARY KEY,      -- PK, 댓글 일련번호
    board_num       NUMBER(7) REFERENCES reviewBoard_tbl(board_num),                   -- FK, 게시글 번호
    board_category  VARCHAR2(30) DEFAULT '공연후기',
    userID          VARCHAR2(30) REFERENCES mvc_customer_tbl(userid),       -- 작성자
    content         CLOB  NOT NULL,              -- 글내용
    regDate         Date  DEFAULT sysdate       -- 등록일
);

-- 자유 게시판
DROP TABLE freeBoard_tbl;
CREATE TABLE freeBoard_tbl(  
     board_num         NUMBER(7) PRIMARY KEY,           -- 글번호
     board_category    VARCHAR2(30) DEFAULT '자유',  -- 카테고리 
     board_title       VARCHAR2(50)  NOT NULL,          -- 글제목
     board_content     CLOB  NOT NULL,                  -- 글내용
     board_thumnail    VARCHAR2(100),                   -- default 썸네일은 목록조회시 생성됨
     board_image       VARCHAR2(100),                   -- 이미지파일
     board_writer      VARCHAR2(30) REFERENCES mvc_customer_tbl(userid),-- 작성자 
     board_regDate     DATE  DEFAULT sysdate,           -- 작성일
     board_views       NUMBER(6)   DEFAULT 0,           -- 조회수
     board_heart       NUMBER(6)   DEFAULT 0,           -- 좋아요 
     board_show        CHAR(1) DEFAULT 'y'
);

-- 자유 게시판 하트(toggle)
DROP TABLE heart_freeBoard_tbl;
CREATE TABLE heart_freeBoard_tbl(  
     heart_num          NUMBER(6) PRIMARY KEY,
     board_num          NUMBER(7) REFERENCES freeBoard_tbl(board_num),      -- 글번호
     board_category     VARCHAR2(30) DEFAULT '자유',                         --카테고리
     userID             VARCHAR2(30) REFERENCES mvc_customer_tbl(userid),   -- 작성자 fk (userid)
     heart              CHAR(1)   DEFAULT 1                                 -- 좋아요
);
SELECT * FROM reviewComment_tbl;
-- 자유게시판 댓글
DROP TABLE freeComment_tbl;
CREATE TABLE freeComment_tbl(  
    comment_num     NUMBER(7)  PRIMARY KEY,      -- PK, 댓글 일련번호
    board_num       NUMBER(7) REFERENCES freeBoard_tbl(board_num),                   -- FK, 게시글 번호
    board_category  VARCHAR2(30) DEFAULT '자유',
    userID          VARCHAR2(30) REFERENCES mvc_customer_tbl(userid),       -- 작성자
    content         CLOB  NOT NULL,              -- 글내용
    regDate         Date  DEFAULT sysdate       -- 등록일
);
-- 김조원 -------------------------------------------------------------------------------
DROP TABLE mvc_customer_tbl  CASCADE CONSTRAINTS;
CREATE TABLE mvc_customer_tbl(
   userid     VARCHAR2(20)    PRIMARY KEY,    -- ID
   password   VARCHAR2(20)    NOT NULL,          -- 비밀번호
   username   VARCHAR2(20)    NOT NULL,          -- 이름
   birthday   DATE            NOT NULL,          -- 생년월일    
   address    VARCHAR2(50)    NOT NULL,          -- 주소
   hp         VARCHAR2(13),                      -- 핸드폰      
   email      VARCHAR2(50)    NOT NULL,          -- 이메일
   regDate    TIMESTAMP       DEFAULT sysdate    -- 가입일
); 

INSERT INTO mvc_customer_tbl(userid, password, username, birthday, address, hp, email)
VALUES('hong', 'h1234', '홍길동', '2000/01/01','서울시 강남구 대치동', '010-1111-2222','hong@gmail.com');
commit;

SELECT * FROM mvc_customer_tbl;
-- 방준성 -------------------------------------------------------------------------------

CREATE TABLE show_tbl(                                                          -- 공연 테이블
    showNum         NUMBER(6)      PRIMARY KEY,                                 -- 공연번호
    showName        VARCHAR2(150)   NOT NULL,                                   -- 공연명
    showPlace       VARCHAR2(150)   NOT NULL,                                   -- 공연장소                                     
    showPrice       NUMBER(20)     ,                                            -- 1매당 가격
    curCapacity     NUMBER(20)     DEFAULT 0 ,                                  -- 현수용인원
    maxCapacity     NUMBER(20)     DEFAULT 50,                                  -- 최대수용인원
    showDay         Date           NOT NULL,                                    -- 공연날짜
    showCHK         char           DEFAULT 'N'                                  -- 공연기간 활성화 유무
);
CREATE SEQUENCE show_tbl_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;  
    