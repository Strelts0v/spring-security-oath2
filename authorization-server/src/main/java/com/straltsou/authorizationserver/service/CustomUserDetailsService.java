package com.straltsou.authorizationserver.service;

import com.straltsou.authorizationserver.entity.CustomUser;
import com.straltsou.authorizationserver.entity.UserEntity;
import com.straltsou.authorizationserver.repository.OAuthRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    OAuthRepository oAuthRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        UserEntity userEntity;

        try {
            userEntity = oAuthRepository.getUserDetails(username);

            if (userEntity != null && userEntity.getId() != null && !"".equalsIgnoreCase(userEntity.getId())) {
                return new CustomUser(userEntity);
            } else {
                throw new UsernameNotFoundException(String.format("User %s was not found in the database", username));
            }
        } catch (Exception e) {
            throw new UsernameNotFoundException(String.format("User %s was not found in the database", username));
        }

    }

}