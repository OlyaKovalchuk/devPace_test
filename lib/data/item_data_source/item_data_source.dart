import 'dart:math';

import 'package:dev_pace_test/data/item_data_source/item_data_source_impl.dart';

class ItemDataSource implements IItemDataSource {
  @override
  Future<String> generateItemName() async {
    // // to simulate loading data
    await Future.delayed(const Duration(seconds: 1));

    final returnItem = Random().nextBool();

    if (returnItem) {
      return 'Item';
    } else {
      throw Exception('Unsuccessful generation of a name');
    }
  }

  @override
  Future<void> simulateRemovingItem() async {
    // to simulate loading data
    await Future.delayed(const Duration(seconds: 1));

    final returnItem = Random().nextBool();

    if (!returnItem) {
      throw Exception('Unsuccessful removing of an item');
    }
    return;
  }
}
