// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ejemplar_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EjemplarBaseModel _$EjemplarBaseModelFromJson(Map<String, dynamic> json) =>
    EjemplarBaseModel(
      ejemplarId: json['ejemplar_id'] as int?,
      book: json['libro'] == null
          ? null
          : BookBaseModel.fromJson(json['libro'] as Map<String, dynamic>),
      codBarras: json['cod_barras'] as String?,
      fechaIngreso: ParserUtils.parseDate(json['fecha_ingreso'] as String),
      noIngreso: json['no_ingreso'] as String?,
      precio: (json['precio'] as num?)?.toDouble(),
      procedencia: json['procedencia'] as String?,
      subdivision1: json['subdivision1'] as String?,
      subdivision2: json['subdivision2'] as String?,
      ubicacion: json['ubicacion'] as String?,
      viasAdq: json['vias_adq'] as String?,
      estadoEjemplar: EstadoEjemplarBaseModel.fromJson(
          json['estado_ejemplar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EjemplarBaseModelToJson(EjemplarBaseModel instance) =>
    <String, dynamic>{
      'ejemplar_id': instance.ejemplarId,
      'libro_id': instance.book?.bookId,
      'cod_barras': instance.codBarras,
      'subdivision1': instance.subdivision1,
      'subdivision2': instance.subdivision2,
      'no_ingreso': instance.noIngreso,
      'fecha_ingreso': instance.fechaIngreso,
      'ubicacion': instance.ubicacion,
      'vias_adq': instance.viasAdq,
      'procedencia': instance.procedencia,
      'precio': instance.precio,
      'estado_ejemplar': instance.estadoEjemplar?.toJson(),
    };
