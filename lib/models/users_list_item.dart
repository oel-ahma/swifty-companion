// Main User class
class UsersListItem {
  final int id;
  final String email;
  final String login;
  final String firstName;
  final String lastName;
  final String usualFullName;
  final String? usualFirstName;
  final String url;
  final String phone;
  final String displayName;
  final String kind;
  final Image image;
  final bool staff;
  final int correctionPoint;
  final String poolMonth;
  final String poolYear;
  final String? location;
  final int wallet;
  final DateTime anonymizeDate;
  final DateTime dataErasureDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? alumnizedAt;
  final bool alumni;
  final bool active;

  UsersListItem({
    required this.id,
    required this.email,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.usualFullName,
    this.usualFirstName,
    required this.url,
    required this.phone,
    required this.displayName,
    required this.kind,
    required this.image,
    required this.staff,
    required this.correctionPoint,
    required this.poolMonth,
    required this.poolYear,
    this.location,
    required this.wallet,
    required this.anonymizeDate,
    required this.dataErasureDate,
    required this.createdAt,
    required this.updatedAt,
    this.alumnizedAt,
    required this.alumni,
    required this.active,
  });

  // Factory method to create a UsersListItem from a JSON map
  factory UsersListItem.fromJson(Map<String, dynamic> json) {
    return UsersListItem(
      id: json['id'],
      email: json['email'],
      login: json['login'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      usualFullName: json['usual_full_name'],
      usualFirstName: json['usual_first_name'],
      url: json['url'],
      phone: json['phone'],
      displayName: json['displayname'],
      kind: json['kind'],
      image: Image.fromJson(json['image']),
      staff: json['staff?'],
      correctionPoint: json['correction_point'],
      poolMonth: json['pool_month'],
      poolYear: json['pool_year'],
      location: json['location'],
      wallet: json['wallet'],
      anonymizeDate: DateTime.parse(json['anonymize_date']),
      dataErasureDate: DateTime.parse(json['data_erasure_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      alumnizedAt: json['alumnized_at'],
      alumni: json['alumni?'],
      active: json['active?'],
    );
  }
}

// Image class
class Image {
  final String link;
  final ImageVersions versions;

  Image({
    required this.link,
    required this.versions,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      link: json['link'],
      versions: ImageVersions.fromJson(json['versions']),
    );
  }
}

// ImageVersions class
class ImageVersions {
  final String large;
  final String medium;
  final String small;
  final String micro;

  ImageVersions({
    required this.large,
    required this.medium,
    required this.small,
    required this.micro,
  });

  factory ImageVersions.fromJson(Map<String, dynamic> json) {
    return ImageVersions(
      large: json['large'],
      medium: json['medium'],
      small: json['small'],
      micro: json['micro'],
    );
  }
}
