import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Color gcolorBlue = Color(0xFF0053a6);

Future<bool> checkConection(BuildContext context) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    alertaWarning(context, 'Verifica que estes conectado a internet.', 'Error');
    return false;
  } else {
    return true;
  }
}

Future<bool> statusResponse(BuildContext context, response) async {
  if (response.statusCode >= 400) {
    alertaWarning(context,
        "Se ha producido un error, intentelo de nuevo mas tarde", 'Error');
    return false;
  } else {
    return true;
  }
}

// Alert Warning
Future<bool> alertaWarning(
    BuildContext context, String mensaje, String titulo) async {
  bool resp = false;
  await Alert(
    context: context,
    type: AlertType.warning,
    title: titulo,
    desc: mensaje,
    buttons: [
      DialogButton(
        child: Text(
          "SI",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          resp = true;
        },
        color: gcolorBlue,
      ),
    ],
  ).show();
  return resp;
}
