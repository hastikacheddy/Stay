class HotelList {
  var savedHotels = {'4'};

  Map<String, Map<String, String>> getHotelList() {
    var hotels = {
      '1': {
        'name': 'LUX Grand Baie Hotel',
        'price': '2000',
        'picture': 'img/lux.jpg',
        'location': 'Grand Baie',
        'rating': '4.5'
      },
      '2': {
        'name': 'Jalsa Beach Hotel',
        'price': '1500',
        'picture': 'img/jalsa.jpg',
        'location': 'Poste Lafayette',
        'rating': '4.2'
      },
      '3': {
        'name': 'Royal Palm Hotel ',
        'price': '3000',
        'picture': 'img/palm.jpg',
        'location': 'Grand Baie',
        'rating': '4.8'
      },
      '4': {
        'name': 'Riu Hotel',
        'price': '1900',
        'picture': 'img/riu.jpg',
        'location': 'Le Morne',
        'rating': '4.6'
      },
    };

    return hotels;
  }

  Map<String, Map<String, String>> getBestOffers() {
    var hotels = {
      '1': {
        'name': 'Riu Hotel',
        'price': '1900',
        'picture': 'img/riu.jpg',
        'location': 'Le Morne',
        'rating': '4.6'
      },
      '2': {
        'name': 'Royal Palm Hotel ',
        'price': '3000',
        'picture': 'img/palm.jpg',
        'location': 'Grand Baie',
        'rating': '4.8'
      },
      '3': {
        'name': 'Jalsa Beach Hotel',
        'price': '1500',
        'picture': 'img/jalsa.jpg',
        'location': 'Poste Lafayette',
        'rating': '4.2'
      },
    };

    return hotels;
  }

  Map<String, Map<String, String>> searchHotels(String searchKey) {
    RegExp regExp = new RegExp(
      searchKey,
      caseSensitive: false,
      multiLine: false,
    );

    Map<String, Map<String, String>> resultMap = Map.from(getHotelList())
      ..removeWhere(
          (k, v) => !regExp.hasMatch(v['name'].toString().toLowerCase()));

    return resultMap;
  }

  Set<String> getSavedHotels() {
    return savedHotels;
  }

  void setSavedHotels(String id) {
    savedHotels.add(id);
  }

  List<String>? getHotelPictures(String id) {
    var hotels = {
      '1': ["img/lux.jpg", "img/lux1.jpg", "img/lux2.jpg"],
      '2': ["img/jalsa.jpg", "img/jalsa1.jpg", "img/jalsa2.jpg"],
      '3': ["img/palm.jpg", "img/palm1.jpg", "img/palm2.jpg"],
      '4': ["img/riu.jpg", "img/riu1.jpg", "img/riu2.jpg"],
    };

    print(hotels[id]);
    return hotels[id];
  }
}
