import 'package:ds_podi/ds_podi.dart';
import 'package:flutter/material.dart';

import '../model/enums/device_type.enum.dart';
import '../model/expandable_table_item.dart';

class TableWidget<T> extends StatefulWidget {
  final List<T> items;
  final List<TableColumnWidget<T>> columns;
  final DeviceType? deviceType;
  final bool? sortIndicator;
  final double spacing;
  final double lineHeight;
  final Color? borderColor;
  final void Function(T item, int columnIndex)? onTapItem;
  final TextStyle? titleStyle;
  final bool busy;
  const TableWidget({
    Key? key,
    required this.items,
    required this.columns,
    this.deviceType,
    this.lineHeight = 48,
    this.spacing = 16,
    this.sortIndicator,
    this.borderColor,
    this.onTapItem,
    this.titleStyle,
    this.busy = false,
  }) : super(key: key);

  @override
  TableWidgetState<T> createState() => TableWidgetState<T>();
}

class TableWidgetState<T> extends State<TableWidget<T>> {
  late List<T> _sortedItems;

  int? _selectedSort;
  bool _reverseSort = false;

  void sortItems(int index) {
    if (index == _selectedSort) {
      // _selectedSort = null;
      if (_reverseSort) {
        setState(() {
          // _sortedItems = widget.items;
          _reverseSort = false;
          _selectedSort = null;
        });
      } else {
        setState(() {
          // _sortedItems = _sortedItems.reversed.toList();
          _reverseSort = true;
        });
      }
    } else {
      setState(() {
        // _sortedItems = widget.items.sorted(widget.columns[index].onSort);
        _reverseSort = false;
        _selectedSort = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _sortedItems = widget.items;
  }

  @override
  void didUpdateWidget(oldTable) {
    super.didUpdateWidget(oldTable);
    if (oldTable.deviceType != widget.deviceType) {
      if (mounted) setState(() {});
    }
  }

  List<TableColumnWidget<T>> get columns =>
      ((widget.deviceType ?? DeviceType.Desktop) == DeviceType.Desktop)
          ? widget.columns
          : widget.columns.whereList((c) => c.showOnMobile);

  int get length => columns.length;
  int get itemCount => widget.items.length; // Numero de linhas

  @override
  Widget build(BuildContext context) {
    Widget _buildItemContainer(int index, Widget child,
        {bool isTitle = false}) {
      return columns[index]
          .width
          .addConstraints(child, (isTitle) ? 48 : widget.lineHeight);
    }

    Widget _buildTitle(int index) {
      final column = columns[index];
      return _buildItemContainer(
        index,
        InkWell(
          onTap: () {
            if (column.onTapTitle != null) column.onTapTitle!();
            sortItems(index);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text(column.title,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: (widget.titleStyle ??
                            PodiTexts.caption
                                .size(10)
                                .heightRegular
                                .withColor(PodiColors.neutrals[300]!))
                        .copyWith(
                            fontWeight: index == _selectedSort
                                ? FontWeight.w700
                                : FontWeight.w600)),
                Spacer(),
                if (index == _selectedSort) ...[
                  Image.asset(
                    (widget.sortIndicator ?? _reverseSort)
                        ? PodiIcons.sortUpward
                        : PodiIcons.sortDownward,
                    height: 12,
                    width: 12,
                  ),
                  SizedBox(width: 16),
                ]
              ],
            ),
          ),
        ),
        isTitle: true,
      );
    }

    Widget _buildRow(List<Widget> children) {
      final _children = <Widget>[];
      for (var i = 0; i < children.length; i++) {
        _children.add(children[i]);
        if (i != children.length - 1) {
          _children.add(SizedBox(width: 16));
        }
      }
      return Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: widget.borderColor ?? PodiColors.dark[50]!, width: 1)),
        ),
        child: Row(children: _children),
      );
    }

    Widget _buildItem(int index, T item) {
      return _buildItemContainer(
        index,
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                if (widget.onTapItem == null) return;
                widget.onTapItem!(item, index);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  child: columns[index].buildItem(context, constraints, item),
                  alignment: Alignment.centerLeft,
                ),
              ),
            );
          },
        ),
      );
    }

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRow(List.generate(length, (index) => _buildTitle(index))),
            for (var item in _sortedItems) ...[
              if (item is ExpandableTableItem && item.isExpandable) ...[
                ExpansionTile(
                  backgroundColor: (_sortedItems.indexOf(item) % 2 == 0)
                      ? PodiColors.dark[50]!.withOpacity(0.05)
                      : PodiColors.dark[50]!.withOpacity(0.25),
                  controlAffinity: ListTileControlAffinity.leading,
                  tilePadding: EdgeInsets.symmetric(vertical: 0),
                  childrenPadding: const EdgeInsets.all(16),
                  title: _buildRow(
                    List.generate(
                      length,
                      (index) => _buildItem(index, item),
                    ),
                  ),
                  children: [
                    item.child,
                  ],
                )
              ] else ...[
                Container(
                  color: (_sortedItems.indexOf(item) % 2 == 0)
                      ? PodiColors.dark[50]!.withOpacity(0.05)
                      : PodiColors.dark[50]!.withOpacity(0.25),
                  child: _buildRow(
                    List.generate(
                      length,
                      (index) => _buildItem(index, item),
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
        if (widget.busy) ...[
          Container(
            height: (itemCount == 0)
                ? 48 + (widget.lineHeight) + 16
                : (itemCount * (widget.lineHeight)) + 48,
            color: PodiColors.white.withOpacity(0.5),
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(PodiColors.green),
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class TableColumnWidget<T> {
  final String title;

  final TableColumnWidgetWidth width;

  final bool showOnMobile;

  final void Function()? onTapTitle;

  ///```dart
  ///int onSort(a, b) => a.compareTo(b)
  ///```
  final int Function(T a, T b)? onSort;

  final Widget Function(BuildContext, BoxConstraints constraints, T item)
      buildItem;

  const TableColumnWidget(
      {required this.title,
      this.onTapTitle,
      this.onSort,
      this.showOnMobile = true,
      required this.buildItem,
      this.width = const FlexColumnWidgetWidth(1)});
}

abstract class TableColumnWidgetWidth {
  const TableColumnWidgetWidth();

  Widget addConstraints(Widget child, double? height);
}

class FixedColumnWidgetWidth extends TableColumnWidgetWidth {
  final double width;

  const FixedColumnWidgetWidth(this.width);

  @override
  Widget addConstraints(Widget child, double? height) {
    return SizedBox(width: width, height: height, child: child);
  }
}

class FlexColumnWidgetWidth extends TableColumnWidgetWidth {
  final int flex;

  const FlexColumnWidgetWidth(this.flex);
  @override
  Widget addConstraints(Widget child, double? height) {
    return Expanded(flex: flex, child: SizedBox(child: child, height: height));
  }
}
