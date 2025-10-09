class PlaceSuggestion {
  final String placeId;
  final String label;
  final String title;
  final String? country;
  final String? region;
  final String? postalCode;
  final double? lat;
  final double? lon;

  PlaceSuggestion({
    required this.placeId,
    required this.label,
    required this.title,
    this.country,
    this.region,
    this.postalCode,
    this.lat,
    this.lon,
  });

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      title: json['title'] as String,
      placeId: json['placeId'] as String,
      label: json['label'] as String,
      country: json['country'] as String?,
      region: json['region'] as String?,
      postalCode: json['postalCode'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );
  }
}
