CREATE DATABASE sosMed

USE sosMed

CREATE TABLE users(
	userId char(5),
	firstName varchar(255),
	lastName varchar(255),
	school varchar(255),
	address varchar(255),
	email varchar(255),
	phoneNumber varchar(13),
	location varchar(255),
	dOB date,
	gender varchar(6)
	CONSTRAINT userPK PRIMARY KEY(userId),
	CONSTRAINT idCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]'),
	CONSTRAINT emailCheck CHECK(email like '%@%.%'),
	CONSTRAINT genderCheck CHECK(gender like 'male' or gender like 'female')
)

CREATE TABLE friends(
	friendId char(5),
	userId char(5),
	CONSTRAINT friendUserPK PRIMARY KEY(userId, friendId),
	CONSTRAINT userFFk FOREIGN KEY(userId) REFERENCES users(userId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT friendFFk FOREIGN KEY(friendId) REFERENCES users(userId) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT idUCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]'),
	CONSTRAINT idFCheck CHECK(friendId like 'U[0-9][0-9][0-9][0-9]')
)

CREATE TABLE pages(
	pageId int,
	pageName varchar(50),
	pageContent varchar(255)
	CONSTRAINT pagePK PRIMARY KEY(pageId)
)

CREATE TABLE pageLikes(
	pageId int,
	userId char(5),
	CONSTRAINT pageUserPK PRIMARY KEY(pageId, userId),
	CONSTRAINT pagePageLFK FOREIGN KEY(pageId) REFERENCES pages(pageId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT userPageLFK FOREIGN KEY(userId) REFERENCES users(userId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT userPageLCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]')
)

CREATE TABLE posts(
	postId int,
	userId char(5),
	postDate datetime,
	postContent varchar(255)
	CONSTRAINT postPK PRIMARY KEY(postId),
	CONSTRAINT userPostFk FOREIGN KEY(userId) REFERENCES users(userId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT userPostCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]')
)

CREATE TABLE postLikes(
	postId int,
	userId char(5),
	CONSTRAINT postUserPK PRIMARY KEY(postId, userId),
	CONSTRAINT userPostLCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]'),
	CONSTRAINT userPostLFk FOREIGN KEY(userId) REFERENCES users(userId) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT postPostLFk FOREIGN KEY(postId) REFERENCES posts(postId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE photos(
	photoId int,
	postId int,
	imageContent image,
	CONSTRAINT photoPK PRIMARY KEY(photoId),
	CONSTRAINT postPhotoFk FOREIGN KEY(postId) REFERENCES posts(postId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE shares(
	postId int,
	userId char(5),
	CONSTRAINT postUserPK2 PRIMARY KEY(postId, userId),
	CONSTRAINT userShareCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]'),
	CONSTRAINT userShareFk FOREIGN KEY(userId) REFERENCES users(userId) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT postShareFk FOREIGN KEY(postId) REFERENCES posts(postId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE comments(
	commentId int,
	postId int,
	userId char(5),
	commentDate datetime,
	commentContent varchar(255),
	CONSTRAINT commentPk PRIMARY KEY(commentId),
	CONSTRAINT userCommentCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]'),
	CONSTRAINT userCommentFk FOREIGN KEY(userId) REFERENCES users(userId) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT postCommentFk FOREIGN KEY(postId) REFERENCES posts(postId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE commentLikes(
	commentId int,
	userId char(5),
	CONSTRAINT cmtUserPK PRIMARY KEY(commentId, userId),
	CONSTRAINT userCommentLCheck CHECK(userId like 'U[0-9][0-9][0-9][0-9]'),
	CONSTRAINT userCommentLFk FOREIGN KEY(userId) REFERENCES users(userId) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT commentCommentLFk FOREIGN KEY(commentId) REFERENCES comments(commentId) ON UPDATE CASCADE ON DELETE CASCADE
)