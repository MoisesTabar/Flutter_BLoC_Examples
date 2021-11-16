import 'package:counter_app/src/services/cubit/counter_cubit.dart';
import 'package:counter_app/src/widgets/slider_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({Key? key}) : super(key: key);

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _animation;
  late double _animationPositionX;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: -0.5,
      upperBound: 0.5
    );
    _controller.value = 0.0;

    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(1.5, 0.0)
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double offsetFromGlobalPosition(Offset globalPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset local = box.globalToLocal(globalPosition);
    _animationPositionX = ((local.dx * 0.75) / box.size.width) - 0.4;

    return ((local.dx * 0.75) / box.size.width) - 0.4;
  }

  void _dragStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPosition(details.globalPosition);
  }

  void _dragUpdate(DragUpdateDetails details) {
    _controller.value = offsetFromGlobalPosition(details.globalPosition);
  }

  void _dragEnded(DragEndDetails details) {
    _controller.stop();
    if(_controller.value <= -0.10) {
      context.read<CounterCubit>().decrease();
    }

    if(_controller.value >= 0.10){
      context.read<CounterCubit>().increment();
    }
    
    _controller.animateTo(
      0.0,
      curve: Curves.bounceOut,
      duration: const Duration(milliseconds: 500)
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: 280.0,
        height: 120.0,
        child: Material(
          type: MaterialType.canvas,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(50.0),
          color: const Color(0xFF90A4AE).withOpacity(0.2),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget> [
              const Positioned(
                left: 10.0,
                bottom: null,
                child: Icon(Icons.remove, size: 40.0, color: Color(0xFFFFFFFF))
              ),
              const Positioned(
                right: 10.0,
                top: null,
                child: Icon(Icons.add, size: 40.0, color: Color(0xFFFFFFFF))
              ),
              GestureDetector(
                onHorizontalDragStart: _dragStart,
                onHorizontalDragUpdate: _dragUpdate,
                onHorizontalDragEnd: _dragEnded,
                child: SlideTransition(
                  position: _animation,
                  child: const SliderSwitcher(),
                ),
              )
            ]
          )
        )
      )
    );
  }
}