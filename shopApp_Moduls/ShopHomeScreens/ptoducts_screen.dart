import 'package:abdullaa/lay_out/shop_layout/cubit/cubit.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/models/ShopModelss/CategortModel.dart';
import 'package:abdullaa/models/ShopModelss/HomeModel.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavDataState)
          {
            if(!state.model.status!)
            {
              showToast(text: state.model.message!, state: ToastStates.ERROR);

            }
            else{
             showToast(text: state.model.message!,state: ToastStates.SUCCESS );
            }
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => productBuilder(
                ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!,context),
          );
        });
  }
}

Widget productBuilder(HomeModel? model, CategoriesModel? categoriesModel ,context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model?.data?.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: (Duration(seconds: 1)),
                reverse: false,
                initialPage: 0,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoryIte(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 12,
                      ),
                      itemCount: categoriesModel!.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.count(
              crossAxisSpacing: 2,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.58,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                model!.data!.products.length,
                (index) => buildGridView(model.data?.products[index], context),
              ),
            ),
          ],
        ),
      ),
    );
Widget buildCategoryIte(DataModel model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
              '${model.image}'),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.8),
          child: Text(
            textAlign: TextAlign.center,
            '${model.name}',
            style: TextStyle(
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
Widget buildGridView(ProductsModel? model , context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model?.image}'),
                width: double.infinity,
                height: 200,
              ),
              if (model?.discount != 0)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model?.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model?.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model?.discount != 0)
                      Text(
                        '${model?.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopCubit.get(context).changeFavorite(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favourite[model!.id]??  false ? Colors.purple:Colors.grey[300],
                          child: Icon(
                            Icons.favorite_border,
                            size: 12,
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
