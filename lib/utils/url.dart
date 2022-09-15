const String apiDomain = "https://newsapi.org/v2/";

const String apiKey = "f7d975958512453aa7079d8bea5ab8dd";

String headlineUrl(String country, String category) {
  return "https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey";
}

String search(String query, String sort) {
  return "https://newsapi.org/v2/everything?q=$query&sortBy=$sort&apiKey=$apiKey";
}
