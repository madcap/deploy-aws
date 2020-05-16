package org.maats.deployaws

import groovy.transform.CompileStatic
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication

@SpringBootApplication
@CompileStatic
class DeployAwsApplication {

	static void main(String[] args) {
		SpringApplication.run(DeployAwsApplication, args)
	}

}
