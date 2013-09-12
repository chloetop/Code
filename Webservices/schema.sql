{\rtf1\ansi\ansicpg936\cocoartf1138\cocoasubrtf320
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural

\f0\fs24 \cf0 create table merge(\
eventsetid varchar(100) primary key,\
sortby varchar(100),\
eventsetidone varchar(100),\
eventsetidtwo varchar(100)\
);\
\
create table stock(\
sec varchar(100),\
open varchar(100),\
high varchar(100),\
low varchar(100),\
close varchar(100),\
volume varchar(100),\
adjclose varchar(100),\
eventid varchar(100)\
)}
