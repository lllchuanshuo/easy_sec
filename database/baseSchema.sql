drop schema if exists easy_sec;
CREATE SCHEMA easy_sec DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
use easy_sec;

drop table if exists sec_group;
CREATE TABLE sec_group (
  group_id int(3) NOT NULL AUTO_INCREMENT,
  description varchar(20) NOT NULL,
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (group_id),
  UNIQUE KEY description_UNIQUE (description)
) ;

drop table if exists sec_account;
CREATE TABLE sec_account (
  account_id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  first_name varchar(20) DEFAULT NULL,
  last_name varchar(20) DEFAULT NULL,
  nick_name varchar(20) NOT NULL,
  gender int(1) DEFAULT '1',
  qq int(16) DEFAULT NULL,
  telephone varchar(20) DEFAULT NULL,
  postcode varchar(10) DEFAULT NULL,
  address varchar(80) DEFAULT NULL,
  email varchar(45) DEFAULT NULL,
  role_id int(3) NOT NULL default '3',
  department_id int(3) NOT NULL default '1',
  permission varchar(60) DEFAULT NULL,
  active tinyint(1) DEFAULT '0',
  locked tinyint(1) DEFAULT '0',
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (account_id),
  UNIQUE KEY username_UNIQUE (username),
  UNIQUE KEY email_UNIQUE (email)
) ;

drop table if exists sec_acc_security;
CREATE TABLE sec_acc_security (
  account_id int(11) NOT NULL,
  username varchar(20) NOT NULL,
  password varchar(60) NOT NULL,
  temp_flag tinyint(1) DEFAULT '0',
  fail_time int(2) DEFAULT '0',
  effective_date datetime DEFAULT NULL,
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (account_id)
) ;

drop table if exists sec_acc_session;
CREATE TABLE sec_acc_session (
  id int(11) NOT NULL AUTO_INCREMENT,
  session_id varchar(60) NOT NULL,
  username varchar(20) NOT NULL,
  account_id int(11) NOT NULL,
  expire_date datetime NOT NULL,
  create_date datetime NOT NULL,
  PRIMARY KEY (id)
);


drop table if exists sec_department;
CREATE TABLE sec_department (
  department_id int(3) NOT NULL AUTO_INCREMENT,
  description varchar(20) NOT NULL,
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (department_id)
);

drop table if exists sec_function;
CREATE TABLE sec_function (
  function_id int(5) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  uri varchar(80) NOT NULL,
  module_id int(3) NOT NULL,
  permission varchar(45) DEFAULT NULL,
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  PRIMARY KEY (function_id)
) ;

drop table if exists sec_module;
CREATE TABLE sec_module (
  module_id int(3) NOT NULL AUTO_INCREMENT,
  description varchar(50) NOT NULL,
  permission varchar(60) DEFAULT NULL,
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (module_id)
) ;

drop table if exists sec_privilege;
CREATE TABLE sec_privilege (
  privilege_id int(3) NOT NULL AUTO_INCREMENT,
  external_id int(11) NOT NULL,
  type int(1) NOT NULL,
  role_id int(11) NOT NULL,
  department_id int(11) NOT NULL,
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (privilege_id)
) ;

drop table if exists sec_role;
CREATE TABLE sec_role (
  role_id int(3) NOT NULL AUTO_INCREMENT,
  description varchar(20) NOT NULL,
  create_user varchar(20) DEFAULT NULL,
  create_date datetime DEFAULT NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (role_id),
  UNIQUE KEY description_UNIQUE (description)
) ;

drop table if exists feedback;
CREATE TABLE feedback (
  feedback_id INT(11) NOT NULL AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL,
  name VARCHAR(20) NOT NULL,
  content VARCHAR(200) NOT NULL,
  viewed tinyint(1) DEFAULT '0',
  create_date DATETIME NULL,
  PRIMARY KEY (feedback_id)
);

drop table if exists subscribe;
CREATE TABLE subscribe (
  email VARCHAR(45) NOT NULL,
  name VARCHAR(20) NULL,
  create_date DATETIME NULL,
  PRIMARY KEY (email)
);

drop table if exists notice;
CREATE TABLE notice (
  notice_id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(60) NOT NULL,
  cn_title VARCHAR(80) NOT NULL,
  content VARCHAR(600) NOT NULL,
  cn_content VARCHAR(600) NOT NULL,
  priority INT(2) NULL,
  create_user VARCHAR(20) NULL,
  create_date DATETIME NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (notice_id)
);

drop table if exists category;
CREATE TABLE category (
  category_id VARCHAR(20) NOT NULL,
  description VARCHAR(200) NOT NULL,
  cn_description VARCHAR(200) NOT NULL,
  parent_category VARCHAR(20) NULL,
  create_user VARCHAR(20) NULL,
  create_date DATETIME NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (category_id)
);

drop table if exists product;
CREATE TABLE product (
  product_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL,
  cn_name VARCHAR(60) NOT NULL,
  description VARCHAR(200) NOT NULL,
  cn_description VARCHAR(200) NOT NULL,
  category_id VARCHAR(20) NOT NULL,
  img_path VARCHAR(60) NULL,
  pre_img_path VARCHAR(60) NULL,
  create_user VARCHAR(20) NULL,
  create_date DATETIME NULL,
  update_user varchar(20) DEFAULT NULL,
  update_date datetime DEFAULT NULL,
  PRIMARY KEY (product_id)
);

