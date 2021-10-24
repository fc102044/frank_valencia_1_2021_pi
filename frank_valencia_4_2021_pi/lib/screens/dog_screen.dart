import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frank_valencia_4_2021_pi/globals/globals.dart';
import 'package:frank_valencia_4_2021_pi/helper/constans.dart';
import 'package:frank_valencia_4_2021_pi/models/breed_Image.dart';
import 'package:frank_valencia_4_2021_pi/screens/show_Detail_Dogs.dart';
import 'package:http/http.dart' as http;
import 'package:frank_valencia_4_2021_pi/models/breed.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DogScreen extends StatefulWidget {
  final List<Breed> lstDog;
  DogScreen({required this.lstDog});
  @override
  _DogScreenState createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  List<Breed> _lstDog = [];
  bool _isFiltered = false;
  String _search = '';
  bool _showLoader = false;
  @override
  void initState() {
    super.initState();
    _lstDog = widget.lstDog;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gcolorBlue,
        centerTitle: true,
        title: Text('Razas'),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter, icon: Icon(Icons.filter_none))
              : IconButton(onPressed: _showFilter, icon: Icon(Icons.filter_alt))
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      children: _lstDog.map((e) {
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
                onTap: () {
                  _showDetails(e);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.breed,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
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

  void _removeFilter() {
    setState(() {
      _lstDog = widget.lstDog;
      _isFiltered = false;
    });
    getBody();
  }

  void _filter() {
    List<Breed> filteredList = [];
    if (_search.isEmpty) {
      setState(() {
        _lstDog = widget.lstDog;
      });
      return;
    }

    for (Breed breed in widget.lstDog) {
      if (breed.breed.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(breed);
      }
    }
    if (filteredList.length == 0) {
      Alert(
        context: context,
        type: AlertType.warning,
        title: 'Atención',
        desc: 'No se encontraron personajes con los criterios de busqueda',
        buttons: [
          DialogButton(
            child: Text(
              "ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: gcolorBlue,
          ),
        ],
      ).show();
    } else {
      setState(() {
        _lstDog = filteredList;
        _isFiltered = true;
      });
      Navigator.of(context).pop();
      _search = '';
    }
  }

  var filteredList = [];
  void _showFilter() {
    _lstDog = widget.lstDog;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Filtrar Personajes'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Escriba las primeras letras del personaje'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Criterio de búsqueda...',
                      labelText: 'Buscar',
                      suffixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    _search = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _filter();
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar')),
              TextButton(onPressed: () => _filter(), child: Text('Filtrar')),
            ],
          );
        });
  }

  void _showDetails(Breed e) async {
    changeLoader();
    if (!(await checkConection(context))) {
      changeLoader();
      return;
    }
    var url = Uri.parse('${Constans.apiUrlDog}/${e.breed}/images');
    http.Response response = await http.get(url);
    if (!(await statusResponse(context, response)))
      alertaWarning(
          context, 'Algo salio mal intenta de nuevo mas tarde', 'Atencion');

    List<String> imagebreeds = [];
    if (response.statusCode == 200) {
      Map mapData = await json.decode(response.body);
      var data = mapData["message"];
      for (String key in data) {
        imagebreeds.add(key);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowDetailsDog(imagebreeds: imagebreeds),
      ),
    );
    changeLoader();
  }

  void changeLoader() {
    setState(() {
      _showLoader = !_showLoader;
    });
  }
}
