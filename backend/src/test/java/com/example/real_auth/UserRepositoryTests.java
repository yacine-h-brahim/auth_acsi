package com.example.real_auth;
 
import static org.assertj.core.api.Assertions.assertThat;
 
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;
import java.util.List;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(false)
public class UserRepositoryTests {
 
    @Autowired
    private TestEntityManager entityManager;
     
    @Autowired
    private UserRepository repo;
    
    @Test
    public void testCreateUser() {
        User user = new User();
        user.setEmail("s.meharzi@esi-sba.dz");
        user.setPassword("hello");
        user.setUsername("SlyPex");
        user.setName("Slimane");
        user.setLastname("MEHRAZI");
        User savedUser = repo.save(user);
     
        User existUser = entityManager.find(User.class, savedUser.getId());
     
        assertThat(user.getEmail()).isEqualTo(existUser.getEmail());
     
    }

    @Test
    public void testFindUserByEmail(){
        List<User> foundUser = repo.findByEmail("s.meharzi@esi-sba.dz");

        System.out.println(foundUser.size());
    }

    @Test
    public void testFindUserByUsername(){
        List<User> foundUser = repo.findByUsername("SlyPex");

        System.out.println(foundUser.size());
    }

    @Test
    public void testExistUserByUsername(){
        System.out.println(repo.existsByUsername("SlyPex"));
    }

    @Test
    public void testExistUserByEmail(){
        System.out.println(repo.existsByEmail("s.meharzi@esi-sba.dz"));
    }

    @Test
    public void testFindbyEmailAndUsername(){
        User user = new User();
        user.setEmail("s.meharzi@esi-sba.dz");
        user.setPassword("Skye is the best");

        user = repo.findByEmailAndPassword(user.getEmail(), user.getPassword());
        System.out.println(user.getUsername());
    }
}