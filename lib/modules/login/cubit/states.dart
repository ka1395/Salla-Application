

import '../../../models/login/shopeLoginModel.dart';

abstract class ShopeLoginStats {}

class ShopeLoginInitialStats extends ShopeLoginStats {}

class ShopeLoginSuccessStats extends ShopeLoginStats {
  final ShopeLoginModel shopLoginData;

  ShopeLoginSuccessStats(this.shopLoginData);
}

class ShopeLoginLoadingStats extends ShopeLoginStats {}

class ShopeLoginErrorStats extends ShopeLoginStats {
  final String error;

  ShopeLoginErrorStats(this.error);
}

class ShopeLoginPasswordVisibiltyStats extends ShopeLoginStats {}
