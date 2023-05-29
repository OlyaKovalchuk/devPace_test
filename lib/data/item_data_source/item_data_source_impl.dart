abstract class IItemDataSource {
  Future<String> generateItemName();

  Future<void> simulateRemovingItem();
}
