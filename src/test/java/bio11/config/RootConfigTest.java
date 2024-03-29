package bio11.config;


import java.sql.Connection;

import javax.sql.DataSource;

import com.bio11.config.RootConfig;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class RootConfigTest {

	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void hikari_커넥션풀() {
		try (Connection conn = ds.getConnection()) {
			log.info(conn);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Test
	public void 마이바티스_연결테스트() {
		try (SqlSession session = sqlSessionFactory.openSession();
				Connection con = session.getConnection();) {
			
			log.info("session : " + session);
			log.info("con : " + con);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
