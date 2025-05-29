import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';

class ServiceItem {
  final String title;
  final IconData
  icon; // Using IconData for simplicity, replace with imagePath if needed
  final Function() onTap;

  ServiceItem({required this.title, required this.icon, required this.onTap});
}

class OfferItem {
  final String title;
  final String description;
  final String imageUrl; // Using network image for example
  final Function() onTap;

  OfferItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });
}

class CategoryItem {
  final String name;
  final IconData icon; // Using IconData for simplicity
  final Function() onTap;

  CategoryItem({required this.name, required this.icon, required this.onTap});
}

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String location;
  final String imageUrl;
  final double price;
  final double discountPrice;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.discountPrice
  });
}

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  final List<ServiceItem> services = [
    ServiceItem(
      title: 'Clinic appointment',
      icon: Icons.local_hospital,
      onTap: () => Get.snackbar('Service', 'Clinic appointment tapped!'),
    ),
    ServiceItem(
      title: 'Online appointment',
      icon: Icons.video_call,
      onTap: () => Get.snackbar('Service', 'Online appointment tapped!'),
    ),
  ];

  final List<OfferItem> offers = [
    OfferItem(
      title: 'Hello Doctor!',
      description: 'Offer 50% off for your first video call with your doctor.',
      imageUrl: 'assets/offer1.png',
      onTap: () => Get.snackbar('Offer', 'Get offer tapped!'),
    ),
    OfferItem(
      title: 'Dental Checkup',
      description: 'Free dental checkup for new patients.',
      imageUrl: 'assets/offer2.png',
      onTap: () => Get.snackbar('Offer', 'Dental offer tapped!'),
    ),
    // Add more offers as needed
  ];

  final List<CategoryItem> categories = [
    CategoryItem(
      name: 'Cardiology',
      icon: Icons.favorite,
      onTap: () => Get.snackbar('Category', 'Cardiology tapped!'),
    ),
    CategoryItem(
      name: 'Neurology',
      icon: Icons.psychology,
      onTap: () => Get.snackbar('Category', 'Neurology tapped!'),
    ),
    CategoryItem(
      name: 'Dermatology',
      icon: Icons.accessibility,
      onTap: () => Get.snackbar('Category', 'Dermatology tapped!'),
    ),
    CategoryItem(
      name: 'Pulmonology',
      icon: Icons.lens, // Placeholder, use a real lung icon if available
      onTap: () => Get.snackbar('Category', 'Pulmonology tapped!'),
    ),
    CategoryItem(
      name: 'Surgery',
      icon: Icons.content_cut,
      onTap: () => Get.snackbar('Category', 'Surgery tapped!'),
    ),
    CategoryItem(
      name: 'Nephrology',
      icon: Icons.water, // Placeholder
      onTap: () => Get.snackbar('Category', 'Nephrology tapped!'),
    ),
  ];

  final List<Doctor> topDoctors = [
    Doctor(
      name: 'Dr. Omera Khalefa',
      specialty: 'General Practitioner',
      rating: 4.9,
      reviews: 380,
      location: '6th of October City',
      imageUrl: 'assets/dermatologist.png',
      discountPrice: 10,
      price: 380,
    ),
    Doctor(
      name: 'Dr. Savene Revor',
      specialty: 'Cardiologist',
      rating: 4.9,
      reviews: 700,
      location: 'Dokki - Maadi',
      imageUrl: 'assets/cardiologist.png',
      discountPrice: 0,
      price: 400,
    ),
    Doctor(
      name: 'Dr. Samira Ali',
      specialty: 'Pediatrician',
      rating: 4.8,
      reviews: 600,
      location: 'Zamalek - Mohandessin',
      imageUrl: 'assets/pediatrician.png',
      discountPrice: 0,
      price: 600,
    ),
    Doctor(
      name: 'Dr. Hassan Mahmoud',
      specialty: 'Orthopedic Surgeon',
      rating: 4.7,
      reviews: 350,
      location: 'New Cairo - Nasr City',
      imageUrl: 'assets/orthopedician.png',
      discountPrice: 0,
      price: 450,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final User? currentUser = authController.currentUser.value;
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            currentUser?.profileImageUrl != null
                                ? NetworkImage(currentUser!.profileImageUrl!)
                                : const AssetImage(
                                      'assets/profile_placeholder.png',
                                    )
                                    as ImageProvider, // Placeholder
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${currentUser?.name ?? 'Guest'}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'How are you today?',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.notifications_none, size: 30),
                        onPressed: () {
                          Get.snackbar('Notification', 'No new notifications');
                        },
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for Doctor',
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.filter_list, color: Colors.grey),
                        onPressed: () {
                          Get.snackbar('Search', 'Filter options pressed!');
                        },
                      ),
                    ),
                    onSubmitted: (query) {
                      Get.snackbar('Search', 'Searching for: $query');
                    },
                  ),
                ),
                const SizedBox(height: 25),

                const Text(
                  'Our Services',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      services
                          .map((service) => _buildServiceCard(service))
                          .toList(),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Offers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.snackbar('Offers', 'See All Offers pressed!');
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 160, // Height for the horizontal scroll view
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      return _buildOfferCard(offers[index]);
                    },
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.snackbar(
                          'Categories',
                          'See All Categories pressed!',
                        );
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length ~/ 2,
                        itemBuilder: (context, index) {
                          return _buildCategoryCard(categories[index]);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length ~/ 2,
                        itemBuilder: (context, index) {
                          return _buildCategoryCard(categories[index + (categories.length ~/ 2)]);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Doctors',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.snackbar('Doctors', 'See All Doctors pressed!');
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children:
                      topDoctors
                          .map((doctor) => _buildDoctorCard(doctor))
                          .toList(),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildServiceCard(ServiceItem service) {
    return GestureDetector(
      onTap: service.onTap,
      child: Container(
        width: Get.width * 0.4,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(service.icon, size: 30, color: Colors.blueAccent),
            const SizedBox(height: 10),
            Text(
              service.title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(OfferItem offer) {
    return Container(
      width: 310,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  offer.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  offer.description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: offer.onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 0,
                    ),
                  ),
                  child: const Text(
                    'Get offer',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Image.asset(offer.imageUrl, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(CategoryItem category) {
    return Container(
      width: 170,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(category.icon, size: 30, color: Colors.blueAccent),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              category.name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  doctor.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              // Doctor details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doctor.specialty,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          '${doctor.rating} (${doctor.reviews} Reviews)',
                          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey, size: 16),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            doctor.location,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.favorite_border, color: Colors.red),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _buildPriceInfo(doctor),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(Doctor doctor) {
    if (doctor.discountPrice == 0) {
      return Text(
        '${doctor.price.toInt()}\$',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      );
    } else {
      var finalPrice = doctor.price;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${doctor.price.toInt()}\$',
            style: const TextStyle(
              fontSize: 9,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '${finalPrice.toInt()}\$',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      onTap: (index) {
        String tabName = '';
        switch (index) {
          case 0:
            tabName = 'Home';
            break;
          case 1:
            tabName = 'Bookings';
            break;
          case 2:
            tabName = 'Chat';
            break;
          case 3:
            tabName = 'Favorites';
            break;
          case 4:
            tabName = 'Logout';
            authController
                .logout();
            break;
        }
        if (index != 4) {
          Get.snackbar('Navigation', '$tabName Tab Tapped!');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Logout',
        ),
      ],
    );
  }
}
