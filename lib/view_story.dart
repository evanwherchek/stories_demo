import 'package:flutter/material.dart';
import 'package:stories_demo/story_arguments.dart';
import 'package:story_view/story_view.dart';

class ViewStory extends StatefulWidget {
  const ViewStory({super.key});

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  final StoryController _storyController = StoryController();
  final List<StoryItem> _storyItems = [];
  late StoryArguments _storyArguments;

  /// This variable tracks if all story items have been viewed so the variables
  /// for read and unread items aren't updated wrong.
  bool _cycleComplete = false;

  /// The story_view package doesn't have a built in way to track the index of 
  /// each story item so it has to be tracked manually with the index variable.
  int index = 0;

  /// Add the total slides to the story based on the arguments passed in.
  void _buildStoryItems() {
    for (int i = 0; i < (_storyArguments.unreadItems + _storyArguments.readItems); i++) {
      _storyItems.add(StoryItem.text(title: '${i + 1}', backgroundColor: Colors.blueAccent));
    }
  }

  @override
  Widget build(BuildContext context) {
    _storyArguments = ModalRoute.of(context)!.settings.arguments as StoryArguments;
    assert(_storyArguments.unreadItems > 0);

    _buildStoryItems();

    return Scaffold(
      body: SafeArea(
        child: StoryView(
            storyItems: _storyItems,
            controller: _storyController,
            repeat: true,
            onStoryShow: (s) {
              index++;

              /// Update the read and unread items for the story ring on Home.
              if (!s.shown && !_cycleComplete && (index > _storyArguments.readItems)) {
                _storyArguments.unreadItems -= 1;
                _storyArguments.readItems += 1;
              }
            },
            onComplete: () {
              index = 0;
              _cycleComplete = true;
            },
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                /// Go back to Home with the updated arguments for the story ring.
                Navigator.pop(context, _storyArguments);
              }
            }),
      ),
    );
  }
}
