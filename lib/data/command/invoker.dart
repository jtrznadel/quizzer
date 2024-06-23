import 'package:quizzer/data/command/command.dart';

class Invoker {
  Command? command;

  void setCommand(Command command) {
    this.command = command;
  }

  void executeCommand() {
    command?.execute();
  }
}
