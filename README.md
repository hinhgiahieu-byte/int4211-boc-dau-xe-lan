# HỆ THỐNG QUẢN LÝ PHÒNG TẬP GYM – YOGA

**Môn học:** INT4211 – Lập trình trên các thiết bị di động  
**Đề tài:** Đề 19 – Hệ thống quản lý phòng tập gym – yoga  

---

## 1. Giới thiệu
Xây dựng hệ thống quản lý phòng tập gym – yoga hỗ trợ ban quản lý trong việc quản lý cơ sở, huấn luyện viên, gói tập, lịch lớp học, check-in hội viên và báo cáo doanh thu; đồng thời giúp hội viên dễ dàng tra cứu lịch lớp, đặt chỗ, quản lý gói tập, xem mã QR check-in và theo dõi nhật ký tập luyện cùng chỉ số cơ thể.

---

## 2. Công nghệ sử dụng

| Thành phần | Công nghệ |
| :--- | :--- |
| **Android Admin** | Android Studio, Java, XML Layout (minSdk 24) |
| **Flutter Client** | Flutter 3.35+, Dart 3 |
| **Backend** | Node.js 20, Express 4 |
| **Cơ sở dữ liệu** | PostgreSQL (Supabase) |
| **Lưu trữ hình ảnh** | Supabase Storage |
| **Triển khai Backend** | Render (Web Service) |
| **Xác thực & Bảo mật** | JWT (JSON Web Token), bcrypt |

---

## 3. Cấu trúc dự án
- **`admin-android/`**: Ứng dụng quản trị Android dành cho ban quản lý / admin.
- **`client-flutter/`**: Ứng dụng di động Flutter dành cho hội viên.
- **`backend/`**: Mã nguồn máy chủ REST API Node.js/Express.
- **`database/`**: Chứa các tệp `schema.sql` (cấu trúc CSDL) và `seed.sql` (dữ liệu mẫu).
- **`phantich/`**: Tài liệu phân tích yêu cầu, sơ đồ Use Case, ERD và API.

---

## 4. Danh sách thành viên và phân công công việc

| STT | Họ và tên | MSSV | GitHub Username | Vai trò phụ trách |
| :---: | :--- | :---: | :---: | :--- |
| **1** | Huỳnh Ngọc Lâm | 221A010237 | [Username GitHub] | Backend: xác thực JWT, API đặt chỗ lớp (transaction xử lý danh sách chờ), check-in, báo cáo; deploy Render |
| **2** | Huỳnh Ngọc Hiếu] | 241A010537 | [Username GitHub] | App Client (Flutter): đăng nhập/đăng ký, xem lịch lớp tuần, đặt chỗ và vào danh sách chờ, mã QR check-in, xem gói tập |
| **3** | [Lương Văn Đô  | | [Username GitHub] | App Client: đăng nhập/đăng ký, xem lịch lớp tuần, đặt chỗ và vào danh sách chờ, mã QR check-in, xem gói tập |
| **4** | Trần Nguyễn Đức Anh | 241A010625 | [Username GitHub] | App Client: nhật ký tập luyện (set/rep/mức tạ), theo dõi chỉ số cơ thể (cân nặng/mỡ), lịch sử tập và hủy đặt chỗ |

---

## 5. Trạng thái dự án
Dự án đang trong giai đoạn khởi tạo cấu trúc thư mục, thiết kế cơ sở dữ liệu và chuẩn bị triển khai các thành phần theo tiến độ 8 tuần.
