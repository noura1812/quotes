import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/functions/lumination.dart';
import 'package:quotes/core/utils/text_styles.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

import 'package:quotes/features/tabs_screens/presentation/cubit/tabs_screens_cubit.dart';

class HomeTab extends StatefulWidget {
  HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int page = 0;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    // Setup the listener.
    scrollController.addListener(() {
      if (scrollController.offset % MediaQuery.of(context).size.width == 0) {
        page++;
        if (page % 2 == 0) {
          print('new');
          TabsScreensCubit.get(context).getQuotesData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabsScreensCubit, TabsScreensState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<QuotesDataEntity> quotes =
            TabsScreensCubit.get(context).remoteQuotesList;

        if (state is TabsScreensGetDataRemoteFailureState && quotes.isEmpty) {
          return Center(
            child: Text(state.failures.toString()),
          );
        }
        if (state is TabsScreensGetDataLoadingState && quotes.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          controller: scrollController,
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
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: calculateLuminance()
                        ? Colors.black.withOpacity(.7)
                        : Colors.white.withOpacity(.7),
                    width: MediaQuery.of(context).size.width,
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible: index != 0,
                          child: IconButton(
                              onPressed: () {
                                scrollController.animateTo(
                                  (MediaQuery.of(context).size.width *
                                      (index - 1)),
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_left_outlined,
                                color: AppColors.primaryColor,
                                size: 40.h,
                              )),
                        ),
                        IconButton(
                            onPressed: () async {
                              /* SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                             prefs.remove(Constants.cachedFaveQuotes);*/
                              Clipboard.setData(ClipboardData(
                                  text: quotes[index].quote!.quote ?? ''));
                            },
                            icon: Icon(
                              Icons.copy,
                              color: AppColors.primaryColor,
                              size: 40.h,
                            )),
                        IconButton(
                            onPressed: () {
                              quotes[index].favorite == true
                                  ? TabsScreensCubit.get(context)
                                      .removeFromFav(index)
                                  : TabsScreensCubit.get(context)
                                      .addToFav(index);
                            },
                            icon: quotes[index].favorite == true
                                ? Icon(
                                    Icons.favorite,
                                    color: AppColors.primaryColor,
                                    size: 40.h,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: AppColors.primaryColor,
                                    size: 40.h,
                                  )),
                        IconButton(
                            onPressed: () {
                              if (index == quotes.length - 2) {
                                print('pppppp');
                                TabsScreensCubit.get(context).getQuotesData();
                              }
                              scrollController.animateTo(
                                (MediaQuery.of(context).size.width *
                                    (index + 1)),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: AppColors.primaryColor,
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
