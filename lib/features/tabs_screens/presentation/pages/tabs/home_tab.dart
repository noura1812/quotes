import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/core/utils/text_styles.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

import 'package:quotes/features/tabs_screens/presentation/cubit/tabs_screens_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabsScreensCubit, TabsScreensState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<QuotesDataEntity> quotes =
            TabsScreensCubit.get(context).remoteQuotesList;

        if (state is TabsScreensGetDataRemoteFailureState) {
          return Center(
            child: Text(state.failures.toString()),
          );
        }
        if (state is TabsScreensGetDataLoadingState || quotes.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          itemCount: quotes.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 100,
                  child: Image.network(
                    quotes[index].image!.largeImageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  color: Colors.grey.withOpacity(.4),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quotes[index].quote!.quote ?? '',
                        style: poppins26W400().copyWith(color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        '-${quotes[index].quote!.author}',
                        style: poppins22W400().copyWith(color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black.withOpacity(.7),
                    width: MediaQuery.of(context).size.width,
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_left_outlined,
                              size: 40.h,
                            )),
                        IconButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove(Constants.cachedFaveQuotes);
                            },
                            icon: Icon(
                              Icons.copy,
                              size: 40.h,
                            )),
                        IconButton(
                            onPressed: () {
                              TabsScreensCubit.get(context).addToFav(index);
                            },
                            icon: quotes[index].favorite == true
                                ? Icon(
                                    Icons.favorite,
                                    size: 40.h,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    size: 40.h,
                                  )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 40.h,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
