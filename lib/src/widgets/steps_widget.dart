import 'package:flutter/material.dart';

import '../utils.dart';

class StepsWidget extends StatefulWidget {
  final List<String> steps;
  final int currentStep;

  const StepsWidget(this.steps, this.currentStep, {Key? key}) : super(key: key);

  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {
  late List<String> _steps = [];
  late int _current = -1;

  int pastStep = -1;

  @override
  void initState() {
    super.initState();
    _steps = widget.steps;
  }

  void setVariables() {
    pastStep = _current;
    _current = widget.currentStep;
  }

  Widget _divider(bool completed) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 1),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 35,
      color: (!completed) ? PodiColors.neutrals[200] : PodiColors.green,
    );
  }

  Widget _collapsedStep(int step, {bool isCompleted = false}) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            border: isCompleted
                ? null
                : Border.all(color: PodiColors.neutrals[400]!),
            color: isCompleted ? PodiColors.green : null,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: PodiColors.white, size: 16)
                : Text(step.toString(),
                    style: PodiTexts.label2.withColor(
                      PodiColors.neutrals[400]!,
                    )),
          ),
        ),
        if ((step - 1) != (_steps.length - 1)) _divider(_current > (step - 1)),
      ],
    );
  }

  Widget _expandedStep(int step, String name) {
    return Row(
      children: [
        Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: PodiColors.neutrals[800],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
              child: Text(
            "$step - $name",
            style: PodiTexts.button2
                .size(13)
                .withColor(PodiColors.white)
                .heightCenter,
          )),
        ),
        if ((step - 1) != (_steps.length - 1)) _divider(_current > (step - 1)),
      ],
    );
  }

  Widget get _buildSteps {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(_steps.length, (index) {
          int thisStep = index + 1;
          if (_current == index) {
            return _expandedStep(thisStep, _steps[index]);
          } else {
            return _collapsedStep(thisStep, isCompleted: _current > index);
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    setVariables();
    return _buildSteps;
  }
}
