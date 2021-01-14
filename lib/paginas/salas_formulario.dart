import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/componentes/progress.dart';
import 'package:truco/componentes/dialog.dart';
import 'package:truco/componentes/input_text.dart';
import 'package:truco/componentes/button.dart';

class SalasFormulario extends StatefulWidget {
  @override
  _SalasFormularioState createState() => _SalasFormularioState();
}

class _SalasFormularioState extends State<SalasFormulario> {
  final _formKey = GlobalKey<FormState>();

  SalaFirebase _data;
  void initState() {
    super.initState();
    _data = SalaFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar sala'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputText(
                label: 'Nome da Sala',
                placeHolder: 'Digite o nome da sala.',
                isRequired: true,
                onSaved: (String value) {
                  _data.nomeSala = value;
                },
              ),
              Button(
                textButton: 'Gravar',
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _save(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _save(BuildContext context) async {
    ProgressDialog pr = await progressShow(context);
    try {
      _formKey.currentState.save();
      await _data.criar();
      await progressClose(pr);
      await showDialog(
        context: context,
        builder: (contextDialog) => SuccessDialog('Sala gravada com sucesso.'),
      );
      Navigator.pop(context, _data);
    } catch (e) {
      print(e);
      await progressClose(pr);
      await showDialog(
        context: context,
        builder: (contextDialog) => FailureDialog('Erro na gravação da sala!'),
      );
    }
  }
}
