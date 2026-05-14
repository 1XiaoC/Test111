<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.StudentDao" %>
<%@ page import="beans.Student" %>
<html>
<head>
    <title>学生信息列表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h2>学生信息列表</h2>
<%
    // 调用DAO获取数据
    StudentDao studentDao = new StudentDao();
    ArrayList<Student> students = null;
    try {
        students = studentDao.queryAllStudents();
    } catch (Exception e) {
        out.println("<p style='color:red;'>数据加载失败：" + e.getMessage() + "</p>");
        e.printStackTrace();
        return;
    }
%>

<table border="2" cellpadding="5" cellspacing="0">
    <tr>
        <th>学号</th>
        <th>姓名</th>
    </tr>
    <%
        if (students != null && !students.isEmpty()) {
            for (Student student : students) {
    %>
    <tr>
        <td><%= student.getStuno() %></td>
        <td><%= student.getStuname() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="2">暂无学生数据</td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>