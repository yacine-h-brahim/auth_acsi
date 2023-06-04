package com.example.real_auth;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.ArrayList;
public interface SymptonRepository extends JpaRepository<Sympton,Integer> {
	@Query("SELECT NEW com.example.real_auth.SymptonDTO(s.id, s.description, s.name) FROM Sympton s WHERE s.illness.id = :illnessId")
	ArrayList<SymptonDTO> findAllSymptons(int illnessId);
}
