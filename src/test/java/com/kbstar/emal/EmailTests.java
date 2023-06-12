package com.kbstar.emal;

//import com.kbstar.util.PushNotificationUtil;
import com.kbstar.util.SendMailUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

@Slf4j
@SpringBootTest
class EmailTests {

    @Autowired
    SendMailUtil sendMailUtil;

    @Test
    void contextLoads() throws Exception {
        log.info("start email test -------------");
        sendMailUtil.sendAuthMessage("psm2360440@gmail.com","회원가입을 축하드립니다.");
    }

}
