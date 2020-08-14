extension SafeAccess<E> on List<E> {
  E firstOrNull() => isNotEmpty ? first : null;
}