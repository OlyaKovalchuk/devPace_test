import 'package:dev_pace_test/constants.dart';
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
  static const kLogoAnimDuration = 30;
  final _gridKey = GlobalKey<State>();
  final _maxLogoHeight = ValueNotifier<double?>(null);

  double get _pageHeight =>
      MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.bottom;

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
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Logo image
            ValueListenableBuilder(
              valueListenable: _maxLogoHeight,
              builder: (context, maxHeight, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: kLogoAnimDuration),
                  constraints: BoxConstraints(
                    minHeight: kLogoMinHeight,
                    maxHeight: (maxHeight ?? _pageHeight) - bottomPadding,
                  ),
                  child: SizedBox.expand(
                    child: Image.asset(
                      Assets.assetsDevpaceLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),

            GridView.builder(
              key: _gridKey,
              itemCount: _items.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 40,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(
                  child: Text('${_items[index]} $index'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _calculateLogoMaxHeight() {
    final paddings = MediaQuery.of(context).padding;
    final gridRenderBox =
        _gridKey.currentContext?.findRenderObject() as RenderBox?;

    final gridHeight = (gridRenderBox?.size.height ?? 0);

    final maxHeight = _pageHeight - paddings.top;

    if (maxHeight > gridHeight) {
      final maxLogoHeight = maxHeight - gridHeight;
      if (maxLogoHeight >= kLogoMinHeight) {
        _maxLogoHeight.value = maxLogoHeight;
      }
    }
  }
}
