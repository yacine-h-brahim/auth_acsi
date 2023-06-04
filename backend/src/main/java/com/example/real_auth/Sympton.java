package com.example.real_auth;


import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "Sympton")
public class Sympton {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column(nullable = false,name = "Name",length = 30)
	private String name;

	@Column(nullable = true ,name = "Description",length = 100)
	private String description;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Illness_id",referencedColumnName = "id")
	private Illness illness;
}
