import 'package:flutter/material.dart';
import 'package:flutter_tools_sample/generated/l10n.dart';

// Inspired by the about page in samarthagarwal flutter code:
// https://github.com/samarthagarwal/FlutterCalculator
class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => new _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR" || buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "÷" ||
        buttonText == "×" ||
        buttonText == "X") {
      if (operand == "+" ||
          operand == "-" ||
          operand == "÷" ||
          operand == "×") {
        num2 = double.parse(output);
        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "X" || operand == "×") {
          _output = (num1 * num2).toString();
        }
        if (operand == "/" || operand == "÷") {
          _output = (num1 / num2).toString();
        }
        num1 = 0.0;
        num2 = 0.0;
        output = _output;
      }
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already conatains a decimals");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X" || operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/" || operand == "÷") {
        _output = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "=";
    } else {
      if (operand == "=") {
        operand = "";
        _output = "";
      } else if (operand != "" && _output == "0") {
        _output = "";
      }
      _output = _output + buttonText;
    }

    print(_output);

    setState(() {
      double doubleVal = double.parse(_output);
      int intVal = doubleVal.toInt();
      double lowVal = doubleVal - intVal;
      if (lowVal > 0.0 && lowVal < 1.0) {
        output = double.parse(_output).toStringAsFixed(2);
      } else {
        output = double.parse(_output).toStringAsFixed(0);
      }
    });
  }

  Widget buildButton(String buttonText, Orientation orientation) {
    return Expanded(
      child: OutlineButton(
        padding:
            EdgeInsets.all(orientation == Orientation.portrait ? 24.0 : 16.0),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Builder(
              builder: (context) => Text(S.of(context).tools_my_calculator)),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return Container(
              child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.centerRight,
                  padding:
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                  child: Text(output,
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ))),
              Expanded(
                child: new Divider(),
              ),
              Column(children: [
                Row(children: [
                  buildButton("7", orientation),
                  buildButton("8", orientation),
                  buildButton("9", orientation),
                  buildButton("÷", orientation)
                ]),
                Row(children: [
                  buildButton("4", orientation),
                  buildButton("5", orientation),
                  buildButton("6", orientation),
                  buildButton("×", orientation)
                ]),
                Row(children: [
                  buildButton("1", orientation),
                  buildButton("2", orientation),
                  buildButton("3", orientation),
                  buildButton("-", orientation)
                ]),
                Row(children: [
                  buildButton("0", orientation),
                  buildButton("C", orientation),
                  buildButton("=", orientation),
                  buildButton("+", orientation)
                ]),
              ])
            ],
          ));
        }));
  }
}
