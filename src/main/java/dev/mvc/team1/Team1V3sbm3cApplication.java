package dev.mvc.team1;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"dev.mvc"})
public class Team1V3sbm3cApplication {

	public static void main(String[] args) {
		SpringApplication.run(Team1V3sbm3cApplication.class, args);
	}

}
