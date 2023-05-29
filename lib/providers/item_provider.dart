import 'package:dev_pace_test/data/item_data_source/item_data_source.dart';

class ItemProvider {
  ItemProvider(this._itemDataSource);

  final ItemDataSource _itemDataSource;

  Future<String> generateItemName() => _itemDataSource.generateItemName();

  Future<void> simulateRemovingItem() => _itemDataSource.simulateRemovingItem();
}
