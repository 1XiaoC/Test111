package dao;

import beans.Student;
import java.sql.*;
import java.util.ArrayList;

public class StudentDao {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/stubook?useSSL=false&serverTimezone=UTC&characterEncoding=utf8&useUnicode=true";
    private static final String USER = "root";
    private static final String PASSWORD = "x8";
    private static final String SQL_QUERY_ALL = "SELECT id, name, publish, price FROM book";

    public ArrayList<Student> queryAllStudents() throws Exception {
        Connection conn = null;
        Statement stat = null;
        ResultSet rs = null;
        ArrayList<Student> students = new ArrayList<>();

        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            stat = conn.createStatement();
            rs = stat.executeQuery(SQL_QUERY_ALL);

            while (rs.next()) {
                Student student = new Student();
                student.setStuno(rs.getString("id"));
                student.setStuname(rs.getString("name"));

                students.add(student);
            }

        } catch (ClassNotFoundException e) {
            throw new Exception("数据库驱动加载失败：" + e.getMessage(), e);
        } catch (SQLException e) {
            throw new Exception("数据库操作失败：" + e.getMessage(), e);
        } finally {
            // 6. 关闭资源（从后往前关闭，避免依赖问题）
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (stat != null) {
                try { stat.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return students;
    }
}