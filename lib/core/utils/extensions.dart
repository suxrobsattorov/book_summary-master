extension StringExtensions on String {
  String get clearJson {
    // agar String ```json bilan boshlansa uni ikkiga ajratib, 
    // ```json qatnashmagan qismini qaytar
    if (startsWith("```")) {
      return split("```")[1].substring(4);
    }
    return this;
  }
}
