import 'package:flutter_test/flutter_test.dart';
import 'package:chu_de_4/main.dart';
import 'package:chu_de_4/models/post_model.dart';
import 'package:chu_de_4/services/api_service.dart';
import 'package:chu_de_4/viewmodels/post_viewmodel.dart';

class MockApiService extends ApiService {
  @override
  Future<List<Post>> fetchPosts() async {
    return [
      Post(id: 1, title: 'Bài viết thử nghiệm', body: 'Nội dung bài viết'),
    ];
  }
}

void main() {
  testWidgets('Kiểm tra giao diện PostScreen hiển thị dữ liệu thành công', (tester) async {
    final mockService = MockApiService();
    final viewModel = PostViewModel(api: mockService);

    await tester.pumpWidget(MyApp(viewModel: viewModel));

    // Ban đầu gọi fetchPosts
    final future = viewModel.fetchPosts();
    await tester.pump();

    // Đang tải
    expect(find.byType(MyApp), findsOneWidget);

    await future;
    await tester.pumpAndSettle();

    // Hiển thị bài viết
    expect(find.text('Bài viết thử nghiệm'), findsOneWidget);
  });
}
