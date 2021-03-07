import 'package:flutter/material.dart';
import 'package:flutter_login_register_2/main.dart';

class ResetForm extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _ResetFormState();
  }

}
class _ResetFormState extends State<ResetForm> {
  final _minpad = 5.0;


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

              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad * 10),
                  child: Text(
                    "Reset Password",
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
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Enter New Password',
                        hintText: 'only characters and numbers are allowed',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
                  child:TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Enter New Password Again',
                        hintText: 'only characters and numbers are allowed',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              // Padding(
              //     padding:EdgeInsets.only(top:_minpad,bottom: _minpad),
              //
              //     child:Row(children: <Widget>[
              //
              //       Expanded(
              //         child: Padding(
              //             padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
              //             child:TextField(
              //               keyboardType: TextInputType.phone,
              //               decoration: InputDecoration(
              //                   labelText: 'Phone Number',
              //                   hintText: '(+Country Code)(Phone Number))',
              //                   border: OutlineInputBorder(
              //                       borderRadius: BorderRadius.circular(5.0))),
              //             )),),
              //
              //       Container(width: _minpad*5,),
              //       Expanded(
              //           child:DropdownButton<String>(
              //               hint: Text('Category'),
              //               items:_cat.map((String value){
              //                 return DropdownMenuItem<String>(
              //                   value:value,
              //                   child:Text(value),
              //                 );
              //               }
              //               ).toList(),
              //               value:_currentCat,
              //               onChanged: (String newValueSelected)
              //               {
              //                 _onDroDownItemSelected(newValueSelected);
              //               }
              //
              //           ))
              //     ],)),
              // Padding(
              //     padding: EdgeInsets.only(top:_minpad,bottom: _minpad),
              //     child:TextField(
              //       keyboardType: TextInputType.name,
              //       decoration: InputDecoration(
              //           labelText: 'New Password',
              //           hintText:'only characters and numbers are allowed',
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(5.0)
              //           )
              //       ),
              //     )),

              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: Expanded(
                    child: SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: RaisedButton(
                          color: Theme
                              .of(context)
                              .primaryColorDark,
                          textColor: Theme
                              .of(context)
                              .primaryColorLight,
                          child: Text('Reset'),
                          onPressed: () {
                            debugPrint("Reset is pressed");
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) {
                              return LoginForm();
                            }
                            ));
                          },
                          elevation: 20.0,
                        )),)),
              //

            ],
          )
      ),
    );
  }
}