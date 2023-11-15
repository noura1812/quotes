import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/reusable%20widgets/toast.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/core/utils/functions/lumination.dart';
import 'package:quotes/core/utils/images.dart';
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

class _HomeTabState extends State<HomeTab>
    with AutomaticKeepAliveClientMixin<HomeTab> {
  int page = 0;
  final ScrollController scrollController = ScrollController();
  late ScrollPosition scrollPosition;

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    scrollController.addListener(() {
      if (scrollController.offset % MediaQuery.of(context).size.width == 0) {
        TabsScreensCubit.get(context).currentOffset(scrollController.offset);

        page++;
        if (page % 2 == 0) {
          TabsScreensCubit.get(context).getQuotesData(true);
        }
      }
    });
  }

  bool first = true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<TabsScreensCubit, TabsScreensState>(
      listener: (context, state) {
        if (state is AddFavSuccessfully) {
          toastMessage(
            'added successful',
          );
        }
        if (state is RemoveFromFavSuccessfully) {
          toastMessage(
            'removed successful',
          );
        }
      },
      builder: (context, state) {
        List<QuotesDataEntity> quotes =
            TabsScreensCubit.get(context).remoteQuotesList;

        if (state is TabsScreensGetDataRemoteFailureState && quotes.isEmpty) {
          return Center(
            child: Text(
              Constants.errorMessage,
              style: poppins22W600(),
            ),
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
            if (first && TabsScreensCubit.get(context).listOffset != 0) {
              scrollController.animateTo(
                TabsScreensCubit.get(context).listOffset,
                duration: Duration(
                    milliseconds: (TabsScreensCubit.get(context)
                                    .listOffset
                                    .toInt() *
                                100) ==
                            0
                        ? 10
                        : (TabsScreensCubit.get(context).listOffset.toInt() *
                            1)),
                curve: Curves.easeInOut,
              );

              first = false;
            } else if (first) {
              first = false;
            }
            return Stack(
              children: [
                Image.network(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    quotes[index].image!.largeImageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                          LocalImages.blackImage,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 100,
                          fit: BoxFit.cover,
                        )),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  color: Colors.grey.withOpacity(.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 100,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quotes[index].quote!.quote ?? '',
                          style: poppins26W600().copyWith(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          '-${quotes[index].quote!.author}',
                          style: poppins22W400().copyWith(color: Colors.white),
                        ),
                      ],
                    ),
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
                                  duration: const Duration(milliseconds: 300),
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
                              Clipboard.setData(ClipboardData(
                                  text: quotes[index].quote!.quote ?? ''));
                              toastMessage('copied');
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
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible: quotes.length != index + 1,
                          child: IconButton(
                              onPressed: () {
                                scrollController.animateTo(
                                  (MediaQuery.of(context).size.width *
                                      (index + 1)),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: AppColors.primaryColor,
                                size: 40.h,
                              )),
                        ),
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

  @override
  bool get wantKeepAlive => true;
}
