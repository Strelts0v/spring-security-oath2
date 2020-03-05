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
('USER_CLIENT_APP','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi',
 'CORE_RESOURCE',
 'role_admin,role_user','authorization_code,password,refresh_token,implicit',
 NULL,NULL,900,3600,'{}',NULL),
('USER_CLIENT_APP1','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi',
 'USER_CLIENT_RESOURCE,USER_ADMIN_RESOURCE',
 'role_admin,role_user','authorization_code,password,refresh_token,implicit',
 NULL,NULL,900,3600,'{}',NULL);

INSERT INTO permission (name) VALUES
('can_create_user'),
('can_update_user'),
('can_read_user'),
('can_delete_user');

INSERT INTO role (name) VALUES
('role_admin'),
('role_user');

INSERT INTO permission_role (permission_id, role_id) VALUES
(1,1),  /* can_create_user assigned to role_admin */
(2,1),  /* can_update_user assigned to role_admin */
(3,1),  /* can_read_user assigned to role_admin */
(4,1),  /* can_delete_user assigned to role_admin */
(3,2);  /* can_read_user assigned to role_user */

INSERT INTO `user`
(username,password,email,enabled,account_non_expired,
 credentials_non_expired,account_non_locked) VALUES
('admin','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi','william@gmail.com',true,true,true,true),
('user','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi','john@gmail.com',true,true,true,true),
('user_disabled','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi','john_disabled@gmail.com',false,true,true,true),
('user_expired','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi','john_expired@gmail.com',true,false,true,true),
('user_creds_expired','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi','john_creds_expired@gmail.com',true,true,false,true),
('user_locked','{bcrypt}$2a$10$EOs8VROb14e7ZnydvXECA.4LoIhPOoFHKvVF/iBZ/ker17Eocz4Vi','john_lockec@gmail.com',true,true,true,false);

INSERT INTO role_user (role_id, user_id)
VALUES
(1, 1) /* role_admin assigned to admin user */,
(2, 2) /* role_user assigned to user user */ ;