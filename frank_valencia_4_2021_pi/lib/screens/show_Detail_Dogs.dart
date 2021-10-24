import 'package:flutter/material.dart';
import 'package:frank_valencia_4_2021_pi/globals/globals.dart';
import 'package:frank_valencia_4_2021_pi/globals/loader.dart';

class ShowDetailsDog extends StatefulWidget {
  final List<String> imagebreeds;
  ShowDetailsDog({required this.imagebreeds});

  @override
  _ShowDetailsDogState createState() => _ShowDetailsDogState();
}

class _ShowDetailsDogState extends State<ShowDetailsDog> {
  bool _showLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gcolorBlue,
        centerTitle: true,
        title: Text('Fotos'),
        actions: <Widget>[],
      ),
      body: Stack(children: <Widget>[
        _getBody(),
      ]),
    );
  }

  _getBody() {
    return ListView(
      children: widget.imagebreeds.map((e) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Card(
              color: Colors.white,
              shadowColor: Colors.blueGrey,
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                            placeholder: AssetImage('assets/noimage.png'),
                            image: NetworkImage(e),
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
