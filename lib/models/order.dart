// widgets/latest_orders_list.dart
import 'package:flutter/material.dart';
import 'package:majid/widgets/latest_orders_list.dart';

class LatestOrdersList extends StatelessWidget {
  final List<Order> orders = [
    Order(id: "#213421", amount: "4560", address: "Address Lahore C123"),
    Order(id: "#213422", amount: "4200", address: "Address Lahore A122"),
    Order(id: "#565555", amount: "4200", address: "Address Lahore A122"),
    Order(id: "#374834", amount: "4200", address: "Address Lahore A122"),
    Order(id: "#398484", amount: "4200", address: "Address Lahore A122"),
    Order(id: "#808488", amount: "4200", address: "Address Lahore A122"),
    Order(id: "#237222", amount: "4200", address: "Address Lahore A122"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Latest Orders",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text("See All", style: TextStyle(color: Colors.blue)),
          ],
        ),
        SizedBox(height: 10),
        ...orders.map(
          (order) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text("ID ${order.id}"),
              subtitle: Text(order.address),
              trailing: Text("K. ${order.amount}"),
            ),
          ),
        ),
      ],
    );
  }
}
