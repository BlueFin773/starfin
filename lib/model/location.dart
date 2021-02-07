
class Location {
  final String id;
  final String name;
  final String description;
  final String address;
  final String imageURL;
   bool selected;

   Location({
    this.id,
    this.name,
    this.description,
    this.address,
    this.imageURL,
    this.selected
  });

  @override
  String toString() {
    return '{ ${this.id}, ${this.address} }';
  }

}