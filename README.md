# Flutter Calculator App

A versatile Flutter-based calculator with support for basic arithmetic, advanced mathematical functions, and a clean, responsive UI.

## Features

* **Expression Parsing**

  * Basic operations: `+`, `-`, `*`, `/`, `%`
  * Parentheses for grouping
  * Advanced functions: `sin()`, `cos()`, `tan()`, `asin()`, `acos()`, `atan()`, `log()`, `ln()`, `sqrt()`, `^` (exponentiation)
* **State Management**

  * Centralized controller handles input, evaluation, history, and error states.
* **User Interface**

  * Responsive grid of buttons adapting to screen size
  * Display panel shows current expression, result, and error messages
* **Error Handling**

  * Detects invalid expressions (e.g., mismatched parentheses, domain errors) and displays clear messages


## Components

* **main.dart**
  Initializes the app, applies theming, and launches `CalculatorScreen`.
* **calculator\_screen.dart**
  Defines the layout: input/output display, button grid, and handles user gestures.
* **calculator\_controller.dart**
  Manages the current expression string, evaluates via the parser, updates result or error state, and maintains history.
* **parser.dart**
  Implements a recursive descent parser supporting:

  * Numeric literals (integers, decimals)
  * Arithmetic operators and precedence
  * Parentheses
  * Built-in functions (trigonometric, logarithmic, root, exponentiation)
  * Error detection for invalid syntax or domain errors

## Customization

* **UI Tweaks:** Modify button styles, colors, and layout in `calculator_screen.dart`.
* **Function Extensions:** Add or adjust supported functions in `parser.dart` by extending the grammar.
* **State Management Swap:** Replace the controller with Provider, Bloc, or Riverpod for larger apps.
