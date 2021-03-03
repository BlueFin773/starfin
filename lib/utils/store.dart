import 'package:starfin/model/location.dart';
// rating order: [culture, nature, entertainment, historical, architecture]
List<Location> getLocations() {
  return [
    Location(
      id: '0',
      name: 'Ripley’s Aquarium',
      description: 'Expansive, modern aquarium with many species & habitats on display, plus events & classes.',
      address: '288 Bremner Blvd, Toronto, ON M5V 3L9',
      lat: 43.642497725323416,
      lng: -79.38596402104402,
      imageURL: 'https://lh5.googleusercontent.com/p/AF1QipN5bXUCUExzjzI3IdD7EHPkDhJuQsYu2I5rZ0jd=w426-h240-k-no',
      rating:[2,9,5,2,3],
      selected: false,

    ),
    Location(
      id: '1',
      name: 'Toronto Island Park',
      description: 'Scenic vistas of the Toronto skyline are a main attraction at this lush, grassy recreation area.',
      address: 'JJFG+24 Toronto, Ontario',
      lat: 43.62296043164721,
      lng: -79.37461157375452,
      imageURL: 'https://lh5.googleusercontent.com/p/AF1QipOgNo1HANwMlk_x34A98vyq9AUIcW1N0ABdvk27=w408-h278-k-no',
      rating:[4,9,5,2,6],
      selected: false,

    ),

    Location(
      id: '2',
      name: 'name2',
      description: 'description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2description2',
      address: 'address2',
      lat: 43.642816,
      lng: -79.367424,
      imageURL: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f197f4922b3f26ed3f4e3e66a113b67b&auto=format&fit=crop&w=1050&q=80',
      rating:[1,1,10,1,1],
      selected: false,

    ),
    Location(
      id: '3',
      name: 'name3',
      description: 'description3',
      address: 'address3',
      lat: 43.644134,
      lng: -79.379320,
      imageURL: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f197f4922b3f26ed3f4e3e66a113b67b&auto=format&fit=crop&w=1050&q=80',
      rating:[1,1,1,10,1],
      selected: false,

    ),
    Location(
      id: '4',
      name: 'name4',
      description: 'description4',
      address: 'address4',
      lat: 43.639610,
      lng: -79.381990,
      imageURL: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f197f4922b3f26ed3f4e3e66a113b67b&auto=format&fit=crop&w=1050&q=80',
      rating:[1,1,1,1,10],
      selected: false,

    ),
    Location(
      id: '5',
      name: 'name5',
      description: 'description5',
      address: 'address5',
      lat: 43.641982,
      lng: -79.387088,
      imageURL: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f197f4922b3f26ed3f4e3e66a113b67b&auto=format&fit=crop&w=1050&q=80',
      rating:[1,1,1,1,1],
      selected: false,

    ),
    Location(
      id: '6',
      name: 'name6',
      description: 'description6',
      address: 'address6',
      lat: 43.655025,
      lng: -79.380594,
      imageURL: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f197f4922b3f26ed3f4e3e66a113b67b&auto=format&fit=crop&w=1050&q=80',
      rating:[1,1,1,1,1],
      selected: false,

    ),
    Location(
      id: '7',
      name: 'name7',
      description: 'description7',
      address: 'address7',
      lat: 43.622083,
      lng: -79.395767,
      imageURL: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f197f4922b3f26ed3f4e3e66a113b67b&auto=format&fit=crop&w=1050&q=80',
      rating:[1,1,1,1,1],
      selected: false,

    ),

  ];
}

  List<String> getSelectedIDs(){
    return [

    ];
  }
