/// StoryArguments is a class that is used to pass data between Home and ViewStory as one variable.
/// Passing the single object back and forth makes it easier to track which story items have been
/// read for the main UI.
class StoryArguments {
  StoryArguments(
      {required this.unreadItems,
      required this.readItems});

  int unreadItems;
  int readItems;
}
