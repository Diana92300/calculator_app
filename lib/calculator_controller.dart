import 'package:flutter/material.dart';
import 'parser.dart';

class CalculatorController extends ChangeNotifier {
  String _equation = '0';
  String _result   = '0';
  bool   _isSci    = false;

  String get equation => _equation;
  String get result   => _result;
  bool   get isSci    => _isSci;

  void toggleKeyboard() {
    _isSci = !_isSci;
    notifyListeners();
  }

  void press(String key) {
    const funcs = {
      'sin','cos','tan','sin⁻¹','cos⁻¹','tan⁻¹','log','ln'
    };

    if (key == 'C') {
      _equation = _result = '0';
    } else if (key == '⌫') {
      _equation = _equation.length > 1
          ? _equation.substring(0, _equation.length - 1)
          : '0';
    } else if (key == '=') {
      _result = Parser.evaluate(_equation);
    } else if (key == '()') {
      if (_equation == '0') {
        _equation = '(';
      } else {
        final lastChar = _equation.isNotEmpty ? _equation[_equation.length-1] : '';
        final openCount = '('.allMatches(_equation).length;
        final closeCount = ')'.allMatches(_equation).length;
        if (RegExp(r'[0-9πe)]').hasMatch(lastChar) && openCount > closeCount) {
          _equation += ')';
        }
        else if (lastChar == '(' || RegExp(r'[+\-*/^]').hasMatch(lastChar)) {
          _equation += '(';
        }
        else {
          _equation += '(';
        }
      }
    }else if (funcs.contains(key)) {
      if (_equation == '0') {
        _equation = key + '(';
      } else {
        _equation += key + '(';
      }
      _isSci = false;
    } else if (key == '√') {
      if (_equation == '0') {
        _equation = '√(';
      } else {
        _equation += '√(';
      }
      _isSci = false;
    } else if (key == 'x²') {
      if (_equation == '0') {
        _equation += '^2';
      } else {
        _equation += '^2';
      }
      _isSci = false;
    } else if (key == 'π' || key == 'e') {
      if (_equation == '0') {
        _equation = key;
      } else {
        _equation += key;
      }
      _isSci = false;
    } else if (RegExp(r'[0-9\.]').hasMatch(key)) {
      if (_equation == '0' && key != '.') {
        _equation = key;
      } else {
        _equation += key;
      }
    } else {
      _equation += key;
    }
    notifyListeners();
  }
}
