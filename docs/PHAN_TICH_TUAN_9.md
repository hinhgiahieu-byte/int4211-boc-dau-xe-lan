# HỒ SƠ MỐC TUẦN 9: CHỐT PHÂN TÍCH HỆ THỐNG

**Học phần:** INT4211 - Phát triển ứng dụng di động và phân tán  
**Đề tài:** Đề 19 – Hệ thống quản lý phòng tập gym – yoga  
**Nhóm thực hiện:** Nhóm NoName  

---

## 1. Danh sách thành viên & Phân công nhiệm vụ chính thức (Nhóm NoName)

| STT | Mã nhóm | MSSV | Họ và tên | Vai trò | Phân công nhiệm vụ chi tiết |
| :---: | :--- | :--- | :--- | :--- | :--- |
| 1 | Nhóm NoName | **[MSSV]** | **[Họ tên]** | Nhóm trưởng / Backend & Admin Lead | - Thiết kế kiến trúc Backend Express.js & xác thực JWT<br>- Xây dựng API đặt chỗ lớp học với Transaction ACID + `SELECT ... FOR UPDATE` chống vượt sức chứa phòng tập<br>- Xây dựng API hủy đặt chỗ, danh sách chờ tự động, báo cáo tỷ lệ lấp đầy & doanh thu<br>- Triển khai hạ tầng Backend lên Render / Supabase<br>- App Admin: Tính năng quét mã QR check-in hội viên & biểu đồ thống kê doanh thu |
| 2 | Nhóm NoName | **[MSSV]** | **[Họ tên]** | Thành viên / Database & Admin Dev | - Thiết kế CSDL PostgreSQL Supabase (`schema.sql` thực thể nghiệp vụ & `seed.sql` dữ liệu mẫu chuẩn Đề 19)<br>- Xây dựng RESTful API quản lý cơ sở, phòng tập, huấn luyện viên (HLV), gói tập và lịch lớp học<br>- App Admin: Giao diện quản lý danh sách lớp học theo tuần, cấu hình lịch làm việc của HLV, phân ca và quản lý phòng tập |
| 3 | Nhóm NoName | **[MSSV]** | **[Họ tên]** | Thành viên / Client Mobile Dev | - App Client (Flutter): Module xác thực người dùng (Đăng ký, Đăng nhập JWT, Lưu token bảo mật)<br>- App Client: Giao diện duyệt lịch lớp tuần, tìm kiếm & bộ lọc đa tiêu chí (theo bộ môn, HLV, cơ sở)<br>- App Client: Màn hình chi tiết lớp học, hiển thị thông tin phòng tập, sức chứa, trạng thái còn chỗ và thông báo nhắc giờ tập<br>- App Client: Giao diện quản lý gói tập cá nhân (hiển thị thời hạn, số buổi còn lại) |
| 4 | Nhóm NoName | **[MSSV]** | **[Họ tên]** | Thành viên / Client Mobile Dev | - App Client (Flutter): Quy trình đặt chỗ lớp học (chọn buổi học theo lịch, xử lý logic tự động vào danh sách chờ khi lớp đầy)<br>- App Client: Màn hình hiển thị mã QR Code cá nhân động phục vụ check-in tại quầy lễ tân/cổng phòng tập<br>- App Client: Giao diện Nhật ký tập luyện (ghi chú bài tập, số set, rep, mức tạ) và theo dõi chỉ số cơ thể qua biểu đồ (cân nặng, vòng eo, tỷ lệ mỡ)<br>- App Client: Quản lý lịch sử đặt lớp, tra cứu trạng thái và thao tác hủy đặt chỗ theo quy định |

---

## 2. Sơ đồ Use Case tổng thể hệ thống (10 Use Case - Đề 19)

Hệ thống phục vụ 2 nhóm tác nhân chính:
1. **`HOI_VIEN` (Hội viên / Khách hàng):** Tra cứu lịch lớp, đặt chỗ (hoặc vào danh sách chờ), xuất mã QR check-in, ghi nhật ký tập luyện, theo dõi chỉ số cơ thể.
2. **`QUAN_TRI` (Quản trị viên / Nhân viên phòng tập):** Quản lý cơ sở, HLV, gói tập, lịch lớp học, quét mã QR check-in hội viên, theo dõi cảnh báo chăm sóc và báo cáo doanh thu.

``mermaid
flowchart LR
    HOI_VIEN["Hội viên"] --> UC01["Đăng nhập"]
    HOI_VIEN --> UC02["Tra cứu lịch lớp"]
    HOI_VIEN --> UC03["Đặt chỗ & Chờ"]
    HOI_VIEN --> UC04["Hủy đặt chỗ"]
    HOI_VIEN --> UC05["Mã QR check-in"]
    HOI_VIEN --> UC06["Gói tập cá nhân"]
    HOI_VIEN --> UC07["Nhật ký tập"]

    QUAN_TRI["Quản trị viên"] --> UC01
    QUAN_TRI --> UC08["Quản lý cơ sở & HLV"]
    QUAN_TRI --> UC09["Quản lý lịch & Check-in"]
    QUAN_TRI --> UC10["Báo cáo doanh thu"]
