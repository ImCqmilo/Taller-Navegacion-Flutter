import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  String textoTipado = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  textoTipado = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
          ),
          Text(
            textoTipado,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          )
        ],
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
