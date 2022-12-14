import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/providers/backend_streams_and_futures_provider.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variable.dart';
import 'package:instagram_flutter/widgets/loading_screen.dart';
import 'package:instagram_flutter/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: StreamBuilder<Iterable<Post>>(
        stream: Provider.of<BackendStreamsAndFuturesProvider>(context)
            .streamAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LoadingScreen(),
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: width > webScreenSize ? width * 0.3 : 0,
              vertical: width > webScreenSize ? 15 : 0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children:
                    snapshot.data!.map((post) => PostCard(post: post)).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
