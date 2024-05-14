class StringService {
  static String addComma(String priceString) {
    if (priceString.length <= 2) {
      return priceString; // If the string is two characters or less, no comma needed
    }
    String firstPart =
        priceString.substring(0, 2); // Extract the first two characters
    String secondPart =
        priceString.substring(2); // Extract the rest of the string
    return '$firstPart,$secondPart'; // Add comma between the first two characters and the rest
  }
}
