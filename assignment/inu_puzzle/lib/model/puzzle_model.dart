class DogImage {
  final String message;
  final String status;

  DogImage({required this.message, required this.status});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(message: json['message'], status: json['status']);
  }
}
