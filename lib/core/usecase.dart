abstract class UsecaseWithParam<Type, Params> {
  const UsecaseWithParam();

  Future<Type> call(Params params);
}

abstract class UsecaseNoParams<Type> {
  const UsecaseNoParams();

  Future<Type> call();
}
