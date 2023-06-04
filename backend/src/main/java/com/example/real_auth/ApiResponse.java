package com.example.real_auth;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class ApiResponse {
	private boolean success;
      	private String message;
      	private Object data;

	public ApiResponse(boolean sucess,String messagex){
		this.success = sucess;
		this.message = messagex;
	}
}
