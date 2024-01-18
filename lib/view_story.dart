import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class ViewStory extends StatefulWidget {
  const ViewStory({super.key});

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  final StoryController _storyController = StoryController();

  final List<StoryItem> _storyItems = [
    StoryItem.text(title: 'One', backgroundColor: Colors.blue),
    StoryItem.text(title: 'Two', backgroundColor: Colors.red),
    StoryItem.text(title: 'Three', backgroundColor: Colors.green),
  ];

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
          }
        ),
      ),
    );
  }
}
