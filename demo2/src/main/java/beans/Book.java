package beans;

public class Book {
    private int id;
    private String name;
    private String publish;
    private double price;

    public Book() {}

    public Book(int id, String name, String publish, double price) {
        this.id = id;
        this.name = name;
        this.publish = publish;
        this.price = price;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPublish() { return publish; }
    public void setPublish(String publish) { this.publish = publish; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}