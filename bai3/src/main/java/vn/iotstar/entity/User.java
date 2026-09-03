package vn.iotstar.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(nullable = false, length = 50)
    private String password;

    @Column(length = 100)
    private String email;

    private int roleid; // 1: Admin, 2: User
    private int status; // 0: Chưa kích hoạt OTP, 1: Đã kích hoạt
    private String code; // Lưu mã OTP 6 số

    @Column(length = 100)
    private String fullname;

    @Column(length = 20)
    private String phone;

    @Column(length = 500)
    private String images;

    public User() {}

    public User(String username, String password, String email, int roleid, int status, String code) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.roleid = roleid;
        this.status = status;
        this.code = code;
    }

    public User(int id, String username, String password, String email, int roleid) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.roleid = roleid;
        this.status = 0; // Default status: chưa kích hoạt OTP
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getRoleid() { return roleid; }
    public void setRoleid(int roleid) { this.roleid = roleid; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
}