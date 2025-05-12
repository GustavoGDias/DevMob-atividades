import 'package:flutter/material.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/cart.dart';
import 'package:myapp/ProviderTestes/contador/aula_multiprovider_count_card/state/count.dart';
import 'package:provider/provider.dart';

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Provider App (${context.watch<Count>().count})'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total de itens: ${context.watch<Cart>().count}'),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedListView(cart: context.watch<Cart>().cart),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('addItem_floatingActionButton'),
        onPressed: () => context.read<Cart>().addItem('Item ${DateTime.now().second}'),
        tooltip: 'Adicionar novo item!',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AnimatedListView extends StatefulWidget {
  final List<String> cart;

  const AnimatedListView({super.key, required this.cart});

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cart.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          key: ValueKey(widget.cart[index]),
          item: widget.cart[index],
          index: index,
        );
      },
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final String item;
  final int index;

  const AnimatedListItem({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[widget.index % Colors.primaries.length],
              child: Text(
                '${widget.index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(widget.item),
            trailing: const Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}