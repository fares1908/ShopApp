import 'package:abdullaa/moduls/shopApp/search/SearchState.dart';
import 'package:abdullaa/moduls/shopApp/search/cubite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/compounant/compounts.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(ShopSearchInitialState()),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    deflutformfield(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'search must not be empty';
                          }
                          return null;
                        },
                        label: 'Search',
                        icon: Icons.search,
                        onChange: (String text) {
                        if(formKey.currentState!.validate()){
                             SearchCubit.get(context).getSearch(text);
                        }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is ShopSearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    if(state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildProductItems(SearchCubit.get(context).searchModel!.data!.data[index] ,context ,inSearch: false),
                          separatorBuilder:(context, index) =>myDivider(),
                          itemCount:SearchCubit.get(context).searchModel!.data!.data.length ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
