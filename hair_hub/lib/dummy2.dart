import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Shop2 extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shops Available",
          style: TextStyle(color: Color(0xFF404040)),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
        backgroundColor: Color(0xFFECB72B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('shops').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading....');
            default:
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    mainAxisExtent: 320),
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return ShopItem(
                    shop: Shop(
                      name: document['name'],
                      location: document['location'],
                      image: document['image'],
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}

class Shop {
  final String name;
  final String location;
  final String image;

  Shop({
    required this.name,
    required this.location,
    required this.image,
  });
}

class ShopItem extends StatelessWidget {
  final Shop shop;

  const ShopItem({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0), // Adjust padding as needed
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column 1 (Image)
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Image.asset(
                  shop.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Column 2 (Shop Details)
            Container(
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  // Icon(Icons.location_on),

                  Icon(Icons.location_on), Text(shop.location),
                  SizedBox(
                    height: 4.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text("See More"),
                    icon: Icon(Icons.arrow_forward),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF404040),
                      foregroundColor: Color.fromRGBO(236, 183, 43, 1),
                      fixedSize: Size(120, 20),
                      shape: StadiumBorder(),
                    ),
                    // SizedBox(
                    //   height: 4.0,
                    // ),
                    // Text(shop.location1)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
