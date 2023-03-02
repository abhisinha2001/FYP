class CCTVModel {
  var ccctv_id;
  var cctv_road;
  late double lat;
  late double long;
  var policy_url;
  var email;
  var photos;
  var permissions;

  // To take JSON as input and create an object
  CCTVModel({double lat = 0, double long = 0}) {
    this.lat = lat;
    this.long = long;
  }
}
