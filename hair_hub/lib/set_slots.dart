import "package:flutter/material.dart";

class SlotScreen extends StatefulWidget {
  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  int _numSlots = 1;

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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
        backgroundColor: Color(0xFF404040),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Set Slots for Today",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Your button's onPressed logic here
                    },
                    child: Text('Select Date'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFECB72B),
                      foregroundColor: Color(0xFF404040),
                      fixedSize: Size(200, 50),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('NO of Slots:'),
                    SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton<int>(
                        value: _numSlots,
                        onChanged: (int? newValue) {
                          setState(() {
                            _numSlots = newValue!;
                          });
                        },
                        items: List<int>.generate(20, (int index) => index + 1)
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Slots Date and time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            // Add your ListView.builder here
            Container(
              height: 380,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _numSlots,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('Slot ${index + 1}'),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Set Time",
                            style: TextStyle(color: Color(0xFFECB72B)),
                          ),
                        ),
                        // Add more slot information here if needed
                      ),
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Reset Slots"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFECB72B),
                      foregroundColor: Color(0xFF404040),
                      shape: StadiumBorder(),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Save Slots"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFECB72B),
                      foregroundColor: Color(0xFF404040),
                      shape: StadiumBorder(),
                    ),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
