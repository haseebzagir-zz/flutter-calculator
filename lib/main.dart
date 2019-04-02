import 'package:flutter/material.dart';
import 'About.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: new MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<MyHomePage> {

  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  double _result = 0.0;
  String operand = "";
  String prevOperand = "";
  String screenText = "";
  List<double> _numbersList = new List();
  List<String> resultList = new List();
  List<int> plusIndexes = new List();
  bool _isResult = false;

  buttonPressed(String buttonText) {

    if (buttonText == "C") {

      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      screenText = "";
      _numbersList = [];
      resultList = [];
      _result = 0.0;

    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/" ) {

      if (_isResult == true)
      {
        print("first here in first if");
      num1 = _result;
      _numbersList.add(num1);
      resultList.add(num1.toString());
        print("resultlist $resultList");
      print("numlist $_numbersList");
      _isResult = false;
    }else
    {
      print("first here in first else");
        num1 = double.parse(output);
        screenText = screenText + _output;
        _numbersList.add(num1);
      resultList.add(num1.toString());
      print("resultlist $resultList");
      }
      print("$_numbersList");

      if (_result == 0.0) {
        _result += _numbersList[_numbersList.length-1];
        print("* here inside if :$_result");
      }else {
        if(_numbersList.length > 1) {
          if (prevOperand == "+") {

            _result += _numbersList[_numbersList.length-1];
            print("* special case :$_result");
          }
          else if (prevOperand == "-"){

            _result -= _numbersList[_numbersList.length-1];
            print("* special case :$_result");
          }else if (prevOperand == "*"){

            _result *= _numbersList[_numbersList.length-1];
            print("* special case :$_result");
          }else {

            _result /= _numbersList[_numbersList.length-1];
            print("* special case :$_result");
          }
        }
      }

      num1 = _result;
      print("numbers List : ${_numbersList}, sum = $_result");
      operand = buttonText ;
      prevOperand = operand;
      resultList.add(operand);
      var plusindexes = resultList.indexOf('+');
      plusIndexes.add(plusindexes);
      print("resultlist $resultList");
      screenText = screenText + operand;
      print("operand $operand");
      _output = "0";

    } else if(buttonText == ".") {
      if(_output.contains(".")){
        print("Already contains");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {

       _numbersList.add(double.parse(output));
      num2 = _numbersList[_numbersList.length-1];
       resultList.add(num2.toString());
       print("resultlist $resultList");
      var divindexes = resultList.indexOf('/');
       var multindexes = resultList.indexOf('*');
       var minusindexes = resultList.indexOf('-');
       var plusindexes = resultList.indexOf('+');
       print("div $divindexes mult $multindexes minus $minusindexes plus $plusindexes plusindex array $plusIndexes");
      switch(operand) {
        case "+" :
          _output = (num1 + num2).toString();
          break;
        case "-" :
          _output = (num1 - num2).toString();
          break;
        case "*" :
          _output = (num1 * num2).toString();
          break;
        case "/" :
          _output = (num1 / num2).toString();
          break;

      }

      print("num1 $num1 num2 $num2 output $_output" );

      screenText = "";
      _numbersList = [];
      resultList = [];
      _result = double.parse(_output);
      _isResult = true;

//      num2 = 0;

    } else {
      _output = _output + buttonText;
    }

    print("output $_output");

    setState(() {
      output = double.parse(_output).toStringAsFixed(1);
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        appBar: new AppBar(
          backgroundColor: Colors.black12,
          title: Text("Calc"),
        ),
      drawer: new Drawer(child: ListView(children: <Widget>[
        new UserAccountsDrawerHeader(accountName: new Text("haseeb@gmail"), accountEmail: new Text("haseeb@gmail"),currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage('http://i.pravatar.cc/'),
        ),),ListTile(title: Text("About us"),onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new AboutPage()));
        },)
      ],),)

      ,
      body: Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[Text(

        "$output",
        style:  TextStyle(fontSize: 60.0,fontFamily: 'Sniglet',color: Colors.black))]
              ),
      ),Expanded(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[Text(

                "$screenText",
                style:  TextStyle(fontSize: 30.0,fontFamily: 'Sniglet',color: Colors.black))]
        ),
      ),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _button("7", ),// using custom widget _button
                _button("8", ),
                _button("9", ),
                _operationButton("/",Colors.deepPurple),
              ],
            ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _button("4"),// using custom widget _button
                _button("5", ),
                _button("6", ),
                _operationButton("*",Colors.redAccent),
              ],
            ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _button("1", ),// using custom widget _button
                _button("2", ),
                _button("3", ),
                _operationButton("-",Colors.lightBlueAccent),
              ],
            ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _button("C"),// using custom widget _button
                _button("0"),
                _button("="),
                _operationButton("+",Colors.deepOrangeAccent),
              ],
            ),
        ),

      ],
    ),
    ),
    );
  }

