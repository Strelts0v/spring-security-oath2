package com.straltsou.authorizationserver.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {

    @Getter
    @Setter
    private String id;

    @Getter
    @Setter
    private String name;

    public CustomUser(UserEntity userEntity) {
        super(userEntity.getEmailId(), userEntity.getPassword(), userEntity.getGrantedAuthoritiesList());
        this.id = userEntity.getId();
        this.name = userEntity.getName();
    }
}
