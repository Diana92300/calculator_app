# Flutter Calculator App

A simple calculator built with Flutter, featuring expression parsing, state management, and a clean UI.

## Features

* **Expression Parsing**: Supports basic arithmetic operations (`+`, `-`, `*`, `/`, `%`) and parentheses.
* **State Management**: Uses a dedicated controller to handle input, evaluation, and error states.
* **Clean UI**: Responsive grid of buttons and display area for current expression and result.
* **Error Handling**: Detects invalid expressions and displays error messages.

## Components

* **main.dart**: Launches the `CalculatorScreen` widget.
* **calculator\_screen.dart**: Defines the UI—display panel and button grid. Listens to controller updates.
* **calculator\_controller.dart**: Manages the input string, handles button taps, invokes the parser, and updates the UI state.
* **parser.dart**: Implements a recursive descent parser to evaluate arithmetic expressions safely.

## Customization

* Adjust button styles and grid layout in `calculator_screen.dart`.
* Extend parser in `parser.dart` for additional operations (e.g., exponentiation, functions).
* Swap state management for Provider or Bloc by replacing the controller logic.