// void _clear() {
//   setState(() {
//     ansStr = ansStr + "0";
//     ans = ans + "0";
//   });
// }
//
//  void _zero() {
//    setState(() {
//      ansStr = ansStr + "0";
//      ans = ans + "0";
//    });
//  }
//  void _one() {
//    setState(() {
//      ansStr = ansStr + "1";
//      ans = ans + "1";
//    });
//  }
//
//  void _two() {
//    setState(() {
//      ansStr = ansStr + "2";
//      ans = ans + "2";
//    });
//  }
//
//  void _three() {
//
//    setState(() {
//      ansStr = "3";
//    });
//  }
//
//  void _four() {
//    setState(() {
//      ansStr = "4";
//    });
//  }
//
//  void _five() {
//    setState(() {
//      ansStr = "5";
//    });
//  }
//
//  void _six() {
//    setState(() {
//      ansStr = "6";
//    });
//  }
//
//  void _seven() {
//    setState(() {
//      ansStr = "7";
//    });
//  }
//
//  void _eight() {
//    setState(() {
//      ansStr = "8";
//    });
//  }
//
//  void _nine() {
//    setState(() {
//      ansStr = "9";
//    });
//  }
//  void _mult() {
//    setState(() {
//      ansStr = "x";
//    });
//  }
//  void _div() {
//    setState(() {
//      ansStr = "/";
//    });
//  }
//
//  void _plus() {
//    if(isFirstTime == true) {
//      var myInt = int.parse(ans);
//      assert(myInt is int);
//      temp = myInt;
//      setState(() {
//        ansStr = "$temp";
//      });
//      ans = "";
//      isFirstTime = false;
//    } else {
//      var myInt = int.parse(ans);
//      assert(myInt is int);
//      temp = temp + myInt;
//      ans = "";
//      setState(() {
//        ansStr = "$temp";
//      });
//    }
//  }
//
//  void _minus() {
//    setState(() {
//      ansStr = "-";
//    });
//  }
//
//  void _disp() {
//    setState(() {
//      ansStr = "$temp";
//    });
//  }




  Widget _button (String number){ // Creating a method of return type Widget with number and function f as a parameter
    return Expanded(
      child: FlatButton(
        child: Text(number,
            style:  TextStyle(fontSize: 30.0,fontFamily: 'Sniglet',color: Colors.black)),
        onPressed: () => {
          buttonPressed(number)
        },
      ),
    );
  }


  Widget _operationButton (String operation,Color color){// Creating a method of return type Widget with number and function f as a parameter
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
        child: RaisedButton(
          elevation: 10.0,
          shape: CircleBorder(side: BorderSide(color: color)),
          color: color,
          child: Text(operation,
              style:  TextStyle(fontSize: 30.0,fontFamily: 'Sniglet',color: Colors.white)),
          onPressed: () => {
      buttonPressed(operation)
      },
        ),
      ),
    );
  }
}