import 'package:flutter_bloc/flutter_bloc.dart';

extension EmitterExt on Emitter {
  void async<S>(Stream<S> stream) => forEach<S>(
        stream,
        onData: (state) => state,
      );
}
