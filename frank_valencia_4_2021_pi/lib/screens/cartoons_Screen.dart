import 'package:flutter/material.dart';
import 'package:frank_valencia_4_2021_pi/globals/globals.dart';
import 'package:frank_valencia_4_2021_pi/models/cartoon.dart';
import 'package:frank_valencia_4_2021_pi/screens/details_Cartoon_Screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartoonScreen extends StatefulWidget {
  final List<Cartoon> lstCartoon;
  CartoonScreen({required this.lstCartoon});
  @override
  _CartoonScreenState createState() => _CartoonScreenState();
}

class _CartoonScreenState extends State<CartoonScreen> {
  List<Cartoon> _lstCartoons = [];
  bool _isFiltered = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _lstCartoons = widget.lstCartoon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gcolorBlue,
        centerTitle: true,
        title: Text('Personajes'),
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
      children: _lstCartoons.map((e) {
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
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                            placeholder: AssetImage('assets/noimage.png'),
                            image: NetworkImage(e.img),
                            height: 300,
                            width: 200,
                            fit: BoxFit.cover),
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.name,
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

  void _showDetails(Cartoon cartoon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsCartoonScreen(cartoon: cartoon),
      ),
    );
  }

  void _removeFilter() {
    setState(() {
      _lstCartoons = widget.lstCartoon;
      _isFiltered = false;
    });
    getBody();
  }

  void _filter() {
    if (_search.isEmpty) {
      setState(() {
        _lstCartoons = widget.lstCartoon;
      });
      return;
    }

    List<Cartoon> filteredList = [];
    for (var cartoon in widget.lstCartoon) {
      if (cartoon.name.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(cartoon);
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
        _lstCartoons = filteredList;
        _isFiltered = true;
      });
      Navigator.of(context).pop();
      _search = '';
    }
  }

  void _showFilter() {
    _lstCartoons = widget.lstCartoon;
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
}
