
import 'package:cms_provider/utils/theme_data.dart';
import 'package:flutter/material.dart';

class ProviderDashboardScreen extends StatefulWidget {
  const ProviderDashboardScreen({super.key});

  @override
  State<ProviderDashboardScreen> createState() => _ProviderDashboardScreenState();
}

class _ProviderDashboardScreenState extends State<ProviderDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff3f5fd),
      appBar: AppBar(
        title:const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CMS', style: apptitle),
          ],
        ),
        elevation: 0,
        actions: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.notifications_active_outlined, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.person_outline_outlined, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeaderSection(),
          Expanded(
            child: ListView(
              padding:const EdgeInsets.all(16.0),
              children: [
               const SizedBox(height: 20),
                _buildOptionsSection(),
                const SizedBox(height: 20),
                _buildRecentServiceSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildHeaderSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Raja Saravanan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Service Provider", style: TextStyle(color: Colors.blue,fontSize: 16)),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSection() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildOptionCard('Engineers', Icons.engineering, const Color.fromRGBO(237, 134, 134, 0.56)),
        _buildOptionCard('Space', Icons.space_dashboard, const Color.fromRGBO(113, 191, 85, 0.53)),
        _buildOptionCard('Request', Icons.request_page,const Color.fromRGBO(253, 231, 152, 1)),
        _buildOptionCard('Pending', Icons.pending, const Color.fromRGBO(162, 221, 239, 1)),
        _buildOptionCard('Payments', Icons.payment,const Color.fromRGBO(237, 134, 134, 0.56)),
        _buildOptionCard('Settings', Icons.settings, const Color.fromRGBO(246, 203, 249, 1)),
      ],
    );
  }

  Widget _buildOptionCard(String title, IconData icon, Color color) {
    return Card(
      color: color,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.black),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentServiceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Recent Service", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
       const  SizedBox(height: 10),
        _buildServiceCard('Sunade', 'Bike Service', '₹20', 'assets/image1.png'),
        _buildServiceCard('Ram', 'CCTV Fitting', '₹80', 'assets/image2.png'),
        _buildServiceCard('John', 'Car Repair', '₹120', 'assets/image3.png'),
        _buildServiceCard('Sakura', 'Room Cleaning', '₹200', 'assets/image4.png'),
        _buildServiceCard('Sunade', 'Bike Service', '₹20', 'assets/image1.png'),
        _buildServiceCard('Ram', 'CCTV Fitting', '₹80', 'assets/image2.png'),
        _buildServiceCard('John', 'Car Repair', '₹120', 'assets/image3.png'),
        _buildServiceCard('Sakura', 'Room Cleaning', '₹200', 'assets/image4.png'),
      ],
    );
  }

  Widget _buildServiceCard(String name, String service, String price, String imageUrl) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
        ),
        title: Text(name,style: const TextStyle(color: Colors.black),),
        subtitle: Text(service),
        trailing: Text(price,style:const TextStyle(color: Colors.black)),
      ),
    );
  }
}
