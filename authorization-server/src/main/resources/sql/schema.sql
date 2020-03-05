DROP DATABASE IF EXISTS `spring_training`;
CREATE DATABASE IF NOT EXISTS `spring_training`;

USE `spring_training`;

DROP TABLE IF EXISTS oauth_client_details;
CREATE TABLE IF NOT EXISTS oauth_client_details (
    client_id VARCHAR(255) NOT NULL PRIMARY KEY,
    client_secret VARCHAR(255) NOT NULL,
    resource_ids VARCHAR(255) DEFAULT NULL,
    scope VARCHAR(255) DEFAULT NULL,
    authorized_grant_types VARCHAR(255) DEFAULT NULL,
    web_server_redirect_uri VARCHAR(255) DEFAULT NULL,
    authorities VARCHAR(255) DEFAULT NULL,
    access_token_validity INTEGER DEFAULT NULL,
    refresh_token_validity INTEGER DEFAULT NULL,
    additional_information VARCHAR(4096) DEFAULT NULL,
    autoapprove VARCHAR(255) DEFAULT NULL
);

DROP TABLE IF EXISTS permission;
CREATE TABLE IF NOT EXISTS permission (
    permission_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(60) UNIQUE KEY
);

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(60) UNIQUE KEY
);

DROP TABLE IF EXISTS permission_role;
CREATE TABLE IF NOT EXISTS permission_role (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    permission_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (permission_id) REFERENCES permission(permission_id),
    FOREIGN KEY (role_id) REFERENCES `role`(role_id)
);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE KEY NOT NULL,
    enabled BOOLEAN NOT NULL,
    account_non_expired BOOLEAN NOT NULL,
    credentials_non_expired BOOLEAN NOT NULL,
    account_non_locked BOOLEAN NOT NULL
);

CREATE TABLE ROLE_USER (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY(role_id) REFERENCES role(role_id),
    FOREIGN KEY(user_id) REFERENCES `user`(user_id)
);