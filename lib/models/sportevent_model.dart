class Sportevent {
  final int id;
  final String title;
  final String description;
  final String location;
  final String startDate;
  final String endDate;
  final int maxParticipants;
  final bool isOutdoor;
  final bool registrationOpen;

  Sportevent({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.maxParticipants,
    required this.isOutdoor,
    required this.registrationOpen,
  });

  factory Sportevent.fromJson(Map<String, dynamic> json) {
    return Sportevent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      maxParticipants: json['maxParticipants'],
      isOutdoor: json['isOutdoor'],
      registrationOpen: json['registrationOpen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'maxParticipants': maxParticipants,
      'isOutdoor': isOutdoor,
      'registrationOpen': registrationOpen,
    };
  }
}
