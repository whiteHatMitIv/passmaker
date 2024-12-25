import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passmaker/models/password.dart';

class PasswordItem extends StatelessWidget {
  final Password password;
  final Function onDeleteItem;

  const PasswordItem({
    super.key,
    required this.password,
    required this.onDeleteItem
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width / 1.2,
          height: MediaQuery.sizeOf(context).height / 11,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                offset: Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 1
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "id: ${password.id}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      password.passwordString,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: password.passwordString));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Mot de passe copié!")
                      ));
                    }, 
                    icon: Icon(
                      Icons.copy_rounded,
                      size: 35,
                    )
                  ),
                  IconButton(
                    onPressed: () {
                      onDeleteItem();
                    }, 
                    icon: Icon(
                      Icons.delete_rounded,
                      size: 35,
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}