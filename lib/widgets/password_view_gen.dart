import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmaker/bloc/password_cubit.dart';
import 'dart:math';

import 'package:passmaker/models/password.dart';

class PasswordViewGen extends StatefulWidget {
  const PasswordViewGen({
    super.key,
  });

  @override
  State<PasswordViewGen> createState() => _PasswordViewGenState();
}

class _PasswordViewGenState extends State<PasswordViewGen> {
  String _password = "12345";
  final random = Random();
  final digits = '0123456789';

  void _generatePassword() {
    setState(() {
      _password = List.generate(
        5, 
        (index) => digits[random.nextInt(digits.length)]
      ).join();
    });
  }

  void _copyPassword() {
    Clipboard.setData(ClipboardData(text: _password));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Mot de passe copié!")
    ));
  }

  void _savePassword() {
    final cubit = context.read<PasswordCubit>();

    if (cubit.state.length >= PasswordCubit.maxPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Limite de mots de passe atteinte !')),
      );
      return;
    }

    try {
      final id = cubit.getAvailableId();
      final password = Password(id: id.toString(), passwordString: _password);

      cubit.addPassword(password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mot de passe sauvegardé !")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 6),
            child: Container(
              width: MediaQuery.sizeOf(context).width / 1.3,
              height: 60,
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(2, 3),
                    spreadRadius: 2,
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      _password,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      onPressed: _copyPassword, 
                      icon: Icon(
                        Icons.copy_rounded,
                        size: 35,
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 9),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: ElevatedButton(
                    onPressed:() {
                      _generatePassword();
                      _savePassword();
                    } , 
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(250, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      backgroundColor: isDarkMode ? Color(0xFF1E1E1E) : Colors.grey.withOpacity(0.4),
                      elevation: 5,
                      shadowColor: isDarkMode ? Colors.grey.withOpacity(0.3) : Colors.grey.withOpacity(0.8)
                    ),
                    child: Text(
                      "Générer",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
