// lib/models/petroleum_product.dart

class PetroleumProduct {
  final String month;
  final int year;
  final String product;
  final double quantity;

  PetroleumProduct({
    required this.month,
    required this.year,
    required this.product,
    required this.quantity,
  });

  factory PetroleumProduct.fromJson(Map<String, dynamic> json) {
    return PetroleumProduct(
      month: json['month'],
      year: int.parse(json['year']),
      product: json['products'],
      quantity: double.parse(json['quantity_000_metric_tonnes_']),
    );
  }
}