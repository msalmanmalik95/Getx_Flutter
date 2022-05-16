import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/controller/cart_controller.dart';
import 'package:getx_flutter/widgets/empty_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline5),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    return GetBuilder<CartController>(
      builder: (value) => value.items.isEmpty
          ? EmptyWidget()
          : ListView.builder(
              itemCount: value.items.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.done),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    value.remove(value.items[index]);
                  },
                ),
                title: Text(
                  value.items[index].name,
                  style: itemNameStyle,
                ),
              ),
            ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  final CartController ctrl = Get.find();
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);

    return Container(
      height: 200,
      color: Colors.blue,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CartController>(
              builder: (value) =>
                  Text('\$${value.totalPrice}', style: hugeStyle),
            ),
            const SizedBox(width: 24),
            TextButton(
              onPressed: () {
                ctrl.clearList();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thank you for shopping')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
