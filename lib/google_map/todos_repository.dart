import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracker/google_map/firebase_todos_repositoy.dart';
import 'package:device_tracker/google_map/models/location_model.dart';

class LocationRepository extends LocRep{
  final FirebaseFirestore _firebaseFirestore;

  LocationRepository({FirebaseFirestore? firebaseFirestore}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<LocationModel>> getLocation() {
    return _firebaseFirestore.collection('Location').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => LocationModel.fromSnapshot(doc)).toList();
    });
  }
}