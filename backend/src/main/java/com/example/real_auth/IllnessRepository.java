package com.example.real_auth;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;


public interface IllnessRepository extends JpaRepository<Illness,Integer> {
	ArrayList<Illness> findAll();
}

