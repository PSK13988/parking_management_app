import 'package:parking_management_app/core/assets.dart';
import 'package:test/test.dart';

void main() {
  test('Verify [Assets] names', () {
    expect(Assets.small, 'assets/images/small.png');
    expect(Assets.large, 'assets/images/large.png');
    expect(Assets.medium, 'assets/images/medium.png');
    expect(Assets.xlarge, 'assets/images/xlarge.png');
  });
}
