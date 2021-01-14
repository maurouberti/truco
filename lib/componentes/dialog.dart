import 'package:flutter/material.dart';

class Dialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonCloseText;
  final String buttonConfirmText;
  final IconData icon;
  final Color colorIcon;
  final Function onClickConfirm;

  Dialog(
      {this.title = "",
      this.message = "",
      this.icon,
      this.colorIcon = Colors.black,
      this.buttonCloseText = 'Ok',
      this.buttonConfirmText = '',
      this.onClickConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        child: Text(title),
        visible: title.isNotEmpty,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Icon(
                icon,
                size: 64,
                color: colorIcon,
              ),
            ),
            visible: icon != null,
          ),
          Visibility(
            visible: message.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(buttonCloseText),
          onPressed: () => Navigator.pop(context),
        ),
        Visibility(
          visible: buttonConfirmText != '',
          child: FlatButton(
            child: Text(buttonConfirmText),
            onPressed: () {
              Navigator.pop(context);
              try {
                onClickConfirm();
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (contextDialog) => FailureDialog('Erro'),
                );
              }
            },
          ),
        )
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  SuccessDialog(
    this.message, {
    this.title = 'Sucesso',
    this.icon = Icons.done,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      title: title,
      message: message,
      icon: icon,
      colorIcon: Colors.green,
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  FailureDialog(
    this.message, {
    this.title = 'Falha',
    this.icon = Icons.warning,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      title: title,
      message: message,
      icon: icon,
      colorIcon: Colors.red,
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final String message;
  final Function onClickConfirm;
  final String buttonCloseText;
  final String buttonConfirmText;

  ConfirmDialog({
    this.message,
    this.onClickConfirm,
    this.buttonCloseText = 'Não',
    this.buttonConfirmText = 'Sim',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      title: 'Atenção',
      message: message,
      buttonCloseText: buttonCloseText,
      buttonConfirmText: buttonConfirmText,
      onClickConfirm: onClickConfirm,
    );
  }
}
