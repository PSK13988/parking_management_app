abstract class UsecaseWithParam<Type, Params> {
  const UsecaseWithParam();

  Future<Type> call(Params params);
}
