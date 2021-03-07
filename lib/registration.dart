import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_2/main_page.dart';
import 'package:flutter_login_register_2/verify_phone.dart';
import 'package:flutter_login_register_2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


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
                      child: Padding(
                          padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                          child:TextField(
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
                        child:Expanded(
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

                            )))
                  ],)),
              Padding(
                  padding:EdgeInsets.only(top:_minpad,bottom: _minpad),

                  child:Row(children: <Widget>[

                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                          child:TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: '(+Country Code)(Phone Number))',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),),

                    Container(width: _minpad*2,),
                    Container(
                        width: _minpad*20,
                        child:Expanded(
                          child:Padding(
                              padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                              child:TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Age',
                                    hintText: 'XX',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0))),
                              )),))
                  ],)),
              Padding(
                  padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                  child:TextField(
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
                  child:Expanded(
                    child:SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child:RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child:Text('Register'),
                          onPressed: ()  async{
                            _read();
                            bool x = await _getBoolValuesSF();

                            //debugPrint("Register is pressed: ${x} ");
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
                        )),)),
              Padding(
                  padding: EdgeInsets.only(top: _minpad,bottom: _minpad),
                  child:Expanded(
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
                      ))),

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
    debugPrint("A file has been read");
  } catch (e) {
    debugPrint("Couldn't read file");
  }
  return text;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}