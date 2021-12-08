abstract class BaseDao<T> {
  Future<void> connect(String path);

  Future<List<T>> getAll();

  Future<T> add(T item);

  Future<void> addAll(List<T> list);

  Future<T> update(T item);

  Future<void> delete(T item);

  Future<void> deleteAll();

  Future<void> close();

  int getLastId(List<T> list);
}
