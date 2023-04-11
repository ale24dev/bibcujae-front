abstract class Utils {
  static String createGetUrl(
      {required String baseUrl, required Map<String, dynamic> params}) {
    String url = '$baseUrl?${params.keys.first}=${params.values.first}';
    for (int i = 1; i < params.length; i++) {
      url += '&${params.keys.elementAt(i)}=${params.values.elementAt(i)}';
    }
    return url;
  }
}
