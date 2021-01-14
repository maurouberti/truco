import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truco/componentes/progress.dart';
import 'package:truco/componentes/dialog.dart';
import 'package:truco/dados/sala_firebase.dart';
import 'package:truco/paginas/jogo/jogo_page.dart';

class SalasLista extends StatefulWidget {
  @override
  _SalasListaState createState() => _SalasListaState();
}

class _SalasListaState extends State<SalasLista> {
  @override
  Widget build(BuildContext context) {
    CollectionReference salas = FirebaseFirestore.instance.collection('salas');

    return StreamBuilder(
      stream: salas.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar as salas.'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            SalaFirebase item = SalaFirebase.fromDocument(document);
            return Column(
              children: [
                ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => JogoPage(
                                salaId: document.id,
                              ),
                            ),
                          )
                          .then((value) => setState(() {}));
                    },
                    leading: Icon(item.jogador1 != null && item.jogador2 != null
                        ? Icons.people
                        : item.jogador1 != null || item.jogador2 != null
                            ? Icons.person
                            : Icons.open_in_browser),
                    title: Row(
                      children: [
                        Expanded(child: Text(item.nomeSala)),
                      ],
                    ),
                    trailing: Visibility(
                      visible: true,
                      //visible: item.jogador1 == null && item.jogador2 == null,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (contextDialog) => ConfirmDialog(
                              message: 'Confirma a exclusão?',
                              onClickConfirm: () async {
                                ProgressDialog pr = await progressShow(context);
                                try {
                                  await item.excluir();
                                  await progressClose(pr);
                                } catch (e) {
                                  await progressClose(pr);
                                  await showDialog(
                                    context: context,
                                    builder: (contextDialog) =>
                                        FailureDialog('Erro ao excluir sala!'),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    )),
                SizedBox(height: 8, child: Divider(color: Colors.grey)),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
