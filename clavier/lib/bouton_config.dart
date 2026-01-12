import 'package:hive/hive.dart';

part 'bouton_config.g.dart';

@HiveType(typeId: 0)
class BoutonConfig {
  @HiveField(0)
  int canal;

  @HiveField(1)
  int note;

  @HiveField(2)
  int velocite;

  @HiveField(3)
  int pc;

  @HiveField(4)
  int volume;

  @HiveField(5)
  int pan;

  @HiveField(6)
  int expression;

  @HiveField(7)
  int brillance;

  @HiveField(8)
  int tremolo;

  @HiveField(9)
  int chorus;

  @HiveField(10)
  int timbre;

  @HiveField(11)
  int vibrato;

  @HiveField(12)
  int phaser;

  BoutonConfig({
    this.canal = 1,
    this.note = 0,
    this.velocite = 0,
    this.pc = 128,
    this.volume = 128,
    this.pan = 128,
    this.expression = 128,
    this.brillance = 128,
    this.tremolo = 128,
    this.chorus = 128,
    this.timbre = 128,
    this.vibrato = 128,
    this.phaser = 128,
  });
}
