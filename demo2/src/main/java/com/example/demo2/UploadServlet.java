package com.example.demo2;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        SmartUpload smartUpload = new SmartUpload();
        
        try {
            smartUpload.initialize(getServletConfig(), request, response);
            smartUpload.upload();
            
            String savePath = getServletContext().getRealPath("/FILES");
            java.io.File file = new java.io.File(savePath);
            if (!file.exists()) {
                file.mkdirs();
            }
            
            smartUpload.save(savePath);
            
            String eDrivePath = "E:\\";
            java.io.File eDriveDir = new java.io.File(eDrivePath);
            if (eDriveDir.exists() && eDriveDir.isDirectory()) {
                smartUpload.save(eDrivePath);
            }
            
            out.println("<html>");
            out.println("<head><title>上传成功</title></head>");
            out.println("<body>");
            out.println("<h2>文件上传成功！</h2>");
            out.println("<p><a href='wjsc.jsp'>继续上传</a></p>");
            out.println("</body></html>");
            
        } catch (SmartUploadException e) {
            out.println("<html>");
            out.println("<head><title>上传失败</title></head>");
            out.println("<body>");
            out.println("<h2>文件上传失败：" + e.getMessage() + "</h2>");
            out.println("<p><a href='wjsc.jsp'>返回重新上传</a></p>");
            out.println("</body></html>");
            e.printStackTrace();
        }
    }
}