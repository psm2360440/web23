package com.kbstar.controller;

import com.kbstar.dto.Ncp;
import com.kbstar.util.CFRCelebrityUtil;
import com.kbstar.util.CFRFaceUtil;
import com.kbstar.util.FileUploadUtil;
import com.kbstar.util.OCRUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
public class NcpController {

    @Autowired
    CFRCelebrityUtil celebrityUtil;

    @Autowired
    CFRFaceUtil cfrFaceUtil;

    @Value("${uploadimgdir}")
    String imgpath;
    @RequestMapping("/cfr1impl")
    public String cfr1impl(Model model, Ncp ncp) throws Exception {
        //이미지 저장
        FileUploadUtil.saveFile(ncp.getImg(),imgpath);
        //NCP요청
        String imgname = ncp.getImg().getOriginalFilename();
        JSONObject result = (JSONObject) celebrityUtil.getResult(imgpath, imgname);

        log.info(result.toJSONString());
        //결과수신

        JSONArray faces = (JSONArray) result.get("faces");
        JSONObject obj = (JSONObject)faces.get(0);
        JSONObject celebrity = (JSONObject) obj.get("celebrity");
        String value = (String) celebrity.get("value");


        model.addAttribute("result",value);
        model.addAttribute("center","cfr1");
        return "index";
    }


    @RequestMapping("/cfr2impl")
    public String cfr2impl(Model model, Ncp ncp) throws Exception {
        //이미지 저장
        FileUploadUtil.saveFile(ncp.getImg(),imgpath);
        //NCP요청
        String imgname = ncp.getImg().getOriginalFilename();
        JSONObject result = (JSONObject) cfrFaceUtil.getResult(imgpath, imgname);

        log.info(result.toJSONString());
        //결과수신


        JSONArray faces = (JSONArray) result.get("faces");
        JSONObject obj = (JSONObject) faces.get(0);


        String emotion_value = "";
        JSONObject emotion = (JSONObject) obj.get("emotion");
        emotion_value = (String) emotion.get("value");

        String gender_value = "";
        JSONObject gender = (JSONObject) obj.get("gender");
        gender_value = (String) gender.get("value");

        String pose_value = "";
        JSONObject pose = (JSONObject) obj.get("pose");
        pose_value = (String) pose.get("value");

        String age_value = "";
        JSONObject age = (JSONObject) obj.get("age");
        age_value = (String) age.get("value");

        Map<String, String> map = new HashMap<>();
        map.put("emotion", emotion_value);
        map.put("age", age_value);
        map.put("pose", pose_value);
        map.put("gender", gender_value);


        String result2 = emotion_value + gender_value + pose_value + age_value;

        model.addAttribute("result", map);

        model.addAttribute("center","cfr2");
        return "index";
    }

    @RequestMapping("/mycfr")
    public String mycfr(Model model, String imgname) throws Exception {

        //NCP요청
        JSONObject result = (JSONObject) cfrFaceUtil.getResult(imgpath, imgname);

        log.info(result.toJSONString());
        //결과수신


        JSONArray faces = (JSONArray) result.get("faces");
        JSONObject obj = (JSONObject) faces.get(0);


        String emotion_value = "";
        JSONObject emotion = (JSONObject) obj.get("emotion");
        emotion_value = (String) emotion.get("value");

        String gender_value = "";
        JSONObject gender = (JSONObject) obj.get("gender");
        gender_value = (String) gender.get("value");

        String pose_value = "";
        JSONObject pose = (JSONObject) obj.get("pose");
        pose_value = (String) pose.get("value");

        String age_value = "";
        JSONObject age = (JSONObject) obj.get("age");
        age_value = (String) age.get("value");

        Map<String, String> map = new HashMap<>();
        map.put("emotion", emotion_value);
        map.put("age", age_value);
        map.put("pose", pose_value);
        map.put("gender", gender_value);


        String result2 = emotion_value + gender_value + pose_value + age_value;

        model.addAttribute("result", map);

        model.addAttribute("center","pic");
        return "index";



    }

    @RequestMapping("/ocr1impl")
    public String ocr1impl(Model model, Ncp ncp) throws Exception {

        FileUploadUtil.saveFile(ncp.getImg(),imgpath);
        String imgname = ncp.getImg().getOriginalFilename();

        JSONObject result = null;
        result = (JSONObject) OCRUtil.getResult(imgpath, imgname);
        Map map =  OCRUtil.getData(result);

        model.addAttribute("result", map);

        model.addAttribute("center","ocr1");
        return "index";

    }

    @RequestMapping("/ocr2impl")
    public String ocr2impl(Model model, Ncp ncp) throws Exception {

        FileUploadUtil.saveFile(ncp.getImg(),imgpath);
        String imgname = ncp.getImg().getOriginalFilename();

        JSONObject result = null;
        result = (JSONObject) OCRUtil.getResult(imgpath, imgname);
        Map map =  OCRUtil.getCardData(result);

        model.addAttribute("result", map);

        model.addAttribute("center","ocr2");
        return "index";

    }
}
