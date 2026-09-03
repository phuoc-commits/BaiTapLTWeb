<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #312e81 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }
        .register-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
        }
        .brand-logo {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            color: white;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 16px auto;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.3);
        }
        .form-control:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
        }
        .btn-register {
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            color: white;
            border: none;
            font-weight: 600;
            padding: 12px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card register-card p-4 p-md-5">
                
                <!-- Logo & Heading -->
                <div class="text-center mb-4">
                    <div class="brand-logo">
                        <i class="bi bi-person-plus-fill"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Tạo Tài Khoản</h3>
                    <p class="text-muted small">Đăng ký để trải nghiệm dịch vụ của chúng tôi</p>
                </div>

                <!-- Thông báo lỗi (nếu có) -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show text-center py-2" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Form đăng ký -->
                <form action="${pageContext.request.contextPath}/register" method="post">
                    
                    <!-- Username -->
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold text-dark">Tên đăng nhập</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-muted"></i></span>
                            <input type="text" class="form-control border-start-0 ps-0" id="username" name="username" placeholder="Nhập tên tài khoản" required>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold text-dark">Địa chỉ Email</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                            <input type="email" class="form-control border-start-0 ps-0" id="email" name="email" placeholder="name@example.com" required>
                        </div>
                    </div>

                    <!-- Mật khẩu -->
                    <div class="mb-3">
                        <label for="password" class="form-label fw-semibold text-dark">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                            <input type="password" class="form-control border-start-0 ps-0" id="password" name="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <!-- Xác nhận mật khẩu -->
                    <div class="mb-4">
                        <label for="repassword" class="form-label fw-semibold text-dark">Xác nhận mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-shield-lock text-muted"></i></span>
                            <input type="password" class="form-control border-start-0 ps-0" id="repassword" name="repassword" placeholder="••••••••" required>
                        </div>
                    </div>

                    <!-- Nút Đăng ký -->
                    <button type="submit" class="btn btn-register w-100 mb-3">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Ký Ngay
                    </button>

                    <!-- Chuyển sang Đăng nhập -->
                    <div class="text-center mt-3">
                        <span class="text-muted small">Đã có tài khoản? </span>
                        <a href="${pageContext.request.contextPath}/login" class="text-primary fw-bold text-decoration-none small">Đăng nhập tại đây</a>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>