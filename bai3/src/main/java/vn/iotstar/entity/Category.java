package vn.iotstar.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "categories")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private int categoryId;

    @Column(name = "Categoryname", nullable = false, length = 200)
    private String categoryname;

    @Column(name = "Images", length = 500)
    private String images;

    @Column(name = "Status")
    private int status;

    // Quan hệ 1-N với Video
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private List<Video> videos;

    // Quan hệ 1-N với Product
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private List<Product> products;

    public Category() {
    }

    public Category(int categoryId, String categoryname, String images, int status) {
        this.categoryId = categoryId;
        this.categoryname = categoryname;
        this.images = images;
        this.status = status;
    }

    // --- Getters và Setters ---
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}