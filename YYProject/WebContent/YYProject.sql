/*회원 테이블*/
create table member(
	name varchar2(100) not null, 
	id varchar2(100) primary key,
	password varchar2(100) not null,
	email varchar2(100) not null,
	reg_date date default sysdate
	/*sysdate가 있으면 dao에 getDate를 만들필요없다.*/
	/*reg_date varchar2(30)*/
);

select * from member;
drop table member;


/*댓글 테이블*/
create table y_comment(
	cNum number primary key, /*댓글 번호로 불러와야 한다.*/
	cId varchar2(100) not null, /*작성자 아이디*/
	cContent varchar2(500) not null, /*게시글 내용*/
	cStar number not null,
	cReg_date date default sysdate, /*게시글 등록일*/
	cReg_flag number not null /*어느 게시글에 댓글이 달렸는지 알기위해서 */
);

create sequence yc_seq;/*create sequence fb_seq;bNum을 우리가 주지 않고 자동으로 넣어주는 것이다*/
select * from y_comment;
drop table y_comment;


/*food 게시판 테이블*/
create table food_board(
	bNum number primary key,
	bDate date default sysdate,
	bName varchar2(100) not null,
	bTel varchar2(100) not null,
	bTime varchar2(100) not null,
	bImg varchar2(1000),
	bAdd1 varchar2(1000) not null,
	bAdd2 varchar2(1000) not null,
	bLocation varchar2(1000) not null,
	bKind varchar2(1000),
	bMenu1_Img varchar2(1000),	
	bMenu2_Img varchar2(1000),	
	bMenu3_Img varchar2(1000),	
	bMenu1_Detail varchar2(1000) not null,
	bMenu2_Detail varchar2(1000) not null,
	bMenu3_Detail varchar2(1000) not null,
	bInfo varchar(2000) not null,
	bHash varchar(2000) not null,
	bStar number not null
	
);

create sequence fb_seq; /*bNum을 우리가 주지 않고 자동으로 넣어주는 것이다*/
select * from food_board;
drop table food_board;
delete food_board;