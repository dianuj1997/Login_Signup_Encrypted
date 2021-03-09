import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_2/main_page.dart';
import 'package:flutter_login_register_2/verify_phone.dart';
import 'package:flutter_login_register_2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:flutter_string_encryption/flutter_string_encryption.dart';


class RegForm extends StatefulWidget
{


  @override
  State<StatefulWidget> createState() {

    return _RegFormState();


  }

}
class _RegFormState extends State<RegForm>
{

  final _minpad=5.0;
  var _currentCat='Citizen';
  var _cat=['Citizen','Health Personal','Policy Maker'];
  final myController1 = TextEditingController();
  final myController5 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  final cryptor = new PlatformStringCryptor();


  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController1.dispose();
  //   super.dispose();
  // }
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
              getImageAsset(),

              Padding(
                  padding:EdgeInsets.only(top:_minpad,bottom: _minpad),
                  child:Text(
                    "Registration",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 40.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  )),

              Padding(
                  padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                  child:TextField(
                    controller: myController1,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'First Name & Last Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              // Padding(
              //     padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
              //     child:TextField(
              //       keyboardType: TextInputType.emailAddress,
              //       decoration: InputDecoration(
              //           labelText: 'Email',
              //           hintText: 'e.g.xyz@hotmail.com',
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(5.0))),
              //     )),
              Padding(
                  padding:EdgeInsets.only(top:_minpad,bottom: _minpad),

                  child:Row(children: <Widget>[

                    Expanded(
                      child:Container(
                      // child: Padding(
                          padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                          child:TextField(
                            controller: myController2,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'e.g.xyz@hotmail.com',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),),

                    Container(width: _minpad*2,),
                    Container(
                        width: _minpad*30,
                        // child:Expanded(
                            child:DropdownButton<String>(
                                hint: Text('Category'),
                                items:_cat.map((String value){
                                  return DropdownMenuItem<String>(
                                    value:value,
                                    child:Text(value),
                                  );
                                }
                                ).toList(),
                                value:_currentCat,
                                onChanged: (String newValueSelected)
                                {
                                  _onDroDownItemSelected(newValueSelected);
                                }

                            ))
                  ],)),
              Padding(
                  padding:EdgeInsets.only(top:_minpad,bottom: _minpad),

                  child:Row(children: <Widget>[

                    Expanded(
                      child:Container(
                          padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                          child:TextField(
                            controller: myController3,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: '(+Country Code)(Phone Number))',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),),

                    Container(width: _minpad*2,),
                    // Container(
                    //     width: _minpad*20,
                    //     child:
                        Expanded(
                          child:Container(
                              padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                              child:TextField(
                                controller: myController4,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Age',
                                    hintText: 'XX',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0))),
                              )),)
                  ],)),
              Padding(
                  padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                  child:TextField(
                    controller: myController5,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText:'only characters and numbers are allowed',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  )),

              Padding(
                  padding: EdgeInsets.only(top: _minpad,bottom: _minpad),
                    child:SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child:RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child:Text('Register'),
                          onPressed: ()  async{
                            //_read();


                            //Gneration of key
                            final String k1 = await cryptor.generateRandomKey();
                            final String k2 = await cryptor.generateRandomKey();
                            final String k3 = await cryptor.generateRandomKey();
                            final String k4 = await cryptor.generateRandomKey();
                            final String k5 = await cryptor.generateRandomKey();
                            final String k6 = await cryptor.generateRandomKey();
                            //Encryption
                            final String encrypted1 = await cryptor.encrypt(myController1.text, k1);
                            final String encrypted2 = await cryptor.encrypt(myController2.text, k2);
                            final String encrypted3 = await cryptor.encrypt(_currentCat, k3);
                            final String encrypted4 = await cryptor.encrypt(myController3.text, k4);
                            final String encrypted5 = await cryptor.encrypt(myController4.text, k5);
                            final String encrypted6 = await cryptor.encrypt(myController5.text, k6);
                            //Decryption
                            // final String F1 = await cryptor.decrypt(encrypted1, k1);
                            // final String F2 = await cryptor.decrypt(encrypted2, k2);
                            // final String F3 = await cryptor.decrypt(encrypted3, k3);
                            // final String F4 = await cryptor.decrypt(encrypted4, k4);
                            // final String F5 = await cryptor.decrypt(encrypted5, k5);
                            // final String F6 = await cryptor.decrypt(encrypted6, k6);

                            final String F1 = encrypted1;
                            final String F2 = encrypted2;
                            final String F3 = encrypted3;
                            final String F4 = encrypted4;
                            final String F5 = encrypted5;
                            final String F6 = encrypted6;


                            _write("\n"+"Name:"+F1+"\n"+"Email:"+F2+"\n"+"Category:"+F3+"\n"+"Phone#:"+F4+"\n"+"Age:"+F5+"\n"+"Password:"+F6+"\n");
                            bool x = await _getBoolValuesSF();

                            //debugPrint(myController1.text+"\n"+myController2.text+"\n"+myController3.text+"\n"+myController4.text+myController5.text);
                            if (1==0) {
                              //    if(data.india==0){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return LoginForm();
                                  }));
                            }
                            else {

                              Navigator.push(context,MaterialPageRoute(builder: (context)
                              {
                                return VerifyForm();
                              }
                              ));}
                          },
                          elevation: 20.0,
                        )),),
              Padding(
                  padding: EdgeInsets.only(top: _minpad,bottom: _minpad),

                      child:RaisedButton(
                        child:Text('Login'),
                        onPressed: ()
                        {
                          debugPrint("Login is pressed");
                          //  debugPrint('Captured data: ${x}');

                              {
                            Navigator.push(context,MaterialPageRoute(builder: (context)
                            {
                              return LoginForm();
                            }
                            ));
                          }



                        },
                        elevation: 20.0,
                      )),

            ],
          )
      ),
    );
  }


  Widget getImageAsset()
  {
    AssetImage assetImage=AssetImage('images/register_fig.png');
    Image image=Image(image:assetImage,width: 125.0,height:125.0,);
    return Container(child: image,margin: EdgeInsets.only(left:_minpad*10,right:_minpad*10,top:_minpad*10),);
  }
  void _onDroDownItemSelected(String newValueSelected)
  {
    setState(() {
      this._currentCat=newValueSelected;
    });
  }

}
Future<bool> _getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool boolValue = prefs.getBool('boolValue');
  return boolValue;
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
_write(String text) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/my_file.txt');
  await file.writeAsString(text);
  debugPrint("A file with new content,i.e. ${text} has been stored at ${directory.path}");
}
