import 'package:flutter/material.dart';
import 'package:news_app/injection_container.dart';
import 'package:news_app/src/features/home/view/state/search_query_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  ///
  final SearchQueryBloc bloc = sl<SearchQueryBloc>();
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        bloc.searchQuerySink(query);
      },
      style: const TextStyle(
        letterSpacing: 1.2,
        fontFamily: 'Medium',
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        hintText: 'News Search',
        fillColor: Colors.grey.shade100,
        filled: true,
        suffixIconConstraints:
            const BoxConstraints(minHeight: 52, minWidth: 100),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
      ),
    );
  }
}
