package com.bio11.admin.service;

import com.bio11.config.RootConfig;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class AdminMemberServiceImplTest {

    @Autowired
    private AdminMemberService service;

    @Test
    public void 회원리스트() {
        service.getMemberList().forEach(member -> log.info(member));
    }


    @Test
    public void 회원조회() {
        log.info(service.findMember("admin"));
    }
}