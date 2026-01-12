// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventRecordAdapter extends TypeAdapter<EventRecord> {
  @override
  final int typeId = 0;

  @override
  EventRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventRecord(
      timestamp: fields[0] as DateTime,
      notes: fields[1] as String?,
      rating: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, EventRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.notes)
      ..writeByte(2)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
