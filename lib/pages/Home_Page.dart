import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<void> _checkBiometric() async {
    bool canCheckBiometric;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listOfBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if(isAuthorized){
        _authorizedOrNot = "Authorized";
      }
      else{
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("begin"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Can we check Biometric : $_canCheckBiometric"),
            RaisedButton(
              onPressed: _checkBiometric,
              child: Text("Check Biometric"),
              color: Colors.red,
              colorBrightness: Brightness.light,
            ),
            Text("List of Biometric: ${_availableBiometricTypes.toString()}"),
            RaisedButton(
              onPressed: _getListOfBiometricTypes,
              child: Text("List of Biometric Types"),
              color: Colors.red,
              colorBrightness: Brightness.light,
            ),
            Text("Authorized : $_authorizedOrNot"),
            RaisedButton(
              onPressed: _authorizeNow,
              child: Text("Authorize Now"),
              color: Colors.red,
              colorBrightness: Brightness.light,
            ),
          ],
        ),
      ),
    );
  }
}
