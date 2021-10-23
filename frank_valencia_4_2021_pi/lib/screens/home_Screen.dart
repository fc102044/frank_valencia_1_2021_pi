import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frank_valencia_4_2021_pi/helper/constans.dart';
import 'package:frank_valencia_4_2021_pi/models/cartoon.dart';
import 'package:frank_valencia_4_2021_pi/screens/cartoons_Screen.dart';
import 'package:http/http.dart' as http;

import 'package:frank_valencia_4_2021_pi/globals/globals.dart';
import 'package:frank_valencia_4_2021_pi/globals/loader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gcolorBlue,
        centerTitle: true,
        title: Text('Home'),
        actions: <Widget>[],
      ),
      body: Stack(children: <Widget>[
        _getBody(),
        _showLoader
            ? LoaderComponent(text: 'Por favor espere...')
            : Container(),
      ]),
    );
  }

  Widget _getBody() {
    return InkWell(
      onTap: () => _getCartoons(),
      child: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('assets/noimage.png'),
                  image: AssetImage('assets/cartoon1.png'),
                  height: 250,
                  width: 300,
                  fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }

  void _getCartoons() async {
    changeLoader();
    if (!(await checkConection(context))) {
      changeLoader();
      return;
    }

    var url = Uri.parse(Constans.apiUrl);
    http.Response response = await http.get(url);
    if (!(await statusResponse(context, response)))
      alertaWarning(
          context, 'Algo salio mal intenta de nuevo mas tarde', 'Atencion');

    String body = response.body;
    var decodedJson = jsonDecode(body);
    List<Cartoon> lstcartoon =
        List<Cartoon>.from(decodedJson.map((model) => Cartoon.fromJson(model)));
    changeLoader();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartoonScreen(lstCartoon: lstcartoon),
      ),
    );
  }

  void changeLoader() {
    setState(() {
      _showLoader = !_showLoader;
    });
  }
}
