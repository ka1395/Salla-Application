import '../../../models/login/shopeLoginModel.dart';

abstract class ShopeRegisterStats {}
class ShopeRegisterInitialStats extends ShopeRegisterStats {}



class ShopeRegisterSuccessStats extends ShopeRegisterStats {
  final ShopeLoginModel shopRegisterData;

  ShopeRegisterSuccessStats(this.shopRegisterData);
}

class ShopeRegisterLoadingStats extends ShopeRegisterStats {}

class ShopeRegisterErrorStats extends ShopeRegisterStats {
  final String error;

  ShopeRegisterErrorStats(this.error);
}

class ShopeRegisterPasswordVisibiltyStats extends ShopeRegisterStats {}
