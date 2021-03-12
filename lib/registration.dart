import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_2/main_page.dart';
import 'package:flutter_login_register_2/verify_phone.dart';
import 'package:flutter_login_register_2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
final imgUrl =
    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/csv/dummy.csv";

var dio = Dio();

class RegForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegFormState();
  }
}

class _RegFormState extends State<RegForm> {
  final _minpad = 5.0;
  var _currentCat = 'Gender';
  // var _cat = ['Citizen', 'Health Personal', 'Policy Maker'];
  var _cat = ['Gender', 'Male', 'Female'];
  final myController1 = TextEditingController();
  final myController5 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  final cryptor = new PlatformStringCryptor();

  signup(username, password, contact_num, email, age, gender) async {
    var url = Uri.http('13.229.160.192:5000', '/register');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "password": password,
          "contact_num": contact_num,
          "email": email,
          "age": age,
          "gender": gender
        }));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var itemCount = jsonResponse['status'];
      if (itemCount != 200) {
        print("username already exist");
        return 1;
      } else {
        print('registeration done. : $itemCount.');
        return 0;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // void saving_keys(
  //     k_username, k_password, k_contact_num, k_email, k_age, k_gender) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userData = json.encode({
  //     "k_username": k_username,
  //     "k_password": k_password,
  //     "k_contact_num": k_contact_num,
  //     "k_email": k_email,
  //     "k_age": k_age,
  //     "k_gender": k_gender,
  //   });
  //   prefs.setString("userData", userData);
  // }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController1.dispose();
  //   super.dispose();
  // }
  //************************************************************************************************
  void getPermission() async {
    print("getPermission");
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  Future download2(Dio dio, String url, String savePath, String dataa) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
//      String csv = const ListToCsvConverter().convert(rows);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      file.writeAsString(dataa);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
  //***************************************************************
  @override
  Widget build(BuildContext context) {
    //TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('COVID Tracker'),
      ),
      body: Container(
          margin: EdgeInsets.all(_minpad * 2),
          child: Column(
            children: <Widget>[
              getImageAsset(),

              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: Text(
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
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: TextField(
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
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            // child: Padding(
                            padding:
                                EdgeInsets.only(top: _minpad, bottom: _minpad),
                            child: TextField(
                              controller: myController2,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'e.g.xyz@hotmail.com',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            )),
                      ),
                      Container(
                        width: _minpad * 2,
                      ),
                      Container(
                          width: _minpad * 30,
                          // child:Expanded(
                          child: DropdownButton<String>(
                              hint: Text('Category'),
                              items: _cat.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentCat,
                              onChanged: (String newValueSelected) {
                                _onDroDownItemSelected(newValueSelected);
                              }))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            padding:
                                EdgeInsets.only(top: _minpad, bottom: _minpad),
                            child: TextField(
                              controller: myController3,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  hintText: '(+Country Code)(Phone Number))',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            )),
                      ),

                      Container(
                        width: _minpad * 2,
                      ),
                      // Container(
                      //     width: _minpad*20,
                      //     child:
                      Expanded(
                        child: Container(
                            padding:
                                EdgeInsets.only(top: _minpad, bottom: _minpad),
                            child: TextField(
                              controller: myController4,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Age',
                                  hintText: 'XX',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            )),
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: TextField(
                    controller: myController5,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: 'only characters and numbers are allowed',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),

              Padding(
                padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                child: SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Register'),
                      onPressed: () async {
                        //_read();

                        //Gneration of key
                        final String k1 = await cryptor.generateRandomKey();
                        final String k2 = await cryptor.generateRandomKey();
                        final String k3 = await cryptor.generateRandomKey();
                        final String k4 = await cryptor.generateRandomKey();
                        final String k5 = await cryptor.generateRandomKey();
                        final String k6 = await cryptor.generateRandomKey();
                        //Encryption
                        final String encrypted1 =
                            await cryptor.encrypt(myController1.text, k1);
                        final String encrypted2 =
                            await cryptor.encrypt(myController2.text, k2);
                        final String encrypted3 =
                            await cryptor.encrypt(_currentCat, k3);
                        final String encrypted4 =
                            await cryptor.encrypt(myController3.text, k4);
                        final String encrypted5 =
                            await cryptor.encrypt(myController4.text, k5);
                        final String encrypted6 =
                            await cryptor.encrypt(myController5.text, k6);
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

                        String currentdat="\n" +
                            "Name:" +
                            F1 +
                            "\n" +
                            "Email:" +
                            F2 +
                            "\n" +
                            "Category:" +
                            F3 +
                            "\n" +
                            "Phone#:" +
                            F4 +
                            "\n" +
                            "Age:" +
                            F5 +
                            "\n" +
                            "Password:" +
                            F6 +
                            "\n";
//***********************************************************************************************************************************8
                        String path =
                        await ExtStorage.getExternalStoragePublicDirectory(
                            ExtStorage.DIRECTORY_DOWNLOADS);
                        //String fullPath = tempDir.path + "/boo2.pdf'";
                        String fullPath = "$path/datSingup.csv";
                        print('full path ${fullPath}');

                        download2(dio, imgUrl, fullPath,currentdat);
//*********************************************************************************************************************************************
                        _write(currentdat);
                        bool x = await _getBoolValuesSF();
                        // saving_keys(F1, F6, F4, F2, F5, F3);
                        final signup_response =
                            await signup(F1, F6, F4, F2, F5, F3);

                        if (signup_response == 0) {
                          print("signup");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginForm();
                          }));
                        } else {
                          print("signup not successfull!");
                        }
                        //debugPrint(myController1.text+"\n"+myController2.text+"\n"+myController3.text+"\n"+myController4.text+myController5.text);
                        // if (1 == 0) {
                        //   //    if(data.india==0){
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) {
                        //     return LoginForm();
                        //   }));
                        // } else {
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) {
                        //     return VerifyForm();
                        //   }));
                        // }
                      },
                      elevation: 20.0,
                    )),
              ),
              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: RaisedButton(
                    child: Text('Login'),
                    onPressed: () {
                      debugPrint("Login is pressed");
                      //  debugPrint('Captured data: ${x}');

                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginForm();
                        }));
                      }
                    },
                    elevation: 20.0,
                  )),
            ],
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/register_fig.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(
          left: _minpad * 10, right: _minpad * 10, top: _minpad * 10),
    );
  }

  void _onDroDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentCat = newValueSelected;
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
  debugPrint(
      "A file with new content,i.e. ${text} has been stored at ${directory.path}");
}
