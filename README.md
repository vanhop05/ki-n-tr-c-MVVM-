# Chuyên Đề 04: Kiến Trúc Flutter - Mô Hình MVVM

Ứng dụng demo chuẩn kiến trúc **MVVM** với **Luồng dữ liệu một chiều (UDF)**, tách biệt hoàn toàn tầng Network Service và quản lý trạng thái bằng `ChangeNotifier` / `ListenableBuilder`.

---

## 1. Cấu Trúc Dự Án 4 Tầng (`lib/`)

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
│   │   └── post_item.dart         # Widget hiển thị từng tên sinh viên trong lớp
│   └── post_screen.dart           # StatelessWidget lắng nghe State qua ListenableBuilder
└── main.dart                      # Khởi chạy ứng dụng
```

---

## 2. Bảng Phân Chia Công Việc

| Thành viên | Nhiệm vụ đảm nhiệm | Tệp tin phụ trách | Kết quả |
| :--- | :--- | :--- | :--- |
| **Trần Văn Hợp** | **Tầng Dữ liệu, Giao diện & Xử lý Trạng thái**<br>- Thiết kế Model & đóng gói REST API Service<br>- Xây dựng View chuẩn với `ListenableBuilder`<br>- Thiết kế thanh Loading  (`LOADING....`)<br>- Xử lý trạng thái Báo lỗi và nút "Thử lại" | `models/post_model.dart`<br>`services/api_service.dart`<br>`views/post_screen.dart`<br>`views/widgets/post_item.dart`<br>`views/widgets/error_view.dart` | Parse JSON an toàn, kết nối API online, giao diện View "sạch", hiệu ứng Loading  và cơ chế Retry khi mất mạng. |
| **Mai Tuấn An** | **Tầng ViewModel, Kiểm thử & Báo cáo**<br>- Quản lý trạng thái và luồng dữ liệu một chiều (UDF)<br>- Viết Unit Test độc lập với Mock Service<br>- Biên soạn nội dung và thiết kế Slide thuyết trình | `viewmodels/post_viewmodel.dart`<br>`test/post_viewmodel_test.dart`<br>Slide báo cáo  | Tách biệt logic nghiệp vụ khỏi UI, Unit Test chạy thành công trong vài mili-giây, hoàn thiện slide báo cáo  |

---

## 3. Các Trạng Thái Trực Quan (UI States)

1. **Loading State**: Hiển thị thanh tiến trình dạng viên thuốc màu xanh (`LOADING....`) ở chính giữa màn hình trong lúc tải dữ liệu.
2. **Success State**: Hiển thị danh sách sinh viên lớp Lập trình Đa nền tảng qua `ListView.builder` kèm `RefreshIndicator` để vuốt làm mới.
3. **Error & Retry State**: Khi mất kết nối mạng hoặc lỗi máy chủ, hiển thị thông báo lỗi thân thiện kèm nút **"Thử lại"** (không gây crash ứng dụng).

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
