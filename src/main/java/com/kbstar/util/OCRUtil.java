package com.kbstar.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class OCRUtil {

    public static Object getResult(String imgpath, String imgname) {
        JSONObject obj = null;

        String apiURL = "https://uhucar79op.apigw.ntruss.com/custom/v1/22513/5b2b7bfe9d5913712a6ce76dd287efea4a7c9377f22d183c4479078c13232312/infer";
        String secretKey = "SW9LakdPclJIU1VaUlVCSnN2UHN4WWJSZVdDQmJyRHU=";
        String imageFile = imgpath + imgname;

        try {
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setUseCaches(false);
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setReadTimeout(30000);
            con.setRequestMethod("POST");
            String boundary = "----" + UUID.randomUUID().toString().replaceAll("-", "");
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            con.setRequestProperty("X-OCR-SECRET", secretKey);

            JSONObject json = new JSONObject();
            json.put("version", "V2");
            json.put("requestId", UUID.randomUUID().toString());
            json.put("timestamp", System.currentTimeMillis());
            JSONObject image = new JSONObject();
            image.put("format", "jpg");
            image.put("name", "demo");
            JSONArray images = new JSONArray();
            images.add(image);
            json.put("images", images);
            String postParams = json.toString();

            con.connect();
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            long start = System.currentTimeMillis();
            File file = new File(imageFile);
            writeMultiPart(wr, postParams, file, boundary);
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            JSONParser parser = new JSONParser();
            obj = (JSONObject) parser.parse(response.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return obj;
    }

    private static void writeMultiPart(OutputStream out, String jsonMessage, File file, String boundary) throws
            IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("--").append(boundary).append("\r\n");
        sb.append("Content-Disposition:form-data; name=\"message\"\r\n\r\n");
        sb.append(jsonMessage);
        sb.append("\r\n");

        out.write(sb.toString().getBytes("UTF-8"));
        out.flush();

        if (file != null && file.isFile()) {
            out.write(("--" + boundary + "\r\n").getBytes("UTF-8"));
            StringBuilder fileString = new StringBuilder();
            fileString
                    .append("Content-Disposition:form-data; name=\"file\"; filename=");
            fileString.append("\"" + file.getName() + "\"\r\n");
            fileString.append("Content-Type: application/octet-stream\r\n\r\n");
            out.write(fileString.toString().getBytes("UTF-8"));
            out.flush();

            try (FileInputStream fis = new FileInputStream(file)) {
                byte[] buffer = new byte[8192];
                int count;
                while ((count = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, count);
                }
                out.write("\r\n".getBytes());
            }

            out.write(("--" + boundary + "--\r\n").getBytes("UTF-8"));
        }
        out.flush();
    }

    public static Map getData(JSONObject obj) {
        Map<String, String> map = new HashMap<>();
        JSONArray images = (JSONArray) obj.get("images");
        JSONObject object = (JSONObject) images.get(0);
        JSONArray fields = (JSONArray) object.get("fields");

        JSONObject numberobj = (JSONObject) fields.get(0);
        String numberInferText = (String) numberobj.get("inferText");

        JSONObject nameobj = (JSONObject) fields.get(1);
        String nameInferText = (String) nameobj.get("inferText");

        JSONObject ownerobg = (JSONObject) fields.get(2);
        String ownerInferText = (String) ownerobg.get("inferText");

        JSONObject dateobg = (JSONObject) fields.get(3);
        String dateInferText = (String) dateobg.get("inferText");

        JSONObject addrobg = (JSONObject) fields.get(4);
        String addrInferText = (String) addrobg.get("inferText");

        map.put("biznumber", numberInferText);
        map.put("bizname", nameInferText);
        map.put("bizowner", ownerInferText);
        map.put("bizdate", dateInferText);
        map.put("bizaddr", addrInferText);

        return map;

    }

    public static Map getCardData(JSONObject obj) {
        Map<String, String> map = new HashMap<>();
        JSONArray images = (JSONArray) obj.get("images");
        JSONObject object = (JSONObject) images.get(0);
        JSONArray fields = (JSONArray) object.get("fields");

        JSONObject company = (JSONObject) fields.get(0);
        String companyInferText = (String) company.get("inferText");

        JSONObject name = (JSONObject) fields.get(1);
        String nameInferText = (String) name.get("inferText");

        JSONObject addr = (JSONObject) fields.get(2);
        String addrInferText = (String) addr.get("inferText");

        JSONObject depart = (JSONObject) fields.get(3);
        String departInferText = (String) depart.get("inferText");

        JSONObject contact = (JSONObject) fields.get(4);
        String contactInferText = (String) contact.get("inferText");





        map.put("company", companyInferText);
        map.put("name", nameInferText);
        map.put("addr", addrInferText);
        map.put("depart", departInferText);
        map.put("contact", contactInferText);


        return map;

    }
}