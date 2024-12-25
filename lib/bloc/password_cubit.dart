import 'dart:math';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:passmaker/models/password.dart';

class PasswordCubit extends HydratedCubit<List<Password>> {
  static const int maxPassword = 35;
  List<Password> allPasswords = [];
  final Set<int> _availableId = Set.from(List.generate(maxPassword, (index) => index));

  PasswordCubit() : super([]) {
    allPasswords = List<Password>.from(state);
    for (var password in state) {
      _availableId.remove(int.parse(password.id));
    }
  }

  void addPassword(Password password) {
    final int id = int.parse(password.id);

    if (_availableId.contains(id)) {
      _availableId.remove(id);
      allPasswords.add(password);
      emit(List<Password>.from(allPasswords));
    } else {
      throw Exception("ID déjà utilisé ou invalide.");
    }
  }

  void deletePassword(String id) {
    final int numericId = int.parse(id);
    
    _availableId.add(numericId);
    allPasswords.removeWhere((password) => password.id == id);
    emit(List<Password>.from(allPasswords));
  }

  int getAvailableId() {
    if (_availableId.isEmpty) {
      throw Exception("Limite atteinte, aucun identifiant disponible");
    }
    
    final availableList = _availableId.toList();
    final randomIndex = Random().nextInt(availableList.length);

    return availableList[randomIndex];
  }
  
  @override
  List<Password>? fromJson(Map<String, dynamic> json) {
    List<Password> passwords = (json["passwords"] as List)
        .map((password) => Password.fromMap(password as Map<String, dynamic>))
        .toList();
    
    _availableId.clear();
    _availableId.addAll(List.generate(maxPassword, (index) => index));
    for (var password in passwords) {
      _availableId.remove(int.parse(password.id));
    }
    allPasswords = List<Password>.from(passwords);
    return passwords;
  }
  
  @override
  Map<String, dynamic>? toJson(List<Password> state) {
    return {
      "passwords": state.map((password) => password.toMap()).toList()
    };
  }
}