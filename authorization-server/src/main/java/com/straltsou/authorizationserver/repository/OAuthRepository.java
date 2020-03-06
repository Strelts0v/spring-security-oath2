package com.straltsou.authorizationserver.repository;

import com.straltsou.authorizationserver.entity.UserEntity;

public interface OAuthRepository {

    UserEntity getUserDetails(String emailId);
}
