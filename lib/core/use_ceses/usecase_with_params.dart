import 'dart:async';
import 'dart:io';

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
  } on TimeoutException {
    return const Left(RequestTimeout());
  } on SocketException {
    return const Left(NoInternetConnection());
  } on FormatException {
    return const Left(BadRequest('Invalid format'));
  } catch (e) {
    // Ideally we log the error here
    return const Left(ServerError());
  }
}
