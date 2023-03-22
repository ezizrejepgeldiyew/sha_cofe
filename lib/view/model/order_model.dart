class OrderModel {
  final String servicesType;
  final String servicesTime;
  final List<ProductData>? productData;

  OrderModel({
    required this.servicesType,
    required this.servicesTime,
    required this.productData,
  });

  factory OrderModel.orderFromJson(Map<String, dynamic> data) => OrderModel(
      servicesType: data['services_type'],
      servicesTime: data['services_time'],
      productData: data['product_data']);
}

class ProductData {
  final int productId;
  final int productQuantity;

  ProductData({required this.productId, required this.productQuantity});

  factory ProductData.productDataFromJson(Map<String, dynamic> data) => ProductData(
      productId: data['productId'], productQuantity: data['productQuantity']);

}
