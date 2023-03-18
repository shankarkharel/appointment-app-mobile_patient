class Order {
  String? orderId;
  String? itemId;
  String? orderDateTime;
  String? quantity;
  String? orderBy;

  Order(
      {this.orderId,
      this.itemId,
      this.orderDateTime,
      this.quantity,
      this.orderBy});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemId = json['item_id'];
    orderDateTime = json['order_date_time'];
    quantity = json['quantity'];
    orderBy = json['order_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['item_id'] = itemId;
    data['order_date_time'] = orderDateTime;
    data['quantity'] = quantity;
    data['order_by'] = orderBy;
    return data;
  }
}
