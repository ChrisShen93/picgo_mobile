class GithubSetting {
  String repo;
  String branch;
  String token;
  String path;
  String customUrl;

  // GithubSetting (String repo, String branch, String token, String path, String customUrl) {
  //   this.repo = repo;
  //   this.branch = branch;
  //   this.token = token;
  //   this.path = path;
  //   this.customUrl = customUrl;
  // }
  GithubSetting (this.repo, this.branch, this.token, this.path, this.customUrl);

  Map toJson () {
    Map map = new Map();
    map['repo'] = this.repo;
    map['branch'] = this.branch;
    map['token'] = this.token;
    map['path'] = this.path;
    map['customUrl'] = this.customUrl;
    return map;
  }

  factory GithubSetting.fromJson (Map<String, dynamic> settingJson) {
    return GithubSetting(
      settingJson['repo'],
      settingJson['branch'],
      settingJson['token'],
      settingJson['path'],
      settingJson['customUrl'],
    );
  }
}
