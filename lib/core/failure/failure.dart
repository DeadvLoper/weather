abstract class Failure extends Error {}

class NoResult implements Failure {
  @override
  StackTrace get stackTrace => StackTrace.current;
}
