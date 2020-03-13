import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapFiltersDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapFiltersDialogState();
  }
}

class _MapFiltersDialogState extends State<MapFiltersDialog> {
  bool show3d = false;
  bool showClosedParkings = true;
  bool showFullParkings = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Material(
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      title: Text('Activer la 3D'),
                      value: show3d,
                      onChanged: (bool value) {
                        setState(() {
                          show3d = value;
                        });
                      },
                      secondary: Icon(Icons.threed_rotation),
                    ),
                    SwitchListTile(
                      title: Text('Afficher les parkings fermés'),
                      value: showClosedParkings,
                      onChanged: (bool value) {
                        setState(() {
                          showClosedParkings = value;
                        });
                      },
                      secondary: Icon(Icons.block),
                    ),
                    SwitchListTile(
                      title: Text('Afficher les parkings complets'),
                      value: showFullParkings,
                      onChanged: (bool value) {
                        setState(() {
                          showFullParkings = value;
                        });
                      },
                      secondary: Icon(Icons.access_time),
                    )
                  ],
                ),
              )
          ),
        )
      ],
    );
  }
}
