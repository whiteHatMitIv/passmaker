import 'package:flutter/material.dart';
import 'package:passmaker/screens/generator_page.dart';
import 'package:passmaker/screens/view_save_password.dart';
import 'package:passmaker/widgets/option_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color.fromARGB(255, 2, 2, 2) : const Color.fromARGB(255, 239, 235, 235),
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.3),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode ? Colors.white : Color(0xFF0EB1D2),
            ),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "Option 1",
                child: Text("Version 1.0"),
              ),
              const PopupMenuItem(
                value: "Option 2",
                child: Text("Upgrade coming soon"),
              ),
            ],
          ),
        ],
        title: Text(
          "PassMaker",
          style: TextStyle(
            fontFamily: 'Mada',
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color
          ),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OptionWidget(
            imagePath: isDarkMode ? "assets/4D.png" : "assets/4W.png",
            optionTitle: "Générer un mot de passe",
            optionDescription: "Générez, copiez et enregistrez un nouveau\nmot de passe",
            targetPage: GeneratorPage(),
          ),
          OptionWidget(
            imagePath: isDarkMode ? "assets/5D.png" : "assets/5W.png",
            optionTitle: "Récemment ajoutés",
            optionDescription: "Consultez la liste des mots de passe récemment\najoutés",
            targetPage: ViewSavePassword(),
          )
        ],
      ),
    );
  }
}