# Chuyên Đề 04: Kiến Trúc Flutter - Mô Hình MVVM

Ứng dụng demo chuẩn kiến trúc **MVVM** với **Luồng dữ liệu một chiều (UDF)**, tách biệt hoàn toàn tầng Network Service và quản lý trạng thái bằng `ChangeNotifier` / `ListenableBuilder`.

---

## 1. Cấu Trúc  4 Tầng 

```text
lib/
├── models/
│   └── post_model.dart            # DTO & hàm parse fromJson (Không chứa business logic)
├── services/
│   └── api_service.dart           # Gọi REST API (http), độc lập hoàn toàn với Flutter UI
├── viewmodels/
│   └── post_viewmodel.dart        # Quản lý 3 trạng thái (Loading, Success, Error), phát notifyListeners()
├── views/
│   ├── widgets/
│   │   ├── error_view.dart        # Widget báo lỗi & nút "Thử lại" (Retry)
│   │   └── post_item.dart         # Widget hiển thị từng thẻ bài viết
│   └── post_screen.dart           # StatelessWidget lắng nghe State qua ListenableBuilder
└── main.dart                      # Khởi chạy ứng dụng
```

---

## 2. Bảng Phân Chia Công Việc

| Thành viên | Nhiệm vụ đảm nhiệm | Tệp tin phụ trách | Kết quả |
| :--- | :--- | :--- | :--- |
| **Trần Văn Hợp** | **Tầng Dữ liệu & Mạng**<br>- Thiết kế Model & DTO<br>- Đóng gói REST API Service | `models/post_model.dart`<br>`services/api_service.dart` | Parse JSON an toàn kiểu, bắt mã HTTP, ném Custom Exception |ây dựng View "sạch" không gọi API<br>- Tối ưu Rebuild với `ListenableBuilder` | `views/post_screen.dart`<br>`views/widgets/post_item.dart` | Hiển thị 100 bài viết, hỗ trợ vuốt làm mới (`RefreshIndicator`) |
| **Mai Tuấn An** | **Tầng ViewModel & Kiểm thử**<br>- Logic nghiệp vụ & quản lý 3 trạng thái<br>- Viết Unit Test độc lập | `viewmodels/post_viewmodel.dart`<br>`test/post_viewmodel_test.dart` | Điều phối UDF, kiểm thử Mock Service không cần mở UI |
 Xử lý trạng thái Loading & Error/Retry<br>- Biên soạn Slide thuyết trình | `views/widgets/error_view.dart`<br>Slide báo cáo (18 trang) | Giao diện thân thiện khi rớt mạng, hoàn thiện tài liệu báo cáo |
---

## 3. Các Trạng Thái Trực Quan (UI States)

1. **Loading State**: Hiển thị `CircularProgressIndicator` chính giữa màn hình trong lúc tải dữ liệu.
2. **Success State**: Hiển thị 100 bài viết qua `ListView.builder` kèm `RefreshIndicator` để vuốt làm mới.
3. **Error & Retry State**: Khi mất mạng hoặc lỗi máy chủ, hiển thị thông báo lỗi thân thiện kèm nút **"Thử lại"** (không gây crash ứng dụng).

---

## 4. Hướng Dẫn Chạy & Kiểm Thử

* **Chạy ứng dụng (Web / Mobile / Desktop):**
  ```bash
  flutter run
  ```

* **Chạy kiểm thử Unit Test (Không cần mở UI):**
  ```bash
  flutter test test/post_viewmodel_test.dart
  ```
