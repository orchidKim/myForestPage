--테이블 삭제 시 FK 제약조건을 고려하며 삭제
drop table qna;
drop table notice;
drop table my_list;
drop table place_comment;
drop table member_detail;
drop table member;
drop table placedata;

drop SEQUENCE place_seq; 
drop SEQUENCE member_seq;
drop SEQUENCE comment_seq;
drop SEQUENCE notice_seq;
drop SEQUENCE qna_seq;
drop SEQUENCE visit_seq;

--이클립스에서 insert한 휴양림데이터는 0-149까지 고유번호를 부여, 시퀀스를 사용한 방법x
--관리자가 휴양림데이터를 insert하는경우 place_seq를 이용
create SEQUENCE place_seq; 
ALTER SEQUENCE place_seq INCREMENT BY 150; 
create SEQUENCE member_seq;
create SEQUENCE comment_seq;
create SEQUENCE notice_seq;
create SEQUENCE qna_seq;
create SEQUENCE visit_seq;

create table placedata(
      p_num number primary key, -- 휴양림 고유번호 
      p_name varchar2(100) not null,--휴양림명
	  p_city varchar2(100) not null, --시도명
	  p_div varchar2(100) not null, --구분
	  
	  p_size number not null, --면적
	  p_count number(10) default 0, --수용가능인원
	  
	  p_cost varchar2(500) not null, --입장료
	  p_stay varchar2(10) not null, --숙박가능여부
	  p_facility varchar2(500) not null, --주요시설
	  p_load varchar2(100) not null, --소재지도로명주소
	  p_pubnum varchar2(100) not null, --관리기관명
	  p_phone varchar2(100) not null, --전화번호
	  p_web varchar2(100) default 'no website', --홈페이지 주소
	  
	  p_latitude number not null, --위도
	  p_longitude number not null, --경도
	  
	  p_regdate varchar2(100) not null, --데이터기준일자
	  p_code varchar2(100) not null, --제공기관코드
	  p_pubname varchar2(100) not null, --제공기관명
      p_img varchar2(500) --이미지 경로
);

-- 회원정보 
create table member(
    mem_num number primary key, --회원 고유번호
    id varchar2(12) unique not null,
    -- 0:탈퇴회원, 1:정지회원, 2:일반회원, 3:관리자 
    auth number(1) default 2 not null
);


create table member_detail(
    mem_num number primary key, --회원고유번호
   
    name varchar2(30) not null,
    passwd varchar2(35) not null,
    phone varchar2(15) not null,
    email varchar2(20) not null,
    address varchar2(100) not null, --한글 한 글자는 3바이트로, 입력폼에서 글자 수 제한 100/3 = 33.3
    reg_date date default sysdate, --가입일
   
    passwd_q clob not null, --비밀번호 찾기 질문
    passwd_a clob not null, --비밀번호 찾기 답변
    
    constraint member_detail_fk foreign key (mem_num) references member (mem_num)
);


create table place_comment(
    c_num number(10) primary key, --후기 고유번호
    p_num number not null, --해당 후기 휴양림 고유번호
    mem_num number not null, --해당 후기 작성자 회원번호
    comments clob not null,--후기내용, clob -> String 변수로 처리
    reg_date date default sysdate not null,
    modify_date date default sysdate not null,
    constraint place_comment_p_num_fk foreign key (p_num) references placedata (p_num),
    constraint place_comment_mem_num_fk foreign key (mem_num) references member (mem_num)
);

create table my_list(
    mem_num number, --회원 고유번호
    p_num number, --휴양림 고유번호
    constraint my_list_mem_num_fk foreign key (mem_num) references member (mem_num),
    constraint my_list_p_num_fk foreign key (p_num) references placedata (p_num)
);

create table notice(
    n_num number(10) primary key, --공지사항 고유번호
    n_title varchar2(100) not null,
    notice clob not null,--공지내용, clob -> String 변수로 처리
    n_hit number  default 0 not null,   --조회수
    reg_date date default sysdate not null,
    modify_date date default sysdate not null,
    mem_num number not null,
    constraint notice_fk foreign key (mem_num) references member (mem_num)
);

create table qna(
    mem_num number not null, -- 문의자 회원번호
    q_num number(10) primary key, --질의응답 고유번호
    q_title varchar2(100) not null, --질문제목
    question clob not null, --질문내용
    answer clob default 'no answer' not null, --답변내용
    q_hit number  default 0 not null,
    q_reg_date date default sysdate not null, --질문등록일
    q_modify_date date default sysdate not null, --질문수정일
    a_reg_date date default '20/01/01' not null, --답변등록일
    a_modify_date date default '20/01/01' not null, --답변수정일
     
    constraint qna_mem_num_fk foreign key (mem_num) references member (mem_num)
);

create table visit_place(
    v_num number primary key, --방문예약 고유번호
    mem_num number not null, --방문예정자 회원번호
    p_num number not null, --방문예정 휴양림번호
    v_day date not null, --방문날짜
    v_cnt number(5), --방문인원
    constraint visit_place_mem_num_fk foreign key (mem_num) references member (mem_num),
    constraint visit_place_p_num_fk foreign key (p_num) references placedata (p_num)
);

