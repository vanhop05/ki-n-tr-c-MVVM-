import 'package:flutter_test/flutter_test.dart';
import 'package:chu_de_4/main.dart';
import 'package:chu_de_4/models/post_model.dart';
import 'package:chu_de_4/services/api_service.dart';
import 'package:chu_de_4/viewmodels/post_viewmodel.dart';

class MockApiService extends ApiService {
  @override
  Future<List<Post>> fetchPosts() async {
    return [
      Post(id: 1, studentId: '106200270', name: 'Võ Nguyễn Vĩ Nhân', className: '20KTMT2'),
    ];
  }
}

void main() {
  testWidgets('Kiểm tra giao diện PostScreen hiển thị danh sách sinh viên', (tester) async {
    final mockService = MockApiService();
    final viewModel = PostViewModel(api: mockService);

    await tester.pumpWidget(MyApp(viewModel: viewModel));

    final future = viewModel.fetchPosts();
    await tester.pump();

    // Đang tải
    expect(find.byType(MyApp), findsOneWidget);

    await future;
    await tester.pumpAndSettle();

    // Hiển thị tên sinh viên
    expect(find.text('Võ Nguyễn Vĩ Nhân'), findsOneWidget);
    expect(find.textContaining('106200270'), findsOneWidget);
  });
}
