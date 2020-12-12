import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Cet Calculator',
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double eFontSize = 38.0;
  double rFontSize = 48.0;

  void buttonPressed(String btnText) {
    setState(() {
      if (btnText == "C") {
        equation = "0";
        result = "0";
        eFontSize = 38.0;
        rFontSize = 48.0;
      } else if (btnText == "⌫") {
        eFontSize = 48.0;
        rFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == "=") {
        eFontSize = 38.0;
        rFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        eFontSize = 48.0;
        rFontSize = 38.0;
        if (equation == "0") {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Calculator'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  equation,
                  style: TextStyle(fontSize: eFontSize),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Text(
                  result,
                  style: TextStyle(fontSize: rFontSize),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Divider(
                height: 5,
                color: Colors.cyan,
              ),
            ),
            Row(
              children: [
                buildContainerButton('C', 0.50, Colors.redAccent),
                buildContainerButton('⌫', 0.25, Colors.cyan),
                buildContainerButton('=', 0.25, Colors.cyan),
              ],
            ),
            Row(
              children: [
                buildContainerButton('7', 0.25, Colors.cyan[200]),
                buildContainerButton('8', 0.25, Colors.cyan[200]),
                buildContainerButton('9', 0.25, Colors.cyan[200]),
                buildContainerButton('+', 0.25, Colors.cyan),
              ],
            ),
            Row(
              children: [
                buildContainerButton('4', 0.25, Colors.cyan[200]),
                buildContainerButton('5', 0.25, Colors.cyan[200]),
                buildContainerButton('6', 0.25, Colors.cyan[200]),
                buildContainerButton('-', 0.25, Colors.cyan),
              ],
            ),
            Row(
              children: [
                buildContainerButton('1', 0.25, Colors.cyan[200]),
                buildContainerButton('2', 0.25, Colors.cyan[200]),
                buildContainerButton('3', 0.25, Colors.cyan[200]),
                buildContainerButton('×', 0.25, Colors.cyan),
              ],
            ),
            Row(
              children: [
                buildContainerButton('.', 0.25, Colors.cyan),
                buildContainerButton('0', 0.25, Colors.cyan[200]),
                buildContainerButton('00', 0.25, Colors.cyan[200]),
                buildContainerButton(' ÷', 0.25, Colors.cyan),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerButton(String btnText, double width, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: 80,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            width: 1,
            color: Colors.black87,
            style: BorderStyle.solid,
          ),
        ),
        color: color,
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(btnText),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
