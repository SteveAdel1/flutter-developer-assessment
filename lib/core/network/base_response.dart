class BaseResponse<T> {
  final T? data;
  final PaginationMeta? paginates;

  const BaseResponse({this.data, this.paginates});
}

class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int total;

  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}
