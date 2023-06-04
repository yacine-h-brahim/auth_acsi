package com.example.real_auth;

import lombok.Data;

@Data

public class UserDTO {
	private Long id;
	private String username;
	private String name;
	private String lastname;
	private String email;
	private String password;

	public boolean ISNull() {
		return this.email == null || this.username == null || this.name == null || this.lastname == null
				|| this.password == null;
	}
}
