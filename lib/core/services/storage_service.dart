import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage('app');
    await _box.initStorage;
    print('✅ StorageService initialized');
    return this;
  }

  // Generic methods
  void write(String key, dynamic value) => _box.write(key, value);

  T? read<T>(String key) => _box.read<T>(key);

  bool hasData(String key) => _box.hasData(key);

  void remove(String key) => _box.remove(key);

  void clear() => _box.erase();
}
