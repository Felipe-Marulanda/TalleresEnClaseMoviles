import 'package:flutter/material.dart';

class WidgetsDemoScreen extends StatelessWidget {
  const WidgetsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text("🇧🇷 Widgets Demo", style: TextStyle(color: Colors.white)),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_view), text: "Grid"),
              Tab(icon: Icon(Icons.list), text: "Expansion"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _GridDemo(),
            _ExpansionDemo(),
          ],
        ),
      ),
    );
  }
}

class _GridDemo extends StatelessWidget {
  const _GridDemo();

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Fútbol", "img": "assets/images/futbol.jpg"},
      {"title": "Playa", "img": "assets/images/playa.jpg"},
      {"title": "Samba", "img": "assets/images/samba.jpg"},
      {"title": "Comida", "img": "assets/images/comida.jpg"},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(item["img"]!, fit: BoxFit.cover),
              Container(color: Colors.black.withOpacity(0.4)),
              Center(
                child: Text(
                  item["title"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpansionDemo extends StatelessWidget {
  const _ExpansionDemo();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExpansionTile(
          leading: Icon(Icons.music_note, color: Colors.purple),
          title: Text("Música brasileña"),
          children: [ListTile(title: Text("Samba, Bossa Nova, Funk Carioca"))],
        ),
        ExpansionTile(
          leading: Icon(Icons.sports_soccer, color: Colors.green),
          title: Text("Deporte"),
          children: [ListTile(title: Text("El fútbol es pasión nacional"))],
        ),
        ExpansionTile(
          leading: Icon(Icons.beach_access, color: Colors.blue),
          title: Text("Playas"),
          children: [ListTile(title: Text("Copacabana, Ipanema"))],
        ),
      ],
    );
  }
}
