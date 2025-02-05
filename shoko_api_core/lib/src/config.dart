final class Config {
  const Config._(this.secret, this.isDev);
  static Config? _currentConfig;
  static Config get instance => _currentConfig ?? (throw Exception('Config wasn`t initialize'));

  final String secret;
  final bool isDev;

  void initialize(String secret, bool isDev) {
    _currentConfig = Config._(secret, isDev);
  }
}
