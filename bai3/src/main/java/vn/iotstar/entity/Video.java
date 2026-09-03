package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "videos")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM Video v")
public class Video implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "videoId")
    private String videoId;

    @Column(name = "active")
    private boolean active;

    // Đổi NVARCHAR(MAX) thành TEXT (chuẩn cho MySQL)
    @Column(name = "description", columnDefinition = "TEXT NULL")
    private String description;

    // Đổi NVARCHAR thành VARCHAR
    @Column(name = "poster", columnDefinition = "VARCHAR(500) NULL")
    private String poster;

    // Đổi NVARCHAR thành VARCHAR
    @Column(name = "title", columnDefinition = "VARCHAR(255) NULL")
    private String title;

    @Column(name = "views")
    private int views;

    // Mối quan hệ Nhiều-1 với Category
    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category category;

    public Video() {}

    // --- Getter và Setter ---
    public String getVideoId() { return videoId; }
    public void setVideoId(String videoId) { this.videoId = videoId; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}