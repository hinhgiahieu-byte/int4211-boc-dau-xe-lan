import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:client_mobile/main.dart';

void main() {
  testWidgets('logs a workout and shows it in workout history', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GymManagementApp());

    expect(find.text('Nhật Ký Tập Luyện'), findsOneWidget);
    expect(find.text('Bench Press (Đẩy ngực ngang)'), findsOneWidget);

    await tester.ensureVisible(find.text('Hoàn thành & Lưu buổi tập'));
    await tester.tap(find.text('Hoàn thành & Lưu buổi tập'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lịch sử'));
    await tester.pumpAndSettle();

    expect(find.text('Buổi tập tùy chỉnh (2 bài)'), findsOneWidget);
    expect(find.textContaining('Tổng tạ:'), findsWidgets);
  });

  testWidgets('records body metrics', (WidgetTester tester) async {
    await tester.pumpWidget(const GymManagementApp());
    await tester.tap(find.text('Chỉ số'));
    await tester.pumpAndSettle();

    expect(find.text('Cân nặng'), findsOneWidget);
    expect(find.text('Tỷ lệ mỡ'), findsOneWidget);

    await tester.ensureVisible(find.text('Ghi nhận chỉ số mới hôm nay'));
    await tester.tap(find.text('Ghi nhận chỉ số mới hôm nay'));
    await tester.pumpAndSettle();

    final inputs = find.byType(TextField);
    await tester.enterText(inputs.at(0), '71.8');
    await tester.enterText(inputs.at(1), '15.9');
    await tester.enterText(inputs.at(2), '34.1');
    await tester.tap(find.text('Lưu chỉ số'));
    await tester.pumpAndSettle();

    expect(find.text('71.8 kg'), findsOneWidget);
    expect(find.text('15.9 %'), findsOneWidget);
  });

  testWidgets('cancels a class booking after confirmation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GymManagementApp());
    await tester.tap(find.text('Lớp học'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hủy đặt chỗ').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hủy chỗ'));
    await tester.pumpAndSettle();

    expect(find.text('Còn trống (14/20)'), findsOneWidget);
    expect(find.text('Đã hủy đặt chỗ lớp Yoga Phục Hồi & Giãn Cơ'), findsOneWidget);
  });
}
