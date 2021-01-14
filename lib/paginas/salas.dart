import 'package:flutter/material.dart';
import 'package:truco/componentes/button_bottom.dart';
import 'package:truco/paginas/salas_lista.dart';
import 'package:truco/paginas/salas_formulario.dart';

class Salas extends StatefulWidget {
  @override
  _SalasState createState() => _SalasState();
}

class _SalasState extends State<Salas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salas de truco'),
      ),
      body: Center(
        child: SalasLista(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 64.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonBottom(
                label: "Criar sala",
                icon: Icons.add_circle,
                onClick: () async {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => SalasFormulario(),
                        ),
                      )
                      .then((value) => setState(() {}));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
