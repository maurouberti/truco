import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

Future<ProgressDialog> progressShow(BuildContext context) async {
  final ProgressDialog pr = ProgressDialog(
    context,
    type: ProgressDialogType.Download,
    isDismissible: false,
    showLogs: false,
  );
  pr.style(
    message: 'Aguarde',
  );
  await pr.show();
  return pr;
}

void progressCursor(ProgressDialog pr, int received, int total,
    {String message = 'Aguarde...'}) {
  pr.update(
    progress: ((received / total) * 100).truncate().toDouble(),
    message: message,
    progressWidget: Container(
        padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
    maxProgress: 100,
    progressTextStyle: TextStyle(
        color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
  );
}

Future progressClose(ProgressDialog pr) async {
  await pr.hide();
}
