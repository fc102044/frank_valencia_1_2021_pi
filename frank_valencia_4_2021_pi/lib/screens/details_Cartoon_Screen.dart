import 'package:flutter/material.dart';
import 'package:frank_valencia_4_2021_pi/globals/globals.dart';
import 'package:frank_valencia_4_2021_pi/models/cartoon.dart';

class DetailsCartoonScreen extends StatefulWidget {
  final Cartoon cartoon;
  DetailsCartoonScreen({required this.cartoon});

  @override
  _DetailsCartoonScreenState createState() => _DetailsCartoonScreenState();
}

class _DetailsCartoonScreenState extends State<DetailsCartoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gcolorBlue,
        centerTitle: true,
        title: Text('Detalle de ' + widget.cartoon.name),
        actions: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          _getBody(),
          widget.cartoon.psiPowers.length > 0
              ? _getPowers()
              : Text(
                  'Sin poderes',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _getBody() {
    return Column(children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: FadeInImage(
                        placeholder: AssetImage('assets/noimage.png'),
                        image: NetworkImage(widget.cartoon.img),
                        height: 150,
                        width: 100,
                        fit: BoxFit.cover),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 240.0,
                        child: Center(
                          child: Text(
                            widget.cartoon.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 240.0,
                        child: Center(
                          child: Text(
                            widget.cartoon.gender,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 240.0,
                        child: Center(
                          child: Text(
                            widget.cartoon.iV.toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Widget _getPowers() {
    return Column(children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Container(
              width: 450.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: widget.cartoon.psiPowers.map((e) {
                    return Center(
                      child: Expanded(
                          child: Column(
                        children: [
                          FadeInImage(
                              placeholder: AssetImage('assets/noimage.png'),
                              image: NetworkImage(e.img),
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flexible(
                              child: Text(
                                e.description,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ],
                      )),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
