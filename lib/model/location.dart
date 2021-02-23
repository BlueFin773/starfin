
class Location {
  final String id;
  final String name;
  final String description;
  final String address;
  final double lat;
  final double lng;
  final String imageURL;
  final List<int> rating;
   bool selected;

   Location({
     this.id,
     this.name,
     this.description,
     this.address,
     this.lat,
     this.lng,
     this.imageURL,
     this.selected,
     this.rating
  });

  @override
  String toString() {
    return '{ ${this.id}, ${this.address}, ${this.rating} }';
  }

}