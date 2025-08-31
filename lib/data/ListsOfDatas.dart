import 'countrystopplaces.dart';

class PlacesData {
  final name;
  final imgUrl;
  final location;
  final description;
  final rating;
  final flag;
  final List<PlacesData> places;

  PlacesData({
    required this.name,
    required this.imgUrl,
    required this.flag,
    required this.location,
    required this.description,
    required this.rating,
    required this.places,
  });
}

final List<PlacesData> hotrightnowlist = [
  PlacesData(
    name: 'Bali Beach',
    imgUrl:
        'https://images.pexels.com/photos/9094948/pexels-photo-9094948.jpeg',
    location: 'Indonesia',
    rating: '4.8',
    description: null,
    flag: null,
    places: [],
  ),

  PlacesData(
    name: 'Istanbul City',
    imgUrl:
        'https://images.pexels.com/photos/27705570/pexels-photo-27705570.jpeg',
    location: 'Turkey',
    rating: '5.0',
    description: null,
    flag: null,
    places: [],
  ),

  PlacesData(
    name: 'Venice',
    imgUrl:
        'https://i.pinimg.com/1200x/1c/1e/b6/1c1eb67149c3e3bc8cef02e9c516266a.jpg',
    location: 'Italy',
    rating: '4.5',
    description: null,
    flag: null,
    places: [],
  ),

  PlacesData(
    name: 'Egypt',
    imgUrl:
        'https://i.pinimg.com/736x/d5/61/cb/d561cbb96fb806f40499179f04958f1c.jpg',
    location: 'Misr',
    rating: '4.0',
    description: null,
    flag: null,
    places: [],
  ),

  PlacesData(
    name: 'Blue Mosque',
    imgUrl:
        'https://i.pinimg.com/736x/7c/ff/ef/7cffef675634d9e268a5c8def95e342a.jpg',
    location: 'Turkey',
    rating: '4.3',
    description: null,
    flag: null,
    places: [],
  ),

  PlacesData(
    name: 'Sajek Velly',
    imgUrl:
        'https://i.pinimg.com/736x/8f/81/ec/8f81ec6d7ed97b40b99b60dba6a395c8.jpg',
    location: 'Bangladesh',
    rating: '3.5',
    description: null,
    flag: null,
    places: [],
  ),

  PlacesData(
    name: 'Niagara Falls',
    imgUrl:
        'https://i.pinimg.com/736x/87/65/bc/8765bc048b1d0fdcd6684a4e301fa8c3.jpg',
    location: 'Canada',
    rating: '4.4',
    description: null,
    flag: null,
    places: [],
  ),
]; //used

final List<PlacesData> exploremorelist = [
  PlacesData(
    name: 'Beach',
    imgUrl:
        'https://images.pexels.com/photos/3601422/pexels-photo-3601422.jpeg',
    location: 'Maldives',
    rating: '5.2',
    description: null,
    flag: null,
    places: [],
  ),
  PlacesData(
    name: 'Santorini',
    imgUrl:
        'https://images.pexels.com/photos/1029021/pexels-photo-1029021.jpeg',
    location: 'Greece',
    rating: '5.0',
    description: null,
    flag: null,
    places: [],
  ),
  PlacesData(
    name: 'Banff National Park',
    imgUrl:
        'https://images.pexels.com/photos/33297495/pexels-photo-33297495.jpeg',
    location: 'Canada',
    rating: '4.5',
    description: null,
    flag: null,
    places: [],
  ),
  PlacesData(
    name: 'Machu Picchu',
    imgUrl:
        'https://images.pexels.com/photos/17060849/pexels-photo-17060849.jpeg',
    location: 'Peru',
    rating: '4.0',
    description: null,
    flag: null,
    places: [],
  ),
  PlacesData(
    name: 'Northern Lights in Iceland',
    imgUrl:
        'https://images.pexels.com/photos/11180713/pexels-photo-11180713.jpeg',
    location: 'Norway',
    rating: '4.5',
    description: null,
    flag: null,
    places: [],
  ),
  PlacesData(
    name: 'Plitvice Lakes',
    imgUrl:
        'https://images.pexels.com/photos/17503328/pexels-photo-17503328.jpeg',
    location: 'Croatia',
    rating: '4.7',
    description: null,
    flag: null,
    places: [],
  ),
  PlacesData(
    name: 'Ha Long Bay',
    imgUrl:
        'https://images.pexels.com/photos/4390720/pexels-photo-4390720.jpeg',
    location: 'Vietnam',
    rating: '4.4',
    description: null,
    flag: null,
    places: [],
  ),
]; //used

final List<PlacesData> countrycatagory = [
  PlacesData(
    name: "Dubai",
    imgUrl:
        "https://images.pexels.com/photos/2453295/pexels-photo-2453295.jpeg",
    description:
        "A luxurious city known for its modern architecture and vibrant nightlife.",
    rating: "8.0",
    flag:
        "https://t4.ftcdn.net/jpg/05/18/83/39/360_F_518833985_IGWqx1AnMNsni4CH0CnLbSxqTYhQbvRM.jpg",
    location: null,
    places: dubaitopplaces,
  ),
  PlacesData(
    name: "Indonesia",
    imgUrl:
        "https://images.pexels.com/photos/4090349/pexels-photo-4090349.jpeg",
    description:
        "An archipelago with beautiful beaches and rich cultural heritage.",
    rating: "7.5",
    flag:
        "https://media.gettyimages.com/id/1740659549/video/indonesia-flag-waving-seamless-slow-motion-high-quality-4k.jpg?s=640x640&k=20&c=YrAwCiJDpwC4u4In3UuIdjGBjgZqiwtyy1E-qs3F6e0=",
    location: null,
    places: indonesiatopplaces,
  ),
  PlacesData(
    name: "Jordan",
    imgUrl:
        "https://images.pexels.com/photos/2097855/pexels-photo-2097855.jpeg",
    description:
        "Home to ancient monuments like Petra and stunning desert landscapes.",
    rating: "8.3",
    flag:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNVgC91JRFb3UGVBzH35QMlVI3gm8wNVv4GEMjo9dKdlxBqLlAYrMf-6AyOrD88Bs7kvY&usqp=CAU",
    location: null,
    places: jordantopplaces,
  ),
  PlacesData(
    name: "Italy",
    imgUrl:
        "https://images.pexels.com/photos/4987272/pexels-photo-4987272.jpeg",
    description: "Famous for its art, history, cuisine, and scenic coastlines.",
    rating: "9.0",
    flag:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEBPxpf00iWvlZxFRG8_CiI9PhKnJGvaNWWQ&s",
    location: null,
    places: italytopplaces,
  ),
  PlacesData(
    name: "Portugal",
    imgUrl:
        "https://images.pexels.com/photos/30272791/pexels-photo-30272791.jpeg",
    description:
        "Known for its beautiful beaches, historic cities, and delicious food.",
    rating: "8.2",
    flag:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKdQSxfS8JML0zK_gVnKVocPZoM7BspdaFsg&s",
    location: null,
    places: portugaltopplaces,
  ),
  PlacesData(
    name: "USA",
    imgUrl: "https://images.pexels.com/photos/378570/pexels-photo-378570.jpeg",
    description: "A vast country with diverse landscapes and iconic cities.",
    rating: "8.8",
    flag:
        "https://i.pinimg.com/736x/a9/cf/4a/a9cf4ae1faee0af9b338cb93a43aa316.jpg",
    location: null,
    places: usatopplaces,
  ),
  PlacesData(
    name: "Japan",
    imgUrl:
        "https://images.pexels.com/photos/1440476/pexels-photo-1440476.jpeg",
    description: "A blend of tradition and technology with stunning nature.",
    rating: "9.2",
    flag:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeKjdakGpg8gLhau5MOVdL-REmYoyiIzXccw&s",
    location: null,
    places: japantopplaces,
  ),
  PlacesData(
    name: "Egypt",
    imgUrl:
        "https://images.pexels.com/photos/18991572/pexels-photo-18991572.jpeg",
    description: "Land of ancient pyramids and rich archaeological treasures.",
    rating: "8.5",
    flag:
        "https://t3.ftcdn.net/jpg/00/42/90/78/360_F_42907895_qbW5Aa3T6oEbyBcu8QJ94241lSGd0Fbg.jpg",
    location: null,
    places: egypttopplaces,
  ),
  PlacesData(
    name: "Maldive",
    imgUrl:
        "https://images.pexels.com/photos/3601422/pexels-photo-3601422.jpeg",
    description:
        "Tropical paradise with crystal-clear waters and white sandy beaches.",
    rating: "9.5",
    flag:
        "https://t3.ftcdn.net/jpg/04/75/25/70/360_F_475257008_YKylfsF490rvMpNZxD69WB7bs6z5EcSH.jpg",
    location: null,
    places: maldivetopplaces,
  ),
  PlacesData(
    name: "Australia",
    imgUrl:
        "https://images.pexels.com/photos/5707602/pexels-photo-5707602.jpeg",
    description:
        "Known for its unique wildlife and beautiful natural landscapes.",
    rating: "8.7",
    flag:
        "https://t3.ftcdn.net/jpg/08/48/73/26/360_F_848732634_yRmx9HKhd1seyXuTHoceSEM6rgBfe3sv.jpg",
    location: null,
    places: austreliatopplaces,
  ),
]; //used
