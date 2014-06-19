create database if not exists test;
use test;

create table if not exists mailing (
	addr varchar(255) not null
);

create table if not exists domain_stats (
	thedate date,
	domain varchar(255),
	count int
);

create table if not exists domains (
	domain varchar(255),
	total int
);
