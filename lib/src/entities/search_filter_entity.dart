import 'package:bibcujae/src/features/search/constants/constants.dart';

class SearchFilter {
  final String category;
  final SearchFilterOption option;
  final String value;

  SearchFilter({
    required this.category,
    required this.option,
    required this.value,
  });

  SearchFilter copyWith({
    String? category,
    SearchFilterOption? option,
    String? value,
  }) {
    return SearchFilter(
      category: category ?? this.category,
      option: option ?? this.option,
      value: value ?? this.value,
    );
  }
}
