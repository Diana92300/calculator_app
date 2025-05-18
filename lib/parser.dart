import 'dart:math' as math;

class Parser {
  static String evaluate(String expr) {
    final text = expr
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', '${math.pi}')
        .replaceAll('e', '${math.e}');

    try {
      final tokens = _tokenize(text);
      final v = _ExpressionParser(tokens).parse();
      final s = v.toString();
      return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
    } catch (_) {
      return 'Error';
    }
  }
  static List<String> _tokenize(String src) {
    final t = <String>[];
    final buf = StringBuffer();
    var num = false;

    void flush() {
      if (buf.isNotEmpty) {
        t.add(buf.toString());
        buf.clear();
      }
    }

    for (final ch in src.split('')) {
      if (RegExp(r'\d').hasMatch(ch) || ch == '.') {
        if (!num) flush();
        buf.write(ch);
        num = true;
      } else if ('+-*/^%()'.contains(ch)) {
        flush();
        t.add(ch);
        num = false;
      } else {
        if (num) flush();
        buf.write(ch);
        num = false;
      }
    }
    flush();
    return t;
  }
}
class _ExpressionParser {
  final List<String> t;
  int p = 0;
  _ExpressionParser(this.t);

  double parse() {
    final r = _addSub();
    if (p < t.length) throw Exception('Leftovers');
    return r;
  }

  double _addSub() {
    var l = _mulDiv();
    while (p < t.length && (t[p] == '+' || t[p] == '-')) {
      final op = t[p++];
      final r = _mulDiv();
      l = op == '+' ? l + r : l - r;
    }
    return l;
  }

  double _mulDiv() {
    var l = _pow();
    while (p < t.length && ('*/%'.contains(t[p]))) {
      final op = t[p++];
      final r = _pow();
      if (op == '*') l *= r;
      else if (op == '/') l /= r;
      else l %= r;
    }
    return l;
  }
  double _pow() {
    var l = _factor();
    while (p < t.length && t[p] == '^') {
      p++;
      l = math.pow(l, _factor()).toDouble();
    }
    return l;
  }

  double _factor() {
    if (p >= t.length) throw Exception();
    final tok = t[p++];

    if (tok == '(') {
      final v = _addSub();
      if (p >= t.length || t[p++] != ')') throw Exception();
      return v;
    }

    double call(String f, double v) => switch (f) {
      'sin'    => math.sin(v),
      'cos'    => math.cos(v),
      'tan'    => math.tan(v),
      'sin⁻¹' || 'asin' => math.asin(v),
      'cos⁻¹' || 'acos' => math.acos(v),
      'tan⁻¹' || 'atan' => math.atan(v),
      'log'    => math.log(v) / math.ln10,
      'ln'     => math.log(v),
      '√' || 'sqrt' => math.sqrt(v),
      _        => throw Exception('func')
    };

    const funcs = {
      'sin','cos','tan','sin⁻¹','cos⁻¹','tan⁻¹',
      'asin','acos','atan','log','ln','√','sqrt'
    };

    if (funcs.contains(tok)) {
      if (p >= t.length || t[p++] != '(') throw Exception();
      final arg = _addSub();
      if (p >= t.length || t[p++] != ')') throw Exception();
      return call(tok, arg);
    }

    return double.tryParse(tok) ??
        (tok == 'π' ? math.pi : tok == 'e' ? math.e : throw Exception(tok));
  }
}
