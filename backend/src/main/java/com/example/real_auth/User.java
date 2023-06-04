package com.example.real_auth;

import com.fasterxml.jackson.annotation.JsonInclude;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="Users")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(nullable = false,name = "Name", length = 20)
	private String name;

	@Column(name = "Lastname", nullable=false, length = 20)
	private String lastname;

	@Column(name = "Username", unique = true, nullable = false)
	private String username;


	@Column(nullable = false, unique = true, name = "Email")
	private String email;

	@Column(name = "Password", length = 64)
	private String password ;
}