import 'package:get/route_manager.dart';

import 'ar.dart';
import 'en.dart';
// import 'other.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
