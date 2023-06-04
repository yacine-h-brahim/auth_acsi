package com.example.real_auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

import java.util.ArrayList;
import java.util.List;
@SpringBootApplication
@RestController
public class Auth {

	@Autowired
	private UserRepository UserController;

	@Autowired
	private IllnessRepository IllnessController;

	@Autowired
	private SymptonRepository SymptonController; 

	private List<IllnessDTO> ActualResult = new ArrayList<IllnessDTO>();

	@CrossOrigin(origins = "*")
	@PostMapping("/register")
	public ResponseEntity<ApiResponse> register(@RequestBody(required = false) UserDTO uDTO) {
		if(uDTO == null){
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse(false, "Error : Missing Request body"));
		}else{
			if (uDTO.ISNull()){
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse(false, "Error : One or multiple of the reuqest body's attributs is missing"));
			}else{
				if(UserController.existsByEmail(uDTO.getEmail())){
					return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE)
					.header("Access-Control-Allow-Origin", "*")
					.body(new ApiResponse(false, "Error : Email already used"));
				}else if(UserController.existsByUsername(uDTO.getUsername())){
					return ResponseEntity.status(409)
					.header("Access-Control-Allow-Origin", "*")
					.body(new ApiResponse(false, "Error : Username already used"));
				}else{
					User user = new User();
					user.setName(uDTO.getName());
					user.setLastname(uDTO.getLastname());
					user.setEmail(uDTO.getEmail());
					user.setPassword(uDTO.getPassword());
					user.setUsername(uDTO.getUsername());
	
					UserController.save(user);
					return ResponseEntity.status(HttpStatus.CREATED)
					.header("Access-Control-Allow-Origin", "*")
					.body(new ApiResponse(true, "Sucess : User Created Successfully",user));
				}
			}
		}
	}
	@CrossOrigin(origins = "*")
	@PostMapping("/signin")
	public ResponseEntity<ApiResponse> signin(@RequestBody(required = false) UserDTO uDto){
		if (uDto == null){
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
			.header("Access-Control-Allow-Origin", "*")
			.body(new ApiResponse(false, "Error : Missing Request body"));
		}else{
			if (uDto.getEmail() == null || uDto.getEmail().equals("")){
				return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.header("Access-Control-Allow-Origin", "*")
				.body(new ApiResponse(false, "Error : No Email specified"));
			}else{
				if(!UserController.existsByEmail(uDto.getEmail())){
					return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.header("Access-Control-Allow-Origin", "*")
					.body(new ApiResponse(false, "Error : No user found with that email"));
				}else{
					User user =  UserController.findByEmailAndPassword(uDto.getEmail(),uDto.getPassword());
					if (user == null){
						return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE)
						.header("Access-Control-Allow-Origin", "*")
						.body(new ApiResponse(false, "Error : Wrong Password"));
					}else{
						return ResponseEntity.status(200)
						.header("Access-Control-Allow-Origin", "*")
						.body(new ApiResponse(true, "Success : User Found",user));
					}
				}
			}
		}

		
	}

	@CrossOrigin(origins = "*")
	@GetMapping("/fetch_illnesses")
	public ResponseEntity<ApiResponse> fetch_illness(){
		ArrayList<Illness> illnesses = IllnessController.findAll();

		for (Illness ill : illnesses) {
			IllnessDTO illDto = new IllnessDTO();

			illDto.setId(ill.getId());
			illDto.setName(ill.getName());
			ArrayList<SymptonDTO> y = SymptonController.findAllSymptons(ill.getId());
			illDto.setSymptoms(y);
			ActualResult.add(illDto);
		}
		return ResponseEntity.status(200).header("Access-Control-Allow-Origin", "*").body(new ApiResponse(true, "Success : Illnesses Found ",ActualResult));
	}

	public static void main(String[] args) {
		SpringApplication.run(Auth.class, args);
	}

}
