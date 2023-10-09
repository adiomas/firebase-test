import 'package:firebase_test/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final class GenericErrorResolver implements ErrorResolver {
  final String? failureTitle;

  const GenericErrorResolver({this.failureTitle});

  @override
  Failure resolve<T>(Object err, [StackTrace? stackTrace]) {
    final message = err is String ? err : S.current.unknown_error_occurred;
    return Failure.generic(
      title: failureTitle ?? message,
      error: err,
      stackTrace: stackTrace,
    );
  }
}
