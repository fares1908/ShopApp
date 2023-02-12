import 'package:abdullaa/moduls/web/web_view_screen.dart';
import 'package:abdullaa/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../lay_out/shop_layout/cubit/cubit.dart';

Widget defultbutton({
  double width = double.infinity,
  Color backqround = Colors.blue,
  required String text,
  required Function function,
}) =>
    Container(
      color: Colors.blue,
      width: width,
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(text),
      ),
    );
Widget deflutformfield({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData icon,
  required FormFieldValidator validate,
  bool isPassword = false,
  IconData? sofix,
  Function? suffixPressed,
  onTap,
  onChange,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (String value) {
        print(value);
      },
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(label),
        suffixIcon: sofix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  sofix,
                ))
            : null,
        prefixIcon: Icon(icon),
      ),
    );
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      background: Container(
        color: Colors.teal,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              color: Colors.teal,
              width: 70,
              height: 70,
              child: Center(
                child: Text(
                  '${model['time']}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).updateData(
                      status: "Done",
                      id: model['id'],
                    );
                  },
                  icon: Icon(
                    Icons.check_box,
                    color: Colors.teal,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).updateData(
                      status: "Archive",
                      id: model['id'],
                    );
                  },
                  icon: Icon(
                    Icons.archive,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onDismissed: ((direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      }),
    );
Widget buildarticalitem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, Web_View(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    '${article['urlToImage']}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => buildarticalitem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
      ),
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
void navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(

        builder: (context) => widget,

      ),
    );

void navigatAndfinshed(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  SUCCESS,
  ERROR,
  WARING,
}
Color ? chooseToastColor(ToastStates state){
  Color color;
  switch(state) {
    case ToastStates.SUCCESS:
      color =Colors.green;
      break;

    case ToastStates.WARING:
      color=Colors.amber;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;

  }
  return color;

}
Widget buildProductItems( model, context,{bool inSearch=true}) => Padding(

  padding: const EdgeInsets.all(20.0),

  child: Container(

    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage((model.image)!),
              width: 120,
              height: 120,
            ),
            if((model.discount) != 0&&inSearch==true)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((model.name)!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text((model.price.toString()),
                    style: TextStyle(
                        fontSize: 12,
                        color:Colors.purple,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if((model.discount) != 0&&inSearch==true)
                    Text(model.discount.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),

                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorite(
                          (model.id)!
                      );
                      // print(model.id);
                    },
                    icon: CircleAvatar(
                        backgroundColor: ShopCubit
                            .get(context).favourite[model!.id]?? false  ? Colors.purple
                            : Colors.grey[300],
                        radius: 15,
                        child: Icon(Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
