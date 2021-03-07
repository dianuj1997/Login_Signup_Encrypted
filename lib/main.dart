import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_login_register_2/registration.dart';
import 'package:flutter_login_register_2/main_page.dart';
import 'package:flutter_login_register_2/forgot_email.dart';
void main()
{
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title:'Login',
        home: LoginForm(),
        theme: ThemeData(
            primaryColor: Colors.indigoAccent,
            accentColor: Colors.indigoAccent
        ),
      )
  );
}

class LoginForm extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }

}
class _LoginFormState extends State<LoginForm>
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
              getImageAsset(),
              Padding(
                  padding:EdgeInsets.only(top:_minpad,bottom: _minpad*10),
                  child:Text(
                    "Login",
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'e.g. xyz@hotmail.com',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                  child:TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Password',
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
                          child:Text('Login'),
                          onPressed: ()
                          {
                            debugPrint("Login is pressed");
                            Navigator.push(context,MaterialPageRoute(builder: (context)
                            {
                              return MainForm();
                            }
                            ));

                          },
                          elevation: 20.0,
                        )),)),
              Padding(
                  padding: EdgeInsets.only(top: _minpad,bottom: _minpad),
                  child:Expanded(
                      child:RaisedButton(
                        child:Text('Signup'),
                        onPressed: ()
                        {
                          debugPrint("Signup is pressed");
                          Navigator.push(context,MaterialPageRoute(builder: (context)
                          {
                            return RegForm();
                          }
                          ));
                        },
                        elevation: 20.0,
                      ))),
              Padding(
                padding:EdgeInsets.only(top: _minpad,bottom: _minpad),
                child: TextButton(
                    child: Text('Forgot Password?'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) {
                        return ForgotForm();
                      }
                      ));
                    }
                ),

                // Text('Forgot Password?'),
              )
            ],
          )
      ),
    );
  }


  Widget getImageAsset()
  {
    AssetImage assetImage=AssetImage('images/login_fig.jpg');
    Image image=Image(image:assetImage,width: 125.0,height:125.0,);
    return Container(child: image,margin: EdgeInsets.only(left:_minpad*10,right:_minpad*10,top:_minpad*10),);
  }
}
