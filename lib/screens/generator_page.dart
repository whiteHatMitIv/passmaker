import 'package:flutter/material.dart';
import 'package:passmaker/widgets/password_view_gen.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.3),
        backgroundColor: isDarkMode ? Color.fromARGB(255, 2, 2, 2) : const Color.fromARGB(255, 239, 235, 235),
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Color(0xFF0EB1D2),
        ),
        title: Text(
          "Générer un mot de passe",
          style: TextStyle(
            fontFamily: 'Mada',
            color: theme.textTheme.bodyLarge?.color
          ),
        ),
      ),
      body: PasswordViewGen()
    );
  }
}
