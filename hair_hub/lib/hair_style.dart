import 'package:flutter/material.dart';

class HairStyleScreen extends StatelessWidget {
  final List<Shop> shops = List.generate(
    7,
    (index) => Shop(
      style: 'Style # ${index + 1}',
      price: 'Price: 500 rupees',
      image: 'assets/hairstyle${index + 1}.jpeg',
      // location1: 'Hyderabad',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Details",
          style: TextStyle(color: Color(0xFF404040)),
        ),
        backgroundColor: Color(0xFFECB72B),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: shops.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              mainAxisExtent: 330),
          itemBuilder: (context, index) {
            final shop = shops[index];
            return Styles(shop: shop);
          },
        ),
      ),
    );
  }
}

class Shop {
  final String style;
  final String price;
  final String image;
  // final String location1;

  Shop({
    required this.style,
    required this.price,
    required this.image,
    // required this.location1
  });
}

class Styles extends StatelessWidget {
  final Shop shop;

  const Styles({Key? key, required this.shop}) : super(key: key);

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
              height: 200,
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
                  fit: BoxFit.fill,
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
                    shop.style,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(shop.price),
                  // Icon(Icons.location_on),
                  SizedBox(
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      label: Text("Try on"),
                      icon: Icon(Icons.visibility),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF404040),
                        foregroundColor: Color.fromRGBO(236, 183, 43, 1),
                        fixedSize: Size(100, 20),
                        shape: StadiumBorder(),
                      ),
                      // SizedBox(
                      //   height: 4.0,
                      // ),
                      // Text(shop.location1)
                    ),
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
