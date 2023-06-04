package com.example.real_auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class IllnessDTO {
	private int id;
    	private String name;
    	private List<SymptonDTO> symptoms;
}
