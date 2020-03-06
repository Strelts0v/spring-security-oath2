package com.straltsou.authorizationserver.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;

import java.util.ArrayList;
import java.util.Collection;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserEntity {

    private String id;
    private String name;
    private String emailId;
    private String password;
    private Collection<GrantedAuthority> grantedAuthoritiesList = new ArrayList<>();
}
