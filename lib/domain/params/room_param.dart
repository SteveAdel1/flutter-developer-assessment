class RoomParams {
  final int page;
  final int? countryId;
  final bool simulateError;

  const RoomParams({
    required this.page,
    this.countryId,
    this.simulateError = false,
  });
}
