import 'package:quizzer/data/command/command.dart';

class CommandInvoker {
  Command? command;

  void setCommand(Command command) {
    this.command = command;
  }

  void executeCommand() {
    command?.execute();
  }
}
