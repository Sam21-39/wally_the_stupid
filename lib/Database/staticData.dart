class StaticData {
  static final String appName = 'Wally - The Supid';

  static final String about =
      '''Wally means "a stupid or silly person". But, why the name Wally? 
The app is simple and stupid. It is a game of taps. The user has to tap the screen for making the starting number into 0 or any other target number. Thus, the app name, Wally. 

The app requires Google Sign-In for account creation and to do the challenges. The user has to single/double-tap the screen to increment/decrement the starting number respectively. 

The app is simply for fun without any purpose. It has a ranking system but it's not refined like competitive games. Please, take the app and app content lightly and have some fun tapping...''';

  static final String appCopywrit = '''
  ~ © Appamania, Jan'22
  ''';

  static final String privacyURL =
      'https://www.termsfeed.com/live/ba2c5794-5a26-42c2-9273-eaf1248c4f66';

  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'sp.appamania24@gmail.com',
    query: _encodeQueryParameters(
        <String, String>{'subject': 'Example Subject & Symbols are allowed!'}),
  );
}
