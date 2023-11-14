import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/text_styles.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/presentation/cubit/tabs_screens_cubit.dart';

class FavTab extends StatelessWidget {
  const FavTab({super.key});

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
        if (state is TabsScreensGetDataLoadingState || quotes.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
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
                            onPressed: () async {},
                            icon: Icon(
                              Icons.copy,
                              size: 30.h,
                              color: AppColors.primaryColor,
                            )),
                        IconButton(
                            onPressed: () {
                              TabsScreensCubit.get(context)
                                  .removeFromFav(index);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: AppColors.primaryColor,
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
