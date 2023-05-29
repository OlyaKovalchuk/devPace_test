import 'dart:async';

import 'package:dev_pace_test/pages/bloc/item_list_bloc.dart';
import 'package:dev_pace_test/pages/bloc/item_list_event.dart';
import 'package:dev_pace_test/pages/bloc/item_list_state.dart';
import 'package:dev_pace_test/pages/widgets/item_list_widget.dart';
import 'package:dev_pace_test/pages/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final _itemListBloc = ItemListBloc();
  final _items = <String>[];

  @override
  void dispose() {
    _itemListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// Add button
          FloatingActionButton(
            onPressed: _addItem,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 4),

          /// Remove button
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: _removeItem,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      body: BlocConsumer<ItemListBloc, ItemListState>(
        bloc: _itemListBloc,
        buildWhen: _whenCondition,
        listenWhen: _whenCondition,
        listener: _onStateListener,
        builder: (context, state) {
          _onStateBuilder(state);

          return Stack(
            children: [
              ItemListWidget(items: _items),
              if (_itemListBloc.state is ProgressState) const ProgressWidget(),
            ],
          );
        },
      ),
    );
  }

  FutureOr<void> _onStateListener(BuildContext _, ItemListState state) async {
    if (state is ErrorState) {
      await _showErrorDialog(state);
    }
  }

  void _onStateBuilder(ItemListState state) {
    if (state is ReceivedItemState) {
      _items.add(state.itemName);
    } else if (state is RemovedItemState) {
      _items.removeLast();
    }
  }

  bool _whenCondition(ItemListState prevState, ItemListState nextState) =>
      nextState != prevState;

  void _addItem() => _itemListBloc.add(FetchItemEvent());

  void _removeItem() {
    if (_items.isNotEmpty) {
      _itemListBloc.add(RemoveItemEvent());
    }
  }

  Future<void> _showErrorDialog(ErrorState state) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Text(state.title ?? 'Error'),
          content: Text(state.message ?? ''),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Ok'),
            )
          ],
        ),
      );
}
