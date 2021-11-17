
///All our [Ticker] class does is expose a tick function which takes the number of [seconds] (seconds) we want
/// returns a stream which emits the remaining seconds every second.
class Ticker {
  const Ticker();

  final Duration _kDuration = const Duration(seconds: 1);

  Stream<int> ticker({ required int seconds }) {
    return Stream.periodic(_kDuration, (tick) => seconds - tick - 1).take(seconds);
  }
}