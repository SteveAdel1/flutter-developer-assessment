import 'package:dartz/dartz.dart';
import '../erros/network_exceptions.dart';

typedef ResultFuture<T> = Future<Either<NetworkExceptions, T>>;

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();
  ResultFuture<T> call(Params params);
}

ResultFuture<T> execute<T>(Future<T> Function() fun) async {
  try {
    final result = await fun();
    return Right(result);
  } catch (_) {
    return const Left(ServerError());
  }
}
