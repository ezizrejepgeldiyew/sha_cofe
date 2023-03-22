
class BasketModel {
  final int id;
  final int count;

  BasketModel ({
    required this.id,
    required this.count,
  });

  // factory BasketModel.basketFromJson(Map<int, dynamic> data) =>
  // BasketModel(id: data['id'], count: data['count']);
}