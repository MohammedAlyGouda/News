import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_one_flutter_app/layout/news_app/cubit/cubit.dart';
import 'package:new_one_flutter_app/layout/news_app/cubit/states.dart';
import 'package:new_one_flutter_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, stats) {},
      builder: (context, stats) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'search field must be not empty';
                    }
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
