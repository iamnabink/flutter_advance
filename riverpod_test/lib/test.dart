import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider = Provider<SharedPreferences?>((ref) => null);

class TestSignOut extends Notifier<String?> {
  @override
  String? build() {
    throw UnimplementedError();
  }

// Future<void> signOut() async {
//   try {
//     state = const AsyncValue.loading();
//     // await authRepository.signOut();
//     state = const AsyncValue.data(null);
//   } catch (e) {
//     state = AsyncValue.error(e, StackTrace.current);
//   }
// }

// AsyncValue.guard) can do the same thing for you with less
// Future<void> signOut() async {
//   state = const AsyncValue. loading();
//   state = await AsyncValue.guard(() {
//     return authRepository.signOut();
//   });
// }
}
