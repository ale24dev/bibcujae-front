import 'package:json_annotation/json_annotation.dart';

import 'package:bibcujae/src/models/book_base_model.dart';

import '../entities/ejemplar_entity.dart';
import '../shared/parser_utils.dart';
import 'estado_ejemplar_base_model.dart';

part 'ejemplar_base_model.g.dart';

/// Clase que representa el modelo logico asociado a los jugadores.
@JsonSerializable(explicitToJson: true)
class EjemplarBaseModel {
  @JsonKey(name: "ejemplar_id")
  final int? ejemplarId;

  @JsonKey(name: "libro")
  final BookBaseModel? book;

  @JsonKey(name: "cod_barras")
  final String? codBarras;

  final String? subdivision1;

  final String? subdivision2;

  @JsonKey(name: "no_ingreso")
  final String? noIngreso;

  @JsonKey(name: "fecha_ingreso", fromJson: ParserUtils.parseDate)
  final String? fechaIngreso;

  final String? ubicacion;

  @JsonKey(name: "via_adq")
  final String? viaAdq;

  final String? procedencia;

  final double? precio;

  @JsonKey(name: "estado_ejemplar")
  final EstadoEjemplarBaseModel? estadoEjemplar;

  EjemplarBaseModel({
    this.ejemplarId,
    this.book,
    this.codBarras,
    this.fechaIngreso,
    this.noIngreso,
    this.precio,
    this.procedencia,
    this.subdivision1,
    this.subdivision2,
    this.ubicacion,
    this.viaAdq,
    this.estadoEjemplar,
  });

  factory EjemplarBaseModel.fromJson(Map<String, dynamic> json) =>
      _$EjemplarBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EjemplarBaseModelToJson(this);

  factory EjemplarBaseModel.parseEntityToModel(EjemplarEntity ejemplarEntity) {
    EjemplarBaseModel ejemplar = EjemplarBaseModel(
      ejemplarId: ejemplarEntity.ejemplarId,
      estadoEjemplar: ejemplarEntity.estadoEjemplar,
      book: ejemplarEntity.book,
      codBarras: ejemplarEntity.codBarras,
      fechaIngreso: ejemplarEntity.fechaIngreso,
      noIngreso: ejemplarEntity.noIngreso,
      precio: ejemplarEntity.precio,
      procedencia: ejemplarEntity.procedencia,
      subdivision1: ejemplarEntity.subdivision1,
      subdivision2: ejemplarEntity.subdivision2,
      ubicacion: ejemplarEntity.ubicacion,
      viaAdq: ejemplarEntity.viaAdq,
    );
    return ejemplar;
  }
}
