class Cart {
  String? cartId;
  String? userId;
  String? itemId;

  Cart({this.cartId, this.userId, this.itemId});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['user_id'] = userId;
    data['item_id'] = itemId;
    return data;
  }
}
