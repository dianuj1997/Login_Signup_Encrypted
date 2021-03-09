import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_2/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MainForm extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() {
    return _MainFormState();
  }

}


class _MainFormState extends State<MainForm>
{
  final _minpad=5.0;


  @override
  Widget build(BuildContext context) {
    //TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        title:Text('COVID Tracker'),
      ),
      body:Container(
          margin:EdgeInsets.all(_minpad*2) ,
          child:Column(
            children: <Widget>[


              Padding(
                  padding: EdgeInsets.only(top: _minpad,bottom: _minpad),
                  // child:Expanded(
                      child:RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child:Text('Logout'),
                        onPressed: ()
                         {
                           _write("");
                           _read();
                           deleteFile();
                           // _read();
                          _addBoolToSF();
                          //prefs.remove('counter');
                          //debugPrint('Logout is Pressed');
                          Navigator.push(context,MaterialPageRoute(builder: (context)
                          {

                            return RegForm();
                          }
                          ));
                        },
                        elevation: 20.0,
                      )),

            ],
          )
      ),
    );
  }



}

void _addBoolToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('boolValue', true);
}

_write(String text) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/my_file.txt');
  await file.writeAsString(text);
}
Future<String> _read() async {
  String text;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    text = await file.readAsString();
    debugPrint("A file has been read at ${directory.path}");
  } catch (e) {
    debugPrint("Couldn't read file");
  }
  return text;
}
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
Future<int> deleteFile() async {
  String text;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    text = await file.readAsString();
    await file.delete();
    debugPrint("A file just got deleted");
  } catch (e) {
    return 0;
  }
}
