import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  String _info = "Digite suas informações !";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    _weightController.text = "";
    _heightController.text = "";

    setState(() {
      _formKey = GlobalKey<FormState>();
      _info = "Digite suas Informações";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        _info = " Magreza: ${imc.toStringAsPrecision(4)}";
      }else if (imc > 18.5 && imc < 24.9) {
        _info = " Normal: ${imc.toStringAsPrecision(4)}";
      }else if(imc > 25 && imc < 29.9) {
        _info = " Obesidade I: ${imc.toStringAsPrecision(4)}";
      }else if(imc > 30 && imc < 39.0) {
        _info = " Obesidade II: ${imc.toStringAsPrecision(4)}";
      }else if(imc > 40) {
        _info = " Obesidade III: ${imc.toStringAsPrecision(4)}";
      }else {
        _info = "Digite suas Informações";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora Imc",
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              _reset();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 150.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 20.0),
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Colors.green,
                  style: TextStyle(color: Colors.green, fontSize: 30.0),
                  controller: _weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Digite o seu Peso !";
                    }
                    ;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 20.0),
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Colors.green,
                  style: TextStyle(color: Colors.green, fontSize: 30.0),
                  controller: _heightController,
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Digite a sua Altura !";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Container(
                    height: 55.0,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                    ),
                  ),
                ),
                Text(
                  _info,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
