package org.example.geekup;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
public class GeekupApplication {

    public static void main(String[] args) {
        SpringApplication.run(GeekupApplication.class, args);
    }

}
