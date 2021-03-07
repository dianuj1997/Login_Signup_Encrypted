import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_2/main_page.dart';


class VerifyForm extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _VerifyFormState();
  }

}
class _VerifyFormState extends State<VerifyForm>
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
                  padding:EdgeInsets.only(top:_minpad,bottom: _minpad*10),
                  child:Text(
                    "Phone Verification",
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
                        labelText: 'Enter OTP',
                        hintText: 'XXXXX',
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
                  padding: EdgeInsets.only(top: _minpad,bottom: _minpad),
                  child:Expanded(
                    child:SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child:RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child:Text('Verify'),
                          onPressed: ()
                          {
                            debugPrint("Verify is pressed");
                            Navigator.push(context,MaterialPageRoute(builder: (context)
                            {
                              return MainForm();
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


  Widget getImageAsset()
  {
    AssetImage assetImage=AssetImage('images/verify_fig.png');
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