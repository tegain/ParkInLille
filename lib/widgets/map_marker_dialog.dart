import 'package:flutter/material.dart';

import 'package:parklille/models/feature.dart';
import 'package:parklille/extensions/string_extension.dart';

class MapMarkerDialog extends StatefulWidget {
  final Feature feature;
  final Function onCloseDialog;
  final Function({Feature to}) onTriggerNavigation;

  MapMarkerDialog({Key key, @required this.onTriggerNavigation, @required this.onCloseDialog, @required this.feature})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MapMarkerDialogState();
  }
}

class _MapMarkerDialogState extends State<MapMarkerDialog> {
  bool isDialogToggled = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        left: 20,
        right: 78,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black26, offset: Offset.fromDirection(2, 3), blurRadius: 3),
            ],
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.white,
          ),
          child: InkWell(
            onTap: _onTapDialog,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 214,
                                    child: Text(
                                      widget.feature.getLabel(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ))),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: widget.feature.getParkingColor(),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                ' ${widget.feature.fields.etat.capitalize()} - ',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Icon(
                                Icons.directions_car,
                                size: 18,
                              ),
                              Text(' ${widget.feature.getAvailability()} places',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          widget.onTriggerNavigation(to: widget.feature);
                        },
                        child: Icon(
                          Icons.directions,
                          size: 54,
                          color: Colors.cyan,
                        ),
                      )
                    ],
                  ),
                  isDialogToggled
                      ? Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Mise à jour : ${widget.feature.getUpdatedTime()}',
                                        style: TextStyle(fontSize: 10, color: Colors.black54),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 4),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.local_parking,
                                              color: Colors.black26,
                                              size: 18,
                                            ),
                                          ),
                                          Text('Places max. : ${widget.feature.fields.max}'),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.pin_drop,
                                            color: Colors.black26,
                                            size: 18,
                                          ),
                                        ),
                                        Text('${widget.feature.fields.adresse}, ${widget.feature.fields.ville}'),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                      : null,
                ].where(_notNull).toList(),
              ),
            ),
          ),
        ));
  }

  void _onTapDialog() {
    setState(() {
      isDialogToggled = !isDialogToggled;
    });
  }

  bool _notNull(Object o) => o != null;
}
