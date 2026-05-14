<%@ page language="java" contentType="application/octet-stream" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String filename = request.getParameter("filename");
    if (filename == null || filename.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "文件名不能为空");
        return;
    }
    
    String filePath = application.getRealPath("/FILES") + File.separator + filename;
    File file = new File(filePath);
    
    if (!file.exists()) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "文件不存在");
        return;
    }
    
    response.setContentType("application/octet-stream");
    response.setContentLength((int) file.length());
    
    String encodedFilename = URLEncoder.encode(filename, "UTF-8");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFilename + "\"");
    
    FileInputStream fis = new FileInputStream(file);
    OutputStream os = response.getOutputStream();
    
    byte[] buffer = new byte[4096];
    int bytesRead;
    while ((bytesRead = fis.read(buffer)) != -1) {
        os.write(buffer, 0, bytesRead);
    }
    
    fis.close();
    os.close();
%>