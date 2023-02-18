abstract class SearchStats{}


class SearchInitialStats extends SearchStats {}


class SearchSuccessStats extends SearchStats {}

class SearchLoadingStats extends SearchStats {}

class SearchErrorStats extends SearchStats {
  final Error;

  SearchErrorStats(this.Error);
}
