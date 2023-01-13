import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import './place_detail_screen.dart';
import '../providers/places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(
          context,
          listen: false,
        ).fetchAndSetPlaces(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Places>(
                  builder: (context, value, child) {
                    return value.items.isEmpty
                        ? child as Widget
                        : ListView.builder(
                            itemCount: value.items.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(value.items[index].image),
                                ),
                                title: Text(value.items[index].title),
                                subtitle: Text(value
                                    .items[index].location!.address as String),
                                onTap: (() {
                                  Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: value.items[index].id,
                                  );
                                }),
                              );
                            },
                          );
                  },
                  child: const Center(
                    child: Text('Got no places yet, start adding some!'),
                  ),
                );
        },
      ),
    );
  }
}
