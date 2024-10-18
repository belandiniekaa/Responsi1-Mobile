class Pemasukan {
  final int id;
  final String source;
  final int amount;
  final int frequency;

  Pemasukan({
    required this.id,
    required this.source,
    required this.amount,
    required this.frequency,
  });

  factory Pemasukan.fromJson(Map<String, dynamic> json) {
    return Pemasukan(
      id: json['id'],
      source: json['source'],
      amount: json['amount'],
      frequency: json['frequency'],
    );
  }
}
