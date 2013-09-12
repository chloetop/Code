create table Poll(
Poll_ID varchar(100) primary key,
Poll_Title varchar(100),
Poll_Description varchar(100),
Poll_Initiator varchar(100),
Poll_Type int,
Poll_Lastmodify varchar(100),
Poll_Descsion varchar(100),
Poll_Status int
);

create table PollOption(
Option_ID varchar(100) primary key,
Option_Poll varchar(100),
Option_Poll_Type varchar(100),
Option_Content varchar(100),
Option_SubCon varchar(100)
);

create table Comment(
Comment_ID varchar(100) primary key,
Comment_Poll varchar(100),
Comment_Creator varchar(100),
Comment_Content varchar(100),
Comment_DateTime varchar(100)
);

create table Vote(
Vote_ID varchar(100) primary key,
Vote_Creator varchar(100),
Vote_Option varchar(100),
Vote_Poll varchar(100)
);


create table Users(
User_ID varchar(100) primary key,
User_Password varchar(100),
User_Email varchar(100)
);

drop table Poll;
drop table PollOption;
drop table Vote;
