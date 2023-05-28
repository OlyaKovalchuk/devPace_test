import 'dart:convert';
import 'dart:math';

class GenerateItemService {
  Future<String> generateItemName() async {
    // to simulate loading data
    await Future.delayed(const Duration(seconds: 1));

    final returnItem = Random().nextBool();

    if (returnItem) {
      return _getRandomString();
    } else {
      throw Exception('Unsuccessful generation of a name');
    }
  }

  Future<void> simulateRemovingItem() async {
    // to simulate loading data
    await Future.delayed(const Duration(seconds: 1));

    final returnItem = Random().nextBool();

    if (!returnItem) {
      throw Exception('Unsuccessful removing of an item');
    }
    return;
  }

  String _getRandomString() {
    var random = Random.secure();
    var values = List<int>.generate(5, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
