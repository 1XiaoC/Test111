package beans;

public class Student {
    // 对应数据库表的字段
    private String stuno;   // 学号
    private String stuname; // 姓名

    // 无参构造（必须，JSP/反射常用）
    public Student() {}

    // Getter & Setter
    public String getStuno() {
        return stuno;
    }

    public void setStuno(String stuno) {
        this.stuno = stuno;
    }

    public String getStuname() {
        return stuname;
    }

    public void setStuname(String stuname) {
        this.stuname = stuname;
    }

    // 可选：toString方法，方便调试
    @Override
    public String toString() {
        return "Student{stuno='" + stuno + "', stuname='" + stuname + "'}";
    }
}
