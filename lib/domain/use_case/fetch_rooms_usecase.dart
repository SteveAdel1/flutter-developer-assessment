import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../core/erros/network_exceptions.dart';
import '../../core/use_ceses/usecase_with_params.dart';
import '../entities/room_entity.dart';
import '../../core/network/base_response.dart';
import '../params/room_param.dart';

class FetchRoomsUseCase
    extends UseCaseWithParams<BaseResponse<List<RoomEntity>>, RoomParams> {
  const FetchRoomsUseCase();

  @override
  ResultFuture<BaseResponse<List<RoomEntity>>> call(RoomParams params) async {
    await Future.delayed(const Duration(seconds: 1));

    if (params.simulateError) {
      return const Left(ServerError());
    }

    final rooms = List.generate(
      20,
      (i) => RoomEntity(
        id: (params.page - 1) * 20 + i,
        roomName: 'Room ${(params.page - 1) * 20 + i}',
        visitorsCount: (i + 1) * 10,
        isLive: i % 3 == 0,
      ),
    );
    return Right(BaseResponse(
      data: rooms,
      paginates: PaginationMeta(
        currentPage: params.page,
        lastPage: 5,
        total: 100,
      ),
    ));
  }
}
