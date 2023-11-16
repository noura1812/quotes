import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes/core/reusable%20widgets/toast.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/text_styles.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/presentation/cubit/tabs_screens_cubit.dart';

class FavTab extends StatefulWidget {
  const FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  late FToast fToast;
  @override
  void initState() {
    // TODO: implement initState
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabsScreensCubit, TabsScreensState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<QuotesDataEntity> quotes =
            TabsScreensCubit.get(context).localQuotesList;

        if (state is TabsScreensGetDataLocalFailureState) {
          return Center(
            child: Text(state.failures.toString()),
          );
        }
        if (state is TabsScreensGetDataLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (quotes.isEmpty) {
          return Center(
            child: Text(
              'no favorites yet ',
              style: poppins24W600(),
            ),
          );
        }
        return ListView.builder(
          physics: const PageScrollPhysics(),
          itemCount: quotes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 10.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quotes[index].quote!.quote ?? '',
                      style: poppins20W600(),
                    ),
                    Text(
                      '-${quotes[index].quote!.author}',
                      style: poppins18W400(),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black.withOpacity(.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () async {
                              Clipboard.setData(ClipboardData(
                                  text: quotes[index].quote!.quote ?? ''));
                            },
                            icon: Icon(
                              Icons.copy,
                              color: AppColors.primaryColor,
                              size: 30.h,
                            )),
                        IconButton(
                            onPressed: () {
                              TabsScreensCubit.get(context)
                                  .removeFromFav(index);

                              fToast.showToast(
                                child: toastMessage(
                                  'removed from favorite',
                                  icon: Icon(
                                    Icons.heart_broken,
                                    size: 25.h,
                                    color: Colors.red,
                                  ),
                                ),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: const Duration(seconds: 2),
                              );
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30.h,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
