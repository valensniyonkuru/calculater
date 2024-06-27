import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
          secondary: Colors.black,
        ),
        scaffoldBackgroundColor: Color(0xFFFAF0E6),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.orange,
          ),
        ),
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '=') {
        try {
          _result = _calculate(_expression);
        } catch (e) {
          _result = 'Error';
        }
      } else {
        if (_result.isNotEmpty) {
          _expression = '';
          _result = '';
        }
        _expression += buttonText;
      }
    });
  }

  String _calculate(String expression) {
    try {
      final parser = Parser();
      final expressionAst =
          parser.parse(expression.replaceAll('x', '*').replaceAll('÷', '/'));
      final result =
          expressionAst.evaluate(EvaluationType.REAL, ContextModel());
      return result.toString();
    } catch (e) {
      throw Exception('Invalid expression: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.orange, // app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _expression,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _result,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      CalculatorButton('7', _onButtonPressed),
                      CalculatorButton('8', _onButtonPressed),
                      CalculatorButton('9', _onButtonPressed),
                      CalculatorButton('÷', _onButtonPressed),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton('4', _onButtonPressed),
                      CalculatorButton('5', _onButtonPressed),
                      CalculatorButton('6', _onButtonPressed),
                      CalculatorButton('×', _onButtonPressed),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton('1', _onButtonPressed),
                      CalculatorButton('2', _onButtonPressed),
                      CalculatorButton('3', _onButtonPressed),
                      CalculatorButton('-', _onButtonPressed),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton('0', _onButtonPressed),
                      CalculatorButton('.', _onButtonPressed),
                      CalculatorButton('=', _onButtonPressed),
                      CalculatorButton('+', _onButtonPressed),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('C', _onButtonPressed),
                      CalculatorButton('%', _onButtonPressed),
                      CalculatorButton('+/-', _onButtonPressed),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String _text;
  final Function _onPressed;

  CalculatorButton(this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: Text(_text, style: TextStyle(fontSize: 20)),
          onPressed: () => _onPressed(_text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(24),
            backgroundColor: Colors.black, // button background color
            foregroundColor: Colors.orange, // button text color
          ),
        ),
      ),
    );
  }
}
