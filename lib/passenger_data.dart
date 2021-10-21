class PassengerData {
  int totalPassengers;
  int totalPages;
  List<Data> data;

  PassengerData({
      this.totalPassengers, 
      this.totalPages, 
      this.data});

  PassengerData.fromJson(dynamic json) {
    totalPassengers = json['totalPassengers'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['totalPassengers'] = totalPassengers;
    map['totalPages'] = totalPages;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  String id;
  String name;
  int trips;
  List<Airline> airline;
  int v;

  Data({
      this.id, 
      this.name, 
      this.trips, 
      this.airline, 
      this.v});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    trips = json['trips'];
    if (json['airline'] != null) {
      airline = [];
      json['airline'].forEach((v) {
        airline.add(Airline.fromJson(v));
      });
    }
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['trips'] = trips;
    if (airline != null) {
      map['airline'] = airline.map((v) => v.toJson()).toList();
    }
    map['__v'] = v;
    return map;
  }

}

class Airline {
  int id;
  String name;
  String country;
  String logo;
  String slogan;
  String headQuaters;
  String website;
  String established;

  Airline({
      this.id, 
      this.name, 
      this.country, 
      this.logo, 
      this.slogan, 
      this.headQuaters, 
      this.website, 
      this.established});

  Airline.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    slogan = json['slogan'];
    headQuaters = json['head_quaters'];
    website = json['website'];
    established = json['established'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country'] = country;
    map['logo'] = logo;
    map['slogan'] = slogan;
    map['head_quaters'] = headQuaters;
    map['website'] = website;
    map['established'] = established;
    return map;
  }

}