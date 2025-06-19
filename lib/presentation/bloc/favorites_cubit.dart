import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesCubit extends Cubit<Set<String>> {
  static const String favoritesKey = 'favorite_pets';

  FavoritesCubit() : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(favoritesKey) ?? [];
    emit(ids.toSet());
  }

  Future<void> toggleFavorite(String petId) async {
    final updated = Set<String>.from(state);
    if (updated.contains(petId)) {
      updated.remove(petId);
    } else {
      updated.add(petId);
    }
    emit(updated);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoritesKey, updated.toList());
  }

  bool isFavorite(String petId) => state.contains(petId);
}
