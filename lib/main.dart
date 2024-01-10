import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  String solution = '';

  void solveEquation() {
    try {
      // Parse the equation
      Parser p = Parser();
      Expression exp = p.parse(_textEditingController.text);

      // Evaluate the expression
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Display the result
      setState(() {
        solution = eval.toString();
      });
    } catch (e) {
      // Handle parsing or evaluation errors
      setState(() {
        solution = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(11))),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  TextField(
                    controller: _textEditingController,
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 10.0),
                      hintText: 'Enter the equation',
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Solution: $solution',style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.left,),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Container(
                  height: 80,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),
                  child: ElevatedButton(
                    onPressed: (){_textEditingController.clear();setState(() {
                      solution = '';
                    });},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(70, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ), child: Text('AC',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 80,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(70, 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ), child: Icon(Icons.history,color: Colors.black,size: 30,)
                  ),
                ),
                const SizedBox(width: 20),
                _buildCalcButton('%', () {
                  _appendText('%');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('+', () {
                  _appendText('+');
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                _buildCalcButton('7', () {
                  _appendText('7');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('8', () {
                  _appendText('8');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('9', () {
                  _appendText('9');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('-', () {
                  _appendText('-');
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                _buildCalcButton('4', () {
                  _appendText('4');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('5', () {
                  _appendText('5');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('6', () {
                  _appendText('6');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('X', () {
                  _appendText('*');
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                _buildCalcButton('1', () {
                  _appendText('1');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('2', () {
                  _appendText('2');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('3', () {
                  _appendText('3');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('/', () {
                  _appendText('/');
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                _buildCalcButton('.', () {
                  _appendText('.');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('0', () {
                  _appendText('0');
                }),
                const SizedBox(width: 20),
                _buildCalcButton('⌫', () {
                  _deleteLastDigit();
                }),
                const SizedBox(width: 20),
                _buildCalcButton('=', () {
                  solveEquation();
                }),
                const SizedBox(width: 10),

              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCalcButton(String text, VoidCallback onPressed) {
    return Container(
      height: 80,
      width: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.black,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(70, 80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: (text == '=' || text == '⌫') ? 20 : 30),
        ),
      ),
    );
  }

  // Function to append text to the first TextField
  void _appendText(String text) {
    final currentText = _textEditingController.text;
    _textEditingController.text = '$currentText$text';
  }

  // Function to delete the last digit from the first TextField
  void _deleteLastDigit() {
    final currentText = _textEditingController.text;
    if (currentText.isNotEmpty) {
      _textEditingController.text =
          currentText.substring(0, currentText.length - 1);
    }
  }
}
