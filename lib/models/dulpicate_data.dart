class ServiceItem {
  final String title;
  final String iconPath;
  final Function() onTap;

  ServiceItem({required this.title, required this.iconPath, required this.onTap});
}

class OfferItem {
  final String title;
  final String description;
  final String imagePath;
  final Function() onTap;

  OfferItem({required this.title, required this.description, required this.imagePath, required this.onTap});
}

class CategoryItem {
  final String name;
  final String iconPath;
  final Function() onTap;

  CategoryItem({required this.name, required this.iconPath, required this.onTap});
}

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String location;
  final String imageUrl;
  final double price; // EGP

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.imageUrl,
    required this.price,
  });
}