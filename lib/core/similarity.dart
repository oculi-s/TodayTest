import 'dart:math';

double cosSim(List<double> a, List<double> b) {
  double dotProduct = 0;
  for (int i = 0; i < min(a.length, b.length); i++) {
    dotProduct += a[i] * b[i];
  }

  double normA =
      sqrt(a.map((e) => e * e).reduce((sum, element) => sum + element));
  double normB =
      sqrt(b.map((e) => e * e).reduce((sum, element) => sum + element));

  double similarity = dotProduct / (normA * normB);

  return similarity;
}


  // final embedding = OpenAI.instance.embedding
  //     .create(
  //         model: "text-embedding-ada-002",
  //         input: "오늘 날씨는 맑고 화창합니다. 기온은 20도 정도입니다.")
  //     .then((value) => print(value.data.embeddings));