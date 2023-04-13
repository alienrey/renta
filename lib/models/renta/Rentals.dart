import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRentalService {
  final CollectionReference rentalsCollection =
      FirebaseFirestore.instance.collection('rentals');


  Future<void> createRental(Rental rental) async {
    try {
      await rentalsCollection.doc(rental.id).set(rental.toMap());
    } catch (e) {
      print('Error creating rental: $e');
      throw e;
    }
  }
}

class Rental {
  String id;
  String name;
  String description;
  double pricePerDay;
  String ownerId;
  bool isRented;
  String photoLink;

  Rental({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerDay,
    required this.ownerId,
    required this.isRented,
    required this.photoLink,
  });

  // Factory method to create Rental object from a Map
  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      pricePerDay: map['pricePerDay'],
      ownerId: map['ownerId'],
      isRented: map['isRented'],
      photoLink: map['photoLink'],
    );
  }

  // Method to convert Rental object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pricePerDay': pricePerDay,
      'ownerId': ownerId,
      'isRented': isRented,
      'photoLink': photoLink,
    };
  }
}

List<Rental> generateMockups() {
  List<Rental> mockups = [];

  Rental rental1 = Rental(
    id: 'Rental1',
    name: 'Iphone 7+ 32Gb',
    description: 'Good condition slightly used.',
    pricePerDay: 200.0,
    ownerId: 'Owner1',
    isRented: false,
    photoLink: 'https://i.ebayimg.com/images/g/W7UAAOSwzztfu0k1/s-l640.jpg',
  );
  mockups.add(rental1);

  Rental rental2 = Rental(
    id: 'Rental2',
    name: 'MacBook Pro 2018',
    description: 'Gets the job done. No Scratches. Clean.',
    pricePerDay: 350.0,
    ownerId: 'Owner2',
    isRented: true,
    photoLink: 'https://www.cultofmac.com/wp-content/uploads/2016/11/MacBook-Pro-with-Touch-Bar-2-1-350x233@2x.jpg',
  );
  mockups.add(rental2);

  Rental rental3 = Rental(
    id: 'Rental3',
    name: 'Samsung S10 128GB',
    description: 'Issue no sound but everything else is ok.',
    pricePerDay: 80.0,
    ownerId: 'Owner3',
    isRented: false,
    photoLink: 'https://th.bing.com/th/id/OIP.5zky2zpTyRs64s02qBt2nQHaJY?pid=ImgDet&rs=1',
  );
  mockups.add(rental3);

    Rental rental4 = Rental(
    id: 'Rental4',
    name: 'Acer Nitro 5',
    description: 'Good for gaming. Battery is broken though.',
    pricePerDay: 199.0,
    ownerId: 'Owner3',
    isRented: false,
    photoLink: 'https://notebookspec.com/web/wp-content/uploads/2018/08/Acer-Nitro-5-AMD-4.jpg',
  );
  mockups.add(rental4);

  Rental rental5 = Rental(
    id: 'Rental5',
    name: 'Nokia 3310',
    description: 'Very nostalgic to use.',
    pricePerDay: 599.0,
    ownerId: 'Owner3',
    isRented: false,
    photoLink: 'https://th.bing.com/th/id/OIP.7zJTIkbdM2QvLSNbofYLewHaHa?pid=ImgDet&rs=1',
  );
  mockups.add(rental5);

  return mockups;
}