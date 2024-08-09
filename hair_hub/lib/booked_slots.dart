import "package:flutter/material.dart";

class BookedSlot extends StatefulWidget {
  @override
  State<BookedSlot> createState() => _BookedSlotState();
}

class _BookedSlotState extends State<BookedSlot> {
  int _numSlots = 15;

  // List to store your slot information
  List<String> _slotTimes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shop Name",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF404040),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Today's Slots",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Text(
                    "Slot's Status",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            // Add your ListView.builder here
            Container(
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _numSlots,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                          title: Text('Slot ${index + 1}'),
                          trailing: const Text(
                            "Booked",
                            style: TextStyle(color: Colors.green),
                          )),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Customer Name: Usman",
                                style: TextStyle(
                                    backgroundColor: Color(0xFFECB72B)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                "Time: 2:30 pm",
                                style: TextStyle(color: Color(0xFF404040)),
                              ),
                            )
                          ]),
                      // Add more slot information here if needed

                      Divider(
                        color: Colors.grey, // You can customize the color
                        thickness: 1.0, // You can customize the thickness
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
