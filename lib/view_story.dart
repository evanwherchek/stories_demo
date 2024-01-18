import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class ViewStory extends StatefulWidget {
  const ViewStory({super.key});

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  final StoryController _storyController = StoryController();
  final List<StoryItem> _storyItems = [];
  late int _totalItems;

  void _buildStoryItems() {
    for (int i = 0; i < _totalItems; i++) {
      _storyItems
          .add(StoryItem.text(title: '$i', backgroundColor: Colors.blueAccent));
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      _totalItems = ModalRoute.of(context)!.settings.arguments as int;
      assert(_totalItems > 0);

      _buildStoryItems();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StoryView(
            storyItems: _storyItems,
            controller: _storyController,
            repeat: true,
            onStoryShow: (s) {},
            onComplete: () {},
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            }),
      ),
    );
  }
}
