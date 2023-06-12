package com.kbstar.ncp;


import com.kbstar.util.OCRUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Map;


@Slf4j
@SpringBootTest
class OCRTest {


    @Value("${uploadimgdir}")
    String imgpath;

    @Test
    void contextLoads() {
        JSONObject result = null;
        result = (JSONObject) OCRUtil.getResult("C:/project/uimg/", "businesscard.png");
        log.info(result.toJSONString());
        Map map =  OCRUtil.getCardData(result);
        log.info(map.values().toString());

    }
}