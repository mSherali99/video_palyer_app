import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:video_palyer_app/data/source/remote/api/second_api.dart';
import 'package:video_palyer_app/presentation/components/no_internet_connection.dart';
import 'package:video_palyer_app/presentation/components/shimmer_component.dart';
import 'package:video_palyer_app/presentation/components/video_item.dart';
import 'package:video_palyer_app/presentation/screen/second_page/favourite_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final block = FavouriteBlock(GetIt.I.get<SecondApi>());
  final textFiledController = TextEditingController();

  void onClick() {}

  @override
  void initState() {
    block.add(Loading(search: textFiledController.text));
    textFiledController.addListener(() {
      block.add(Loading(search: textFiledController.text));
    });
    super.initState();
  }

  @override
  void dispose() {
    block.close();
    textFiledController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: block,
      child: BlocBuilder<FavouriteBlock, FavouriteState>(
        builder: (context, state) {
          /*final snackBar = SnackBar(
            content: Text(state.message),
            action: SnackBarAction(
              label: 'Try again',
              onPressed: () {
                block.add(Loading(search: textFiledController.text));
              },
            ),
          );

         if (state.status == EnumStatus.fail) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }*/

          return Scaffold(
            body: state.status == EnumStatus.fail
                ? NoInternetWidget(onTab: (){
                  block.add(Loading(search: textFiledController.text));
            },)
                : SafeArea(
                    child: RefreshIndicator(
                      onRefresh:_refreshData,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              child: const Text(
                                "Homes",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              )),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: TextField(
                              controller: textFiledController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent.shade400),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: "Search...",
                                  focusColor: Colors.redAccent.shade400,
                                  prefixIconColor: Colors.redAccent.shade400,
                                  prefixIcon: const Icon(
                                    Icons
                                        .search, /*,color: Colors.redAccent.shade400*/
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey[500])),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (state.status == EnumStatus.loading)
                            const ShimmerComponent()
                          else if (state.status == EnumStatus.success)
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: state.videosList.length,
                                    itemBuilder: (_, i) {
                                      return VideoItem(
                                        lessonData: state.videosList[i],
                                        onClick: (videoData) {
                                          block.add(OpenDetailsScreen2(
                                              videoData: state.videosList[i],
                                              context: context));
                                        },
                                      );
                                    }),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
  Future<void> _refreshData() async {
    block.add(Loading(search: textFiledController.text));
    await Future.delayed(const Duration(milliseconds: 1500));
  }
}
