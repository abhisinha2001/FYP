class CCTVModel {
  num cctv_id;
  String cctv_road;
  double lat;
  double long;
  String policy_url;
  String email;
  var photos;
  var permissions;

  CCTVModel(this.cctv_id, this.lat, this.long,
      {this.policy_url = "default",
      this.email = "default",
      this.photos = "default",
      this.permissions = "default",
      this.cctv_road = "default"});
}
