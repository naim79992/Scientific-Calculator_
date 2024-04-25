import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _outputHistory = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _outputHistory = "";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "x") {
      num1 = double.parse(_output);
      operand = buttonText;
      _outputHistory = _output + buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "x") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      _outputHistory = "";
    } else if (buttonText == "sin") {
      double input = double.parse(_output);
      _output = math.sin(input).toString();
      _outputHistory = "sin($_output)";
    } else if (buttonText == "cos") {
      double input = double.parse(_output);
      _output = math.cos(input).toString();
      _outputHistory = "cos($_output)";
    } else if (buttonText == "tan") {
      double input = double.parse(_output);
      _output = math.tan(input).toString();
      _outputHistory = "tan($_output)";
    } else if (buttonText == "log") {
      double input = double.parse(_output);
      _output = math.log(input).toString();
      _outputHistory = "log($_output)";
    } else if (buttonText == "√") {
      double input = double.parse(_output);
      _output = math.sqrt(input).toString();
      _outputHistory = "√($_output)";
    } else if (buttonText == "%") {
      double input = double.parse(_output);
      _output = (input / 100).toString();
      _outputHistory = "($_output%)";
    } else if (buttonText == "ln") {
      double input = double.parse(_output);
      _output = math.log(input).toString();
      _outputHistory = "ln($_output)";
    } else if (buttonText == "1/x") {
      double input = double.parse(_output);
      _output = (1 / input).toString();
      _outputHistory = "(1/$_output)";
    } else if (buttonText == "π") {
      _output = math.pi.toString();
      _outputHistory = "π";
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += ".";
        _outputHistory += ".";
      }
    } else if (buttonText == "x^y") {
      num1 = double.parse(_output);
      operand = buttonText;
      _outputHistory = "$_output^";
      _output = "0";
    } else if (buttonText == "x!") {
      int factorialInput = int.parse(_output);
      _output = _factorial(factorialInput).toString();
      _outputHistory = "($_output!)";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }

    setState(() {
      _output;
    });
  }

  int _factorial(int n) {
    if (n == 0) {
      return 1;
    }
    return n * _factorial(n - 1);
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.hovered)) {
                  return buttonColor.withOpacity(0.8); // Change color on hover
                } else if (states.contains(WidgetState.pressed)) {
                  return buttonColor.withOpacity(0.6); // Change color on press
                }
                return buttonColor; // Default color
              },
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: const BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scientific Calculator"),
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretch buttons horizontally
        children: <Widget>[
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _outputHistory,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    _output,
                    style: const TextStyle(
                        fontSize: 48.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Stretch buttons horizontally
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch buttons vertically
                    children: <Widget>[
                      buildButton(
                          "sin", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "cos", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "tan", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "log", 1, const Color.fromARGB(255, 10, 10, 10)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch buttons vertically
                    children: <Widget>[
                      buildButton(
                          "√", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "%", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "ln", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "1/x", 1, const Color.fromARGB(255, 10, 10, 10)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch buttons vertically
                    children: <Widget>[
                      buildButton(
                          "π", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "x!", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          ".", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "x^y", 1, const Color.fromARGB(255, 10, 10, 10)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch buttons vertically
                    children: <Widget>[
                      buildButton(
                          "7", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "8", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "9", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "/", 1, const Color.fromARGB(255, 255, 51, 0)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch buttons vertically
                    children: <Widget>[
                      buildButton(
                          "4", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "5", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "6", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "x", 1, const Color.fromARGB(255, 255, 51, 0)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch buttons vertically
                    children: <Widget>[
                      buildButton(
                          "1", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "2", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "3", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "-", 1, const Color.fromARGB(255, 255, 51, 0)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch buttons vertically
                    children: <Widget>[
                      buildButton("C", 1, Colors.red),
                      buildButton(
                          "0", 1, const Color.fromARGB(255, 10, 10, 10)),
                      buildButton(
                          "=", 1, const Color.fromARGB(255, 83, 58, 207)),
                      buildButton(
                          "+", 1, const Color.fromARGB(255, 255, 51, 0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
