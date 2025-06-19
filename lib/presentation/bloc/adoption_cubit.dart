import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdoptionCubit extends Cubit<Map<String, String>> {
  static const String adoptedKey = 'adopted_pets_map';

  AdoptionCubit() : super({}) {
    _loadAdoptedPets();
  }

  Future<void> _loadAdoptedPets() async {
    final prefs = await SharedPreferences.getInstance();
    final map = prefs.getString(adoptedKey);
    if (map != null) {
      emit(Map<String, String>.from(Uri.splitQueryString(map)));
    } else {
      emit({});
    }
  }

  Future<void> adoptPet(String petId) async {
    final updated = Map<String, String>.from(state);
    updated[petId] = DateTime.now().toIso8601String();
    emit(updated);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(adoptedKey, Uri(queryParameters: updated).query);
  }

  bool isAdopted(String petId) => state.containsKey(petId);

  List<MapEntry<String, String>> get adoptionHistory {
    final entries = state.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    return entries;
  }
}
