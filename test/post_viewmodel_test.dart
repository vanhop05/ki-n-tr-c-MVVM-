import 'package:flutter_test/flutter_test.dart';
import 'package:chu_de_4/models/post_model.dart';
import 'package:chu_de_4/services/api_service.dart';
import 'package:chu_de_4/viewmodels/post_viewmodel.dart';

class MockSuccessApiService extends ApiService {
  @override
  Future<List<Post>> fetchPosts() async {
    return [
      Post(id: 1, title: 'Title 1', body: 'Body 1'),
      Post(id: 2, title: 'Title 2', body: 'Body 2'),
    ];
  }
}

class MockErrorApiService extends ApiService {
  @override
  Future<List<Post>> fetchPosts() async {
    throw Exception('Lỗi kết nối mạng');
  }
}

void main() {
  test('fetchPosts thanh cong -> status success', () async {
    // 1. Arrange: khoi tao Mock Service
    final mock = MockSuccessApiService();
    final vm = PostViewModel(api: mock);

    // 2. Act: goi ham fetch
    final future = vm.fetchPosts();
    expect(vm.status, ViewStatus.loading); // Kiem tra loading

    await future;

    // 3. Assert: ket qua thanh cong
    expect(vm.status, ViewStatus.success);
    expect(vm.posts.length, 2);
  });

  test('fetchPosts that bai -> status error', () async {
    // 1. Arrange: khoi tao Mock Service loi
    final mock = MockErrorApiService();
    final vm = PostViewModel(api: mock);

    // 2. Act: goi ham fetch
    await vm.fetchPosts();

    // 3. Assert: ket qua bao loi
    expect(vm.status, ViewStatus.error);
    expect(vm.posts.isEmpty, true);
    expect(vm.error.contains('Lỗi kết nối mạng'), true);
  });
}
