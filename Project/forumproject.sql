

DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS thread;
DROP TABLE IF EXISTS forum;
DROP TABLE IF EXISTS conversation;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS acl_has_permissions;
DROP TABLE IF EXISTS permission;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS access_control_list;
DROP TABLE IF EXISTS role;

CREATE TABLE role (
    id		INT NOT NULL UNIQUE AUTO_INCREMENT,
    name	VARCHAR(30) NOT NULL,
    CONSTRAINT pk_role_id PRIMARY KEY (id)
);

CREATE TABLE user (
    id		INT NOT NULL UNIQUE AUTO_INCREMENT,
    username    varchar(25) NOT NULL,
    first_name	VARCHAR(25) NOT NULL,
    last_name	VARCHAR(25) NOT NULL,
    email		VARCHAR(40) NOT NULL,
    password	VARCHAR(64) NOT NULL,
    salt		VARCHAR(32) NOT NULL,
    role_id		INT NOT NULL,
    create_time DATETIME NOT NULL default '0000-00-00 00:00:00',
    update_time DATETIME NOT NULL default now() on update now(),
    CONSTRAINT pk_user_id PRIMARY KEY (id),
    CONSTRAINT fk_user_role_id FOREIGN KEY (role_id)
    	REFERENCES role (id)
);

/*CREATE TABLE access_control_list (
	acl_id    	INT NOT NULL UNIQUE AUTO_INCREMENT,
    has_access	BOOLEAN NOT NULL,
    role_id		INT NOT NULL UNIQUE,
    CONSTRAINT pk_acl_id PRIMARY KEY (acl_id),
    CONSTRAINT fk_acl_role_id FOREIGN KEY (role_id)
    	REFERENCES role (id)
);*/

CREATE TABLE permission (
    id	INT NOT NULL UNIQUE AUTO_INCREMENT,
    name	VARCHAR(30) NOT NULL,
    CONSTRAINT pk_permission_id PRIMARY KEY (id)
);


CREATE TABLE role_has_permissions (
    role_id			INT NOT NULL,
    permission_id	INT NOT NULL,
    CONSTRAINT fk_role_permission FOREIGN KEY (role_id)
    	REFERENCES role (id),
    CONSTRAINT fk_permission_id FOREIGN KEY (permission_id)
    	REFERENCES permission (id)
);

CREATE TABLE conversation (
    id	INT NOT NULL UNIQUE AUTO_INCREMENT,
    title varchar(50) NOT NULL,		
    user_id_from		INT NOT NULL ,
    user_id_to 		     INT NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fk_message_user_id FOREIGN KEY (user_id_from)
    	REFERENCES user (id),
	CONSTRAINT fk_message_user_id2 FOREIGN KEY (user_id_to)
		REFERENCES user (id)
);

CREATE TABLE message (
    id			INT NOT NULL UNIQUE AUTO_INCREMENT,
    content		VARCHAR(500) NOT NULL,
    create_time	DATETIME NOT NULL default '0000-00-00 00:00:00',
    update_time DATETIME NOT NULL default now() on update now(),
    conversation_id			INT NOT NULL,
    CONSTRAINT pk_message_id PRIMARY KEY (id),
    CONSTRAINT fk_conversation_id FOREIGN KEY (conversation_id)
    	REFERENCES conversation (id)
);

CREATE TABLE forum (
    id			INT NOT NULL AUTO_INCREMENT,
    name			VARCHAR(30) NOT NULL,
    create_time	DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    update_time	DATETIME NOT NULL default now() on update now(),
    parent_id		INT,
    CONSTRAINT pk_forum_id PRIMARY KEY (id),
    FOREIGN KEY (parent_id)
    	REFERENCES forum (id)
);

CREATE TABLE thread (
    id			INT NOT NULL UNIQUE AUTO_INCREMENT,
    title		VARCHAR(50) NOT NULL,
    locked		boolean NOT NULL DEFAULT 0,
    create_time	DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    update_time	DATETIME NOT NULL default now() on update now(),
    forum_id			INT NOT NULL,
    CONSTRAINT pk_thread_id PRIMARY KEY (id),
    CONSTRAINT fk_thread_forum_id FOREIGN KEY (forum_id)
    	REFERENCES forum (id)
);


CREATE TABLE post (
    id				INT NOT NULL UNIQUE AUTO_INCREMENT,
    content		VARCHAR(2000) NOT NULL,
    create_time	DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    update_time	DATETIME NOT NULL default now() on update now(),
    user_id				INT NOT NULL,
    thread_id			INT NOT NULL,
    gallery_id			INT DEFAULT NULL,
    CONSTRAINT pk_post_id PRIMARY KEY (id),
    CONSTRAINT fk_post_user_id FOREIGN KEY (user_id)
    	REFERENCES user (id),
    CONSTRAINT fk_post_thread_id FOREIGN KEY (thread_id)
    	REFERENCES thread (id)
);

CREATE TABLE gallery (
	id			INT NOT NULL AUTO_INCREMENT,
    create_time DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    update_time DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    path   char(36) NOT NULL,
    title varchar(50) NOT NULL,
    description text not null,
    hidden enum("Y","N") NOT NULL DEFAULT "N",
    user_id INT NOT NULL,
    CONSTRAINT pk_gallery_id PRIMARY KEY (id),
    CONSTRAINT fk_gallery_user_id FOREIGN KEY (user_id)
		REFERENCES user (id)
);
    
    
alter table forum AUTO_INCREMENT = 0;