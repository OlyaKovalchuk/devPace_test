import 'package:dev_pace_test/generated/assets.dart';
import 'package:flutter/material.dart';

class ItemListWidget extends StatefulWidget {
  const ItemListWidget({
    required this.items,
    Key? key,
  }) : super(key: key);

  final List<String> items;

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  final _gridKey = GlobalKey<State>();
  final _maxLogoHeight = ValueNotifier<double?>(null);

  double get _pageHeight => MediaQuery.sizeOf(context).height;

  List<String> get _items => widget.items;

  @override
  void didUpdateWidget(covariant ItemListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _calculateLogoMaxHeight(),
      );
    }
  }

  @override
  void dispose() {
    _maxLogoHeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          /// Logo image
          ValueListenableBuilder(
            valueListenable: _maxLogoHeight,
            builder: (context, maxHeight, _) => SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: maxHeight ?? _pageHeight,
              flexibleSpace: Center(
                child: Image.asset(Assets.assetsDevpaceLogo),
              ),
            ),
          ),

          /// Item list
          SliverToBoxAdapter(
            child: GridView.builder(
              key: _gridKey,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 40,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  child: Center(
                    child: Text('$item $index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _calculateLogoMaxHeight() {
    final paddings = MediaQuery.of(context).padding;
    final gridRenderBox =
        _gridKey.currentContext?.findRenderObject() as RenderBox?;

    final gridHeight = gridRenderBox?.size.height ?? 0;

    final maxHeight = _pageHeight - paddings.vertical;

    if (maxHeight > gridHeight) {
      _maxLogoHeight.value = maxHeight - gridHeight;
    }
  }
}
