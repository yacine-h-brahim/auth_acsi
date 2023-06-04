import 'package:acsi_auth/modules/disease.dart';

List<Disease> searchSymptomsMethod(List<Disease> diseases, String query) {
  // Normalize the query string to lowercase for case-insensitive search
  final normalizedQuery = query.toLowerCase();

  // Create a list to store the matching symptoms
  final List<Disease> matchingDisease = [];

  // Iterate through each disease
  for (final disease in diseases) {
    // Iterate through each symptom within the disease
    for (final symptom in disease.symptoms) {
      final lowerCaseValue = symptom.name.toLowerCase();
      final upperCaseValue = symptom.name.toUpperCase();

      // Check if the symptom value is an exact match or contains the query string
      if (lowerCaseValue == normalizedQuery ||
          upperCaseValue == normalizedQuery ||
          lowerCaseValue.contains(normalizedQuery) ||
          upperCaseValue.contains(normalizedQuery.toUpperCase())) {
        matchingDisease.add(disease);
      } else {
        // Check if any substring of the symptom value matches the query
        for (int i = 0; i < symptom.name.length - 1; i++) {
          for (int j = i + 2; j <= symptom.name.length; j++) {
            final substring = symptom.name.substring(i, j).toLowerCase();
            if (substring == normalizedQuery) {
              matchingDisease.add(disease);
              break;
            }
          }
        }
      }
    }
  }

  // Return the list of matching symptoms
  return matchingDisease;
}
