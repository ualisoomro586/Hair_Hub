import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shops extends StatelessWidget {
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
        stream: _firestore.collection('barbers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No shops available.'));
          }

          final shops = snapshot.data!.docs;

          return GridView.builder(
            itemCount: shops.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              mainAxisExtent: 320,
            ),
            itemBuilder: (context, index) {
              final shop = shops[index];
              final shopName = shop['shopName'];
              final contact = shop['contact'];
              // Assuming you have a URL to the shop image stored in Firestore
              final imageUrl = shop['url'];
              final address = shop['address'];

              return ShopItem(
                shop: Shop(
                    name: shopName,
                    contact: contact,
                    image: imageUrl,
                    location: address),
              );
            },
          );
        },
      ),
    );
  }
}

class Shop {
  final String name;
  final String location;
  final String contact;
  final String image;

  Shop(
      {required this.name,
      required this.contact,
      required this.image,
      required this.location});
}

class ShopItem extends StatelessWidget {
  final Shop shop;

  const ShopItem({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                child: Image.network(
                  shop.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              // height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(children: [
                    Icon(Icons.phone),
                    Text(shop.contact),
                  ]),
                  SizedBox(height: 4.0),
                  Row(children: [
                    Icon(Icons.location_on),

                    // height: 100,
                    // width: double.infinity,
                    Flexible(
                      child: Text(
                        shop.location,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                  SizedBox(height: 4.0),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text("See More"),
                    icon: Icon(Icons.arrow_forward),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF404040),
                      foregroundColor: Color.fromRGBO(236, 183, 43, 1),
                      fixedSize: Size(130, 20),
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
