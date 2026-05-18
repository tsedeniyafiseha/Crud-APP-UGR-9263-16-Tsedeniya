// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomArticleModelAdapter extends TypeAdapter<CustomArticleModel> {
  @override
  final int typeId = 1;

  @override
  CustomArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomArticleModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      content: fields[3] as String?,
      imageUrl: fields[4] as String?,
      author: fields[5] as String?,
      category: fields[6] as String,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime?,
      notes: fields[9] as String?,
      rating: fields[10] as int,
      tags: (fields[11] as List).cast<String>(),
      isImportant: fields[12] as bool,
      summary: fields[13] as String?,
      personalReflection: fields[14] as String?,
      mood: fields[15] as String?,
      readCount: fields[16] as int,
      lastReadAt: fields[17] as DateTime?,
      estimatedReadTime: fields[18] as int,
      highlights: (fields[19] as List).cast<String>(),
      actionItems: fields[20] as String?,
      isArchived: fields[21] as bool,
      sourceUrl: fields[22] as String?,
      relatedTopics: (fields[23] as List).cast<String>(),
      keyTakeaway: fields[24] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomArticleModel obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.notes)
      ..writeByte(10)
      ..write(obj.rating)
      ..writeByte(11)
      ..write(obj.tags)
      ..writeByte(12)
      ..write(obj.isImportant)
      ..writeByte(13)
      ..write(obj.summary)
      ..writeByte(14)
      ..write(obj.personalReflection)
      ..writeByte(15)
      ..write(obj.mood)
      ..writeByte(16)
      ..write(obj.readCount)
      ..writeByte(17)
      ..write(obj.lastReadAt)
      ..writeByte(18)
      ..write(obj.estimatedReadTime)
      ..writeByte(19)
      ..write(obj.highlights)
      ..writeByte(20)
      ..write(obj.actionItems)
      ..writeByte(21)
      ..write(obj.isArchived)
      ..writeByte(22)
      ..write(obj.sourceUrl)
      ..writeByte(23)
      ..write(obj.relatedTopics)
      ..writeByte(24)
      ..write(obj.keyTakeaway);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
