import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_assessment_app/model/Assessment_card_model.dart';

class FavoriteService {
  static const String _keyFavorites = 'favorite_assessments';

  /// Add an assessment to favorites
  static Future<void> addToFavorites(AssessmentCardModel assessment) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];
    
    // Convert assessment to JSON string
    String assessmentJson = jsonEncode(assessment.toMap());
    
    // Check if already exists (by ID)
    bool alreadyExists = favorites.any((favoriteJson) {
      Map<String, dynamic> favoriteMap = jsonDecode(favoriteJson);
      return favoriteMap['id'] == assessment.id;
    });
    
    if (!alreadyExists) {
      favorites.add(assessmentJson);
      await prefs.setStringList(_keyFavorites, favorites);
    }
  }

  /// Remove an assessment from favorites
  static Future<void> removeFromFavorites(String assessmentId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];
    
    // Remove the assessment with matching ID
    favorites.removeWhere((favoriteJson) {
      Map<String, dynamic> favoriteMap = jsonDecode(favoriteJson);
      return favoriteMap['id'] == assessmentId;
    });
    
    await prefs.setStringList(_keyFavorites, favorites);
  }

  /// Check if an assessment is in favorites
  static Future<bool> isFavorite(String assessmentId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];
    
    return favorites.any((favoriteJson) {
      Map<String, dynamic> favoriteMap = jsonDecode(favoriteJson);
      return favoriteMap['id'] == assessmentId;
    });
  }

  /// Get all favorite assessments
  static Future<List<AssessmentCardModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];
    
    return favorites.map((favoriteJson) {
      Map<String, dynamic> favoriteMap = jsonDecode(favoriteJson);
      return AssessmentCardModel.fromMap(favoriteMap);
    }).toList();
  }

  /// Toggle favorite status
  static Future<bool> toggleFavorite(AssessmentCardModel assessment) async {
    bool isCurrentlyFavorite = await isFavorite(assessment.id);
    
    if (isCurrentlyFavorite) {
      await removeFromFavorites(assessment.id);
      return false; // No longer favorite
    } else {
      await addToFavorites(assessment);
      return true; // Now favorite
    }
  }

  /// Clear all favorites
  static Future<void> clearAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyFavorites);
  }

  /// Get favorite count
  static Future<int> getFavoriteCount() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];
    return favorites.length;
  }
}
