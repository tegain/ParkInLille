import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parklille/widgets/map_filters_dialog.dart';

class MapFilters extends StatelessWidget {
  final double top;
  final double left;
  final double bottom;
  final double right;
  final bool show3d;

  MapFilters({Key key, this.top, this.left, this.right = 24, this.bottom = 24, this.show3d})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: bottom,
        right: right,
        left: left,
        top: top,
        child: Material(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 2.0,
          child: InkWell(
            radius: 20.0,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.tune,
                size: 24.0,
              ),
            ),
            onTap: () {
              _showDialog(context);
            },
          ),
        ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MapFiltersDialog();
      },
    );
  }
}
