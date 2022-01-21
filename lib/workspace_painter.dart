import 'package:flutter/material.dart';
import 'package:pendulum/main.dart';
import 'package:pendulum/models/models.dart';

class WorkspacePainter extends CustomPainter {
  final List<Pendulum> pendulums;
  final bool velocity;
  final int id;
  final Vector center;

  WorkspacePainter(this.pendulums, this.center, this.id, this.velocity);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(center.x, center.y);
    canvas.scale(scale, scale);
    Paint pencil = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    Paint selected = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;
    Paint base = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 10 / scale
      ..color = Colors.black;
    Paint redpen = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    canvas.drawLine(Offset(-30 / scale, 0), Offset(30 / scale, 0), base);

    int length = pendulums.length;
    for (int i = 0; i < length; i++) {
      if (pendulums[i] != null) {
        canvas.drawLine(Vector(0, 0).off(), pendulums[i].offset(), pencil);
        canvas.drawCircle(
            pendulums[i].offset(), 10 / scale, (i != id) ? pencil : selected);
        if (velocity) {
          Vector velocity =
              pendulums[i].position() + pendulums[i].velocity() * 3;
          canvas.drawLine(pendulums[i].offset(), velocity.off(), redpen);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
