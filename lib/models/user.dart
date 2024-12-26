class User {
  final String fullName;
  final String phone;
  final String email;
  final String imageLink;
  final String login;
  final double level;
  final List<Skill> skills;
  final List<Project> projects;
  final DateTime? blackHole;
  final DateTime createdAt;
  final int correctionPoint;
  final int wallet;

  User({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.imageLink,
    required this.login,
    required this.createdAt,
    required this.level,
    required this.skills,
    required this.correctionPoint,
    required this.wallet,
    required this.projects,
    this.blackHole,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    double level = 0;
    List<dynamic> cursusUsers = json['cursus_users'];
    List<Skill> skills = [];
    DateTime? blackHole;
    for (var cursusUser in cursusUsers) {
      if (cursusUser['cursus']['slug'] == '42cursus') {
        level = cursusUser['level'];
        blackHole = DateTime.tryParse(cursusUser['blackholed_at'] ?? "lol");
        for (var skill in cursusUser['skills']) {
          skills.add(Skill.fromJson(skill));
        }
      }
    }

    return User(
      fullName: json['usual_full_name'],
      email: json['email'],
      phone: json['phone'],
      login: json['login'],
      imageLink: json['image']['link'],
      createdAt: DateTime.parse(json['created_at']),
      level: level,
      projects: (json['projects_users'] as List)
          .map((data) => Project.fromJson(data))
          .toList(),
      correctionPoint: json['correction_point'],
      blackHole: blackHole,
      wallet: json['wallet'],
      skills: skills,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'imageLink': imageLink,
      'login': login,
      'level': level,
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'projects': projects.map((project) => project.toJson()).toList(),
      'blackHole': blackHole?.toIso8601String(), // Convert DateTime to String
      'createdAt': createdAt.toIso8601String(),
      'correctionPoint': correctionPoint,
      'wallet': wallet
    };
  }
}

class Skill {
  final String name;
  final double level;

  Skill({required this.name, required this.level});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json['name'], level: json['level']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
    };
  }
}

class Project {
  final String name;
  final int mark;
  final DateTime dateTime;
  final String status;
  final int retried;

  Project({
    required this.name,
    required this.mark,
    required this.status,
    required this.retried,
    required this.dateTime,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        name: json['project']['name'],
        mark: json['final_mark'] ?? 0,
        status: json['status'],
        retried: json['occurrence'],
        dateTime: DateTime.parse(json['updated_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mark': mark,
      'status': status,
      'retried': retried,
      'dateTime': dateTime.toIso8601String(), // Convert DateTime to String
    };
  }
}
