
// ignore_for_file: use_build_context_synchronously
import 'package:coconut_do/core/enums/dialogue_state.dart';
import 'package:coconut_do/core/models/task.dart';
import 'package:flutter/material.dart';


class DialogueHelper {
  static bool _dialogOpen = false;

  static bool get isAnyDialogOpen => _dialogOpen;

  static String email = "";
  static String suggestions = "";

  static final _twoTextDialogFormKey = GlobalKey<FormState>();
  static final _singleTextDialogFormKey = GlobalKey<FormState>();

  static final firstTextController = TextEditingController();
  static final secondTextController = TextEditingController();

  static final singleTextController = TextEditingController();

  static void dispose() {
    firstTextController.dispose();
    secondTextController.dispose();
    singleTextController.dispose();
  }

  static Future<String?> addNewTask(BuildContext context) async{
    var res = await _singleTextConfirmation(
      context,
      title: "Add a new task",
      firstBoxHint: "Task to do",
      yesButton: "Add",
      cancelButton: "Cancel",
      enforceText: "Task can not be empty",
    );

    var contents = singleTextController.text;
    singleTextController.text = "";

    return res == DialogState.cancel ? null : contents;
  }

  static Future<DialogState> _singleTextConfirmation(
    BuildContext context,
    {String title = "",
    int firstTextLengthLimit = 50,
    String firstBoxHint = "",
    String enforceText = "",
    String yesButton = "",
    String cancelButton = "Cancel",
    Widget? middleWidget,
    bool allowOutsideDismissal = true,
    bool passwordField = false}
  ) async {
    _dialogOpen = true;
    var res = await showDialog<DialogState>(
      barrierDismissible: allowOutsideDismissal,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title, textAlign: TextAlign.left,),
          children: <Widget>[
            Form(
                key: _singleTextDialogFormKey,
                child:
                Container(
                  padding:const EdgeInsets.only(left: 0, right: 0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                      controller: singleTextController,
                      autofocus: true,
                      obscureText: passwordField,
                      maxLength: firstTextLengthLimit,
                      decoration: InputDecoration(
                        hintText: firstBoxHint
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return enforceText;
                        }
                        return null;
                      }
                    )),
                    SizedBox(height: middleWidget != null ? 16 : 0,),
                    middleWidget ?? Container(),
                    SizedBox(height: middleWidget != null ? 12 : 0,),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(height:36,
                          child:
                            TextButton(
                              onPressed: () => Navigator.pop(context, DialogState.cancel),
                              child: Text(cancelButton.toUpperCase(), style:TextStyle(fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor))),
                            ),
                          SizedBox(height:36,
                          child:
                            TextButton(
                            onPressed: () {
                              if (_singleTextDialogFormKey.currentState != null && _singleTextDialogFormKey.currentState!.validate()) {
                                Navigator.pop(context, DialogState.yes);
                              }
                            },
                            child: Text(yesButton.toUpperCase(), style:TextStyle(fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                          ))
                        ]
                    )),
                  ],
                ),
              ))
          ],
        );
      }
    );

    _dialogOpen = false;
    return Future.value(res ?? DialogState.cancel);
  }

  static Future<DialogState> _singleLabelConfirmation(
    BuildContext context,
    {String title = "",
    Widget? label,
    String? agreeButton,
    String? cancelButton,
    bool onlyShowOneButton = false}
  ) async {

    cancelButton ??= "Cancel";

    _dialogOpen = true;
    var res = await showDialog<DialogState>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title, textAlign: TextAlign.left,),
          children: <Widget>[
            Form(
                child:
                Container(
                  padding:const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(height: 15,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8),child:label),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          onlyShowOneButton ? Container() : SizedBox(height:36,
                          child:
                            TextButton(
                              onPressed: () => Navigator.pop(context, DialogState.cancel),
                              child: Text(cancelButton!.toUpperCase(), style:TextStyle(fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor))),
                            ),
                          SizedBox(height:36,
                          child:
                            TextButton(
                            onPressed: () => Navigator.pop(context, DialogState.yes),
                            child: Text(agreeButton!.toUpperCase(), style:TextStyle(fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                          ))
                        ]
                    )),
                  ],
                ),
              ))
          ],
        );
      }
    );

    _dialogOpen = false;
    return Future.value(res ?? DialogState.cancel);
  }
}