import 'package:acsi_auth/modules/disease.dart';

List<Disease> searchDiseasesMethod(List<Disease> diseases, String query) {
  // Normalize the query string to lowercase for case-insensitive search
  final normalizedQuery = query.toLowerCase();

  // Create a list to store the matching diseases
  final List<Disease> matchingDiseases = [];

  // Iterate through each disease
  for (final disease in diseases) {
    final lowerCaseName = disease.name.toLowerCase();
    final upperCaseName = disease.name.toUpperCase();

    // Check if the disease name is an exact match or contains the query string
    if (lowerCaseName == normalizedQuery ||
        upperCaseName == normalizedQuery ||
        lowerCaseName.contains(normalizedQuery) ||
        upperCaseName.contains(normalizedQuery.toUpperCase())) {
      matchingDiseases.add(disease);
    } else {
      // Check if any substring of the disease name matches the query
      for (int i = 0; i < disease.name.length - 1; i++) {
        for (int j = i + 2; j <= disease.name.length; j++) {
          final substring = disease.name.substring(i, j).toLowerCase();
          if (substring == normalizedQuery) {
            matchingDiseases.add(disease);
            break;
          }
        }
      }
    }
  }

  // Return the list of matching diseases
  return matchingDiseases;
}
