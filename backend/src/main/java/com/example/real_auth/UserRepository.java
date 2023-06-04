package com.example.real_auth;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User , Integer>{
	User findByEmailAndPassword(String email,String password);
	List<User> findByEmail(String email);
	List<User> findByUsername(String username);
	boolean existsByUsername(String username);
	boolean existsByEmail(String email);
}
