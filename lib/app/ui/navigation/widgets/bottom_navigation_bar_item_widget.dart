part of 'bottom_navigation_bar_imports.dart';

class BottomNavigationBarItemWidget extends BottomNavigationBarItem {
  BottomNavigationBarItemWidget({
    required String iconPath,
    Widget? noActiveIcon,
    Widget? activeIcon,
    String? label,
    String? tooltip,
    Color? backgroundColor,
  }) : super(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: noActiveIcon ??
                SvgPicture.asset(
                  iconPath,
                  color: Colors.grey,
                  width: AppWidgetConstants.navigationSizeIcon,
                  height: AppWidgetConstants.navigationSizeIcon,
                ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: activeIcon ??
                SvgPicture.asset(
                  iconPath,
                  color: Colors.grey,
                  width: AppWidgetConstants.navigationSizeIcon,
                  height: AppWidgetConstants.navigationSizeIcon,
                ),
          ),
          label: label,
          tooltip: tooltip,
          backgroundColor: backgroundColor,
        );
}
