import 'package:flutter/material.dart';

abstract class ExpandableTableItem {
  bool get isExpandable;
  Widget get child;
}
