part of navigation;

class NavigationScreen extends StatefulWidget {
  final int? routeToPageIndex;

  const NavigationScreen({Key? key, this.routeToPageIndex}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedTab = 0;

  final Map<int, GlobalKey<NavigatorState>> _navKeys = {};

  late final List<Widget> _screensList;

  @override
  void initState() {
    super.initState();

    _screensList = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => TaskBloc(
              taskGateway: injection(),
            )..add(const TaskEvent.fetch()),
          ),
          // BlocProvider(create: (_) => RefreshCubit()),
        ],
        child: const TaskScreen(),
      ),
      const Scaffold(),
    ];

    _initNavigationKeys();

    if (widget.routeToPageIndex != null) {
      _selectedTab = widget.routeToPageIndex!;
    }
  }

  void _initNavigationKeys() {
    _screensList.asMap().forEach((i, element) {
      _navKeys.putIfAbsent(i, () => GlobalKey<NavigatorState>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: WillPopScope(
          onWillPop: () async => (await navigatorKeyById?.maybePop() ?? true),
          child: IndexedStack(
            index: _selectedTab,
            children: List.generate(
              _screensList.length,
              (index) => Navigator(
                key: _navKeys[index],
                onGenerateRoute: (route) => MaterialPageRoute<void>(
                  settings: route,
                  builder: (context) => _screensList[index],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _selectedTab,
        onTap: (newSelectedTab) {
          if (_selectedTab == newSelectedTab) {
            navigatorKeyById?.popUntil((route) => route.isFirst);
          }

          setState(() => _selectedTab = newSelectedTab);
        },
      ),
    );
  }

  NavigatorState? get navigatorKeyById => _navKeys[_selectedTab]?.currentState;
}
