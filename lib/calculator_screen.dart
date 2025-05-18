import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_controller.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = context.watch<CalculatorController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        actions: [
          IconButton(
            icon: Icon(c.isSci ? Icons.calculate : Icons.science),
            onPressed: context.read<CalculatorController>().toggleKeyboard,
          ),
        ],
      ),
      body: Column(
        children: [
          _Display(equation: c.equation, result: c.result),
          Expanded(
            child: c.isSci
                ? _Scientific(onTap: c.press)
                : _Basic(onTap: c.press),
          ),
        ],
      ),
    );
  }
}

class _Display extends StatelessWidget {
  const _Display({required this.equation, required this.result});
  final String equation, result;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _text(equation, 38),
        _text(result, 48),
      ],
    ),
  );

  Widget _text(String s, double size) => Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.all(10),
    child: Text(s, style: TextStyle(fontSize: size)),
  );
}

class _Basic extends StatelessWidget {
  const _Basic({required this.onTap});
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final numPadButtons = [
      ['C', '⌫', '%'],
      ['7', '8', '9'],
      ['4', '5', '6'],
      ['1', '2', '3'],
      ['0', '.', '='],
    ];

    final opButtons = ['÷', '×', '-', '+', '()'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: LayoutBuilder(
              builder: (context, constraints) {
                double buttonHeight = constraints.maxHeight / numPadButtons.length;
                return Column(
                  children: [
                    for (var row in numPadButtons)
                      SizedBox(
                        height: buttonHeight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var k in row)
                              Expanded(
                                child: _CalcButton(
                                  k,
                                  color: (k == 'C' || k == '=')
                                      ? Colors.redAccent
                                      : Colors.black54,
                                  onTap: () => onTap(k),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                );
              }
          ),
        ),
        Expanded(
          flex: 1,
          child: LayoutBuilder(
              builder: (context, constraints) {
                double buttonHeight = constraints.maxHeight / opButtons.length;

                return Column(
                  children: [
                    for (var k in opButtons)
                      SizedBox(
                        height: buttonHeight,
                        child: _CalcButton(
                          k,
                          color: Colors.blue,
                          onTap: () => onTap(k),
                        ),
                      ),
                  ],
                );
              }
          ),
        ),
      ],
    );
  }
}

class _Scientific extends StatelessWidget {
  const _Scientific({required this.onTap});
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    // Scientific buttons layout
    final sciButtons = [
      ['sin', 'cos', 'tan'],
      ['sin⁻¹', 'cos⁻¹', 'tan⁻¹'],
      ['log', 'ln', '√'],
      ['π', 'e', 'x²'],
    ];

    return LayoutBuilder(
        builder: (context, constraints) {
          double buttonHeight = constraints.maxHeight / sciButtons.length;
          return Column(
            children: [
              for (var row in sciButtons)
                SizedBox(
                  height: buttonHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var k in row)
                        Expanded(
                          child: _CalcButton(
                            k,
                            color: Colors.black87,
                            onTap: () => onTap(k),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          );
        }
    );
  }
}
class _CalcButton extends StatelessWidget {
  const _CalcButton(
      this.label,
      {required this.color, required this.onTap, super.key}
      );

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fs = label.length > 3 ? 18.0 : 22.0;

    return Container(
      margin: const EdgeInsets.all(1),
      color: color,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: fs, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}