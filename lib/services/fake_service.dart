class FakeService {
  Future<String> getData() async {
    await Future.delayed(const Duration(seconds: 2));
    return """
🟢 Dados do servidor brasileiro:
- Clima: ☀️ 28°C em Rio de Janeiro
- Feriado: Independência do Brasil 🇧🇷
- Status: Online e funcional
""";
  }
}
