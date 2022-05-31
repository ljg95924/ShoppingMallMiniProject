package com.bio11.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
@ComponentScan(basePackages= {"com.bio11.*"})
@MapperScan(basePackages = {"com.bio11.mapper"})
// root-context.xml 역할
public class RootConfig {

	@Autowired
	private ApplicationContext applicationContext;

	
	@Bean //메소드의 실행 결과로 반환된 객체는 스프링 객체로 등록
	public DataSource dataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		
//		hikariConfig.setDriverClassName("oracle.jdbc.driver.OracleDriver");
//		hikariConfig.setJdbcUrl("jdbc:oracle:thin:@211.204.195.197:11521:direadb"); 192.168.55.10:11521
		
		hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@211.204.195.197:11521:direadb");
		
		hikariConfig.setUsername("bio11");
		hikariConfig.setPassword("bio11");
		HikariDataSource dataSource =  new HikariDataSource(hikariConfig);
		
		return dataSource;
	}
	
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory  = new SqlSessionFactoryBean();
		sqlSessionFactory.setConfigLocation(applicationContext.getResource("classpath:mybatis-config.xml"));
		sqlSessionFactory.setDataSource(dataSource());
		return (SqlSessionFactory)sqlSessionFactory.getObject();
	}

	@Bean
	public DataSourceTransactionManager txManager() {
		return new DataSourceTransactionManager(dataSource());
	}

	@Bean //Mail 전송 관련 설정
	public static JavaMailSender mailSender() {

		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
//		mailSender.setHost("smtp.naver.com");
//		mailSender.setPort(465);
//		mailSender.setUsername("ybumm@naver.com");
//		mailSender.setPassword("password");
		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(465);	//587 465
		mailSender.setUsername("ybum1224@gmail.com");
		mailSender.setPassword("212ss1302");

		Properties props = mailSender.getJavaMailProperties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.debug", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");


		return mailSender;
	}

	
}
