import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmaker/bloc/password_cubit.dart';
import 'package:passmaker/models/password.dart';
import 'package:passmaker/widgets/password_item.dart';

class ViewSavePassword extends StatefulWidget {
  const ViewSavePassword({super.key});

  @override
  State<ViewSavePassword> createState() => _ViewSavePasswordState();
}

class _ViewSavePasswordState extends State<ViewSavePassword> {
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
          "Récemment ajouté",
          style: TextStyle(
            fontFamily: 'Mada',
            color: theme.textTheme.bodyLarge?.color
          ),
        ),
      ),
      body: BlocBuilder<PasswordCubit, List<Password>>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: MediaQuery.sizeOf(context).width / 1.05,
                          height: MediaQuery.sizeOf(context).height / 4,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                offset: Offset(5, 5),
                                blurRadius: 10,
                                spreadRadius: 1
                              )
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vos mots de passe enregistrés",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Copiez et supprimez vos mots de passe sauvegardés à tout moment",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w300
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          if (state.isEmpty)...{
                            Container(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                              child: Center(
                                child: Text(
                                  "Aucun mot de passe enregistré",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Colors.white : Colors.black
                                  ),
                                ),
                              ),
                            )
                          } else...{
                            for (Password password in state.reversed)...{
                              PasswordItem(
                                password: password,
                                onDeleteItem: () => context.read<PasswordCubit>().deletePassword(password.id),
                              ),
                            }
                          }
                        ],
                      )
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}