package com.straltsou.authorizationserver.repository;

import com.straltsou.authorizationserver.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Repository
public class JdbcOAuthRepository implements OAuthRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public UserEntity getUserDetails(String emailId) {

        Collection<GrantedAuthority> grantedAuthoritiesList = new ArrayList<>();

        List<UserEntity> list = jdbcTemplate.query("SELECT * FROM user WHERE email_id=?", new String[] { emailId },
                (ResultSet rs, int rowNum) -> {
                    UserEntity user = new UserEntity();
                    user.setEmailId(emailId);
                    user.setId(rs.getString("user_id"));
                    user.setName(rs.getString("name"));
                    user.setPassword(rs.getString("password"));
                    return user;
                });

        if(!list.isEmpty()) {

            UserEntity userEntity = list.get(0);

            String sql =
                    "SELECT DISTINCT p.permission_name FROM permission p " +
                    "INNER JOIN assign_permission_to_role p_r ON P.permission_id=p_r.permission_id " +
                    "INNER JOIN role r ON r.role_id=p_r.ROLE_ID " +
                    "INNER JOIN assign_user_to_role u_r ON U_R.ROLE_ID=r.role_id " +
                    "INNER JOIN user u ON u.user_id=u_r.USER_ID " +
                    "WHERE u.email_id=?;";

            List<String> permissions = jdbcTemplate.query(sql, new String[] { userEntity.getEmailId() },
                    (ResultSet rs, int rowNum) -> "ROLE_" + rs.getString("permission_name"));

            if (permissions != null && !permissions.isEmpty()) {
                for (String permission : permissions) {
                    GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(permission);
                    grantedAuthoritiesList.add(grantedAuthority);
                }
                userEntity.setGrantedAuthoritiesList(grantedAuthoritiesList);
            }
            return userEntity;
        }

        return null;
    }
}
