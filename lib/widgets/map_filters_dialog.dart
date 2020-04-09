import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parklille/services/features.dart';

class MapFiltersDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FeaturesService featuresService = Provider.of<FeaturesService>(context);
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
                      title: Text('Afficher les parkings fermés'),
                      value: featuresService.getFilter('showClosedParkings'),
                      onChanged: (bool value) {
                        featuresService.setFilter('showClosedParkings', value);
                      },
                      secondary: Icon(Icons.block),
                    ),
                    SwitchListTile(
                      title: Text('Afficher les parkings complets'),
                      value: featuresService.getFilter('showFullParkings'),
                      onChanged: (bool value) {
                        featuresService.setFilter('showFullParkings', value);
                      },
                      secondary: Icon(Icons.access_time),
                    )
                  ],
                ),
              )),
        )
      ],
    );
  }
}
//class MapFiltersDialog extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//
//    return _MapFiltersDialogState();
//  }
//}

//class _MapFiltersDialogState extends State<MapFiltersDialog> {
//  @override
//  Widget build(BuildContext context) {
//    FeaturesService featuresService = Provider.of<FeaturesService>(context);
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.end,
//      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.all(0),
//          child: Container(
//              height: 120,
//              width: MediaQuery.of(context).size.width,
//              color: Colors.white,
//              child: Material(
//                child: Column(
//                  children: <Widget>[
//                    SwitchListTile(
//                      title: Text('Afficher les parkings fermés'),
//                      value: featuresService.getFilter('showClosedParkings'),
//                      onChanged: (bool value) {
//                        setState(() {
//                          featuresService.setFilter('showClosedParkings', value);
//                        });
//                      },
//                      secondary: Icon(Icons.block),
//                    ),
//                    SwitchListTile(
//                      title: Text('Afficher les parkings complets'),
//                      value: featuresService.getFilter('showFullParkings'),
//                      onChanged: (bool value) {
//                        setState(() {
//                          featuresService.setFilter('showFullParkings', value);
//                        });
//                      },
//                      secondary: Icon(Icons.access_time),
//                    )
//                  ],
//                ),
//              )),
//        )
//      ],
//    );
//  }
//}
