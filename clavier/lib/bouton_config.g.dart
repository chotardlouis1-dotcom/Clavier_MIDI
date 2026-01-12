// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bouton_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoutonConfigAdapter extends TypeAdapter<BoutonConfig> {
  @override
  final int typeId = 0;

  @override
  BoutonConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoutonConfig(
      canal: fields[0] as int,
      note: fields[1] as int,
      velocite: fields[2] as int,
      pc: fields[3] as int,
      volume: fields[4] as int,
      pan: fields[5] as int,
      expression: fields[6] as int,
      brillance: fields[7] as int,
      tremolo: fields[8] as int,
      chorus: fields[9] as int,
      timbre: fields[10] as int,
      vibrato: fields[11] as int,
      phaser: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BoutonConfig obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.canal)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.velocite)
      ..writeByte(3)
      ..write(obj.pc)
      ..writeByte(4)
      ..write(obj.volume)
      ..writeByte(5)
      ..write(obj.pan)
      ..writeByte(6)
      ..write(obj.expression)
      ..writeByte(7)
      ..write(obj.brillance)
      ..writeByte(8)
      ..write(obj.tremolo)
      ..writeByte(9)
      ..write(obj.chorus)
      ..writeByte(10)
      ..write(obj.timbre)
      ..writeByte(11)
      ..write(obj.vibrato)
      ..writeByte(12)
      ..write(obj.phaser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoutonConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
