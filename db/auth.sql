DROP DATABASE IF EXISTS oath2db;
CREATE DATABASE oath2db;
USE oath2db;

CREATE TABLE permission (
    permission_id INT PRIMARY KEY AUTO_INCREMENT,
    permission_name VARCHAR(20)
);

CREATE TABLE role (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(20) UNIQUE NOT NULl
);

CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    email_id VARCHAR(255) UNIQUE KEY,
    password VARCHAR(1000)
);

CREATE TABLE assign_permission_to_role (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    permission_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY(permission_id) REFERENCES permission (permission_id),
    FOREIGN KEY(role_id) REFERENCES role(role_id)
);

CREATE TABLE assign_user_to_role (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    role_id INT,
    FOREIGN KEY(user_id) REFERENCES user(user_id),
    FOREIGN KEY(role_id) REFERENCES ROLE(role_id)
);

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

INSERT INTO oauth_client_details (
    client_id,
    client_secret,
    resource_ids,
    scope,
    authorized_grant_types,
    web_server_redirect_uri,
    authorities,
    access_token_validity,
    refresh_token_validity,
    additional_information,
    autoapprove) VALUES
('WEB_CLIENT_APP','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi',
    'WEB_APP_RESOURCE',
    'role_admin,role_user','authorization_code,password,refresh_token,implicit',
    NULL,NULL,900,3600,'{}',NULL),
('USER_CLIENT_APP_EOs8VROb14e7ZnydvXECA','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi',
    'WEB_APP_RESOURCE',
    'role_admin,role_user','authorization_code,password,refresh_token,implicit',
    NULL,NULL,900,3600,'{}',NULL);

INSERT INTO permission (permission_id, permission_name) VALUES
(1, 'CREATE_NOTE'),
(2, 'EDIT_NOTE'),
(3, 'DELETE_NOTE'),
(4, 'VIEW_ALL_NOTE'),
(5, 'VIEW_NOTE');

INSERT INTO role (role_id, role_name) VALUES
(1, 'ADMIN'),
(2, 'USER');

INSERT INTO user (user_id, name, email_id, password) VALUES
(1, 'John', 'john@gmail.com','$2a$10$jbIi/RIYNm5xAW9M7IaE5.WPw6BZgD8wcpkZUg0jm8RHPtdfDcMgm');

INSERT INTO user (user_id, NAME, email_id, password) VALUES
(2, 'Mike', 'mike@gmail.com','$2a$10$jbIi/RIYNm5xAW9M7IaE5.WPw6BZgD8wcpkZUg0jm8RHPtdfDcMgm');

INSERT INTO assign_permission_to_role (permission_id, role_id) VALUES (1, 1);
INSERT INTO assign_permission_to_role (permission_id, role_id) VALUES (2, 1);
INSERT INTO assign_permission_to_role (permission_id, role_id) VALUES (3, 1);
INSERT INTO assign_permission_to_role (permission_id, role_id) VALUES (4, 1);
INSERT INTO assign_permission_to_role (permission_id, role_id) VALUES (5, 1);

INSERT INTO assign_permission_to_role (permission_id, role_id) VALUES (4, 2);
INSERT INTO assign_permission_to_role (permission_id, role_id) VALUES (5, 2);

INSERT INTO assign_user_to_role (user_id, role_id) VALUES (1, 1);
INSERT INTO assign_user_to_role (user_id, role_id) VALUES (2, 2);

SELECT * FROM user WHERE email_id ='john@gmail.com';

SELECT DISTINCT p.permission_name FROM permission p
INNER JOIN assign_permission_to_role p_r ON P.permission_id=p_r.permission_id
INNER JOIN role r ON r.role_id=p_r.ROLE_ID
INNER JOIN assign_user_to_role u_r ON U_R.ROLE_ID=r.role_id
INNER JOIN user u ON u.user_id=u_r.USER_ID
WHERE u.email_id='john@gmail.com';