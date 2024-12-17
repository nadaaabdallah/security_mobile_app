import 'package:flutter/material.dart';
import 'package:security_home_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageScreen(),
    );
  }
}


class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final List<String> notifications = [
    "Motion detected in the front yard",
    "Garage door left open",
    "Night vision activated",
    "System disarmed by Andrew",
  ];

  String selectedMode = "Daytime"; // Track the currently active mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: selectedMode == "Night Vision"
          ? Colors.black // Dark background for Night Vision
          : const Color.fromARGB(255, 233, 230, 230),
           // Light background for Daytime
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Hello, Andrew",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.videocam,
              color: Colors.black,
              size: 40,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 71, 70, 70)),
              child: Text(
                "Notifications",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        Icon(Icons.notifications, color: Color.fromARGB(255, 71, 70, 70)),
                    title: Text(notifications[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Check your notifications!",
                style: TextStyle(fontSize: 15, color: Colors.grey)),
            SizedBox(height: 20, width: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ColoredBox(color: Colors.transparent),
                _buildStatusCard("Alert", Icons.warning, Colors.red),
                _buildStatusCard("Battery", Icons.battery_full, Colors.green,
                    value: "98%"),
                _buildStatusCard("System", Icons.lock_open, Colors.blue,
                    value: "Disarmed"),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Quick view",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              children: [
                _buildQuickViewCard("Front", "assets/front.jpeg"),
                _buildQuickViewCard("Living room", "assets/livingroom.jpg"),
                _buildQuickViewCard("Garage", "assets/garage.jpg"),
                _buildQuickViewCard("Garden", "assets/garden.jpg"),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Mode",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildModeButton("Daytime", Icons.wb_sunny, selectedMode == "Daytime",
                    () {
                  setState(() {
                    selectedMode = "Daytime";
                  
                  });
                }),
                _buildModeButton("Night vision", Icons.nightlight_round,
                    selectedMode == "Night Vision", () {
                  setState(() {
                    selectedMode = "Night Vision";
                  });
                }),
                _buildModeButton("Log out", Icons.logout_outlined, false, () {
  _logout(context);
  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, IconData icon, Color color,
      {String value = ""}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 230, 230),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 20, width: 50),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          if (value.isNotEmpty)
            Text(value, style: TextStyle(color: color, fontSize: 16)),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();  

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),  // Navigate to LoginScreen
    );
  }

  Widget _buildQuickViewCard(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildModeButton(
      String title, IconData icon, bool isSelected, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            child: Icon(icon, color: isSelected ? Colors.white : Colors.grey),
          ),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(color: isSelected ? Colors.blue : Colors.grey)),
        ],
      ),
    );
  }
}
