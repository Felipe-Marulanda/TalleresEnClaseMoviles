import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({super.key, required this.title, this.bottom});

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF007B3E),
      bottom: bottom,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: const [
        _NavButton(label: 'Inicio', routeName: 'home'),
        _NavButton(label: 'Async', routeName: 'async_demo'),
        _NavButton(label: 'Isolate', routeName: 'isolate_demo'),
        _NavButton(label: 'Timer', routeName: 'timer_demo'),
        _NavButton(label: 'Parámetros', routeName: 'paso_parametros'),
        _NavButton(label: 'Ciclo de vida', routeName: 'ciclo_vida'),
        _NavButton(label: 'Widgets', routeName: 'widgets_demo'),
        SizedBox(width: 20),
      ],
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final String routeName;

  const _NavButton({required this.label, required this.routeName});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () {
          final router = GoRouter.of(context);
          final currentLocation = GoRouterState.of(context).matchedLocation;
          final target = router.namedLocation(widget.routeName);
          if (currentLocation != target) {
            router.goNamed(widget.routeName);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _hovering ? Colors.yellow[600] : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovering ? Colors.black : Colors.white,
              fontWeight: _hovering ? FontWeight.bold : FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
