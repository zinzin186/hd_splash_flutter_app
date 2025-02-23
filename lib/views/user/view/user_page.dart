import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/user/user.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    List<Map> tabs = [];
    if (user.totalPhotos != 0) {
      tabs.add({"tab": const TabPhotosView(), "title": "photos"});
    }
    if (user.totalLikes != 0) {
      tabs.add({"tab": const TabLikesView(), "title": "like"});
    }
    if (user.totalCollections != 0) {
      tabs.add({"tab": const TabCollectionsView(), "title": "collections"});
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          title: Text(user.username),
          actions: [ButtonOpenUrlHtml(uri: user.links.html)],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: UserWidget(),
              ),
            ];
          },
          body: DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  tabs: tabs
                      .map((tab) => Tab(
                            text: context.lang(tab["title"]),
                          ))
                      .toList(),
                ),
                Expanded(
                  child: BlocBuilder<UserCubit, UserState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      switch (state.status) {
                        case StatusType.loading:
                          return const AppLoadingWidget();
                        case StatusType.error:
                          return const AppErrorWidget();
                        case StatusType.loaded:
                          return TabBarView(
                            children: tabs
                                .map((tab) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: tab["tab"],
                                    ))
                                .toList(),
                          );
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
