import 'package:flutter/material.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/routes/home.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/routes/second.dart';

class RouteGenerator {
  // string com os caminhos para nossas telas.
  static const String home = '/';
  static const String second = '/second';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case second:
        return MaterialPageRoute(builder: (_) => const Second());
      default:
        throw FormatException("Rota nao encontrada");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}