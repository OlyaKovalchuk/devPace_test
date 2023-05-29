import 'package:dev_pace_test/data/item_data_source/item_data_source.dart';
import 'package:dev_pace_test/pages/bloc/item_list_event.dart';
import 'package:dev_pace_test/pages/bloc/item_list_state.dart';
import 'package:dev_pace_test/providers/item_provider.dart';
import 'package:dev_pace_test/utils/emitter_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  ItemListBloc() : super(InitState()) {
    on<FetchItemEvent>(
      (event, emit) => emit.async(_fetchItem()),
    );
    on<RemoveItemEvent>(
      (event, emit) => emit.async(_removeItem()),
    );
  }

  final _itemProvider = ItemProvider(ItemDataSource());

  Stream<ItemListState> _fetchItem() async* {
    yield ProgressState();

    try {
      final itemName = await _itemProvider.generateItemName();

      yield ReceivedItemState(itemName);
    } catch (error, _) {
      yield ErrorState(message: error.toString());
    }
  }

  Stream<ItemListState> _removeItem() async* {
    yield ProgressState();

    try {
      await _itemProvider.simulateRemovingItem();

      yield RemovedItemState();
    } catch (error, _) {
      yield ErrorState(message: error.toString());
    }
  }
}
