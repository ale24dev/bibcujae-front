// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estado_ejemplar_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstadoEjemplarBaseModel _$EstadoEjemplarBaseModelFromJson(
        Map<String, dynamic> json) =>
    EstadoEjemplarBaseModel(
      estadoEjemplarId: json['estado_ejemplar_id'] as int,
      estado: json['estado'] as String,
    );

Map<String, dynamic> _$EstadoEjemplarBaseModelToJson(
        EstadoEjemplarBaseModel instance) =>
    <String, dynamic>{
      'estado_ejemplar_id': instance.estadoEjemplarId,
      'estado': instance.estado,
    };
