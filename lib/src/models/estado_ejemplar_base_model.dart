import 'package:json_annotation/json_annotation.dart';

part 'estado_ejemplar_base_model.g.dart';

/// Clase que representa el modelo logico asociado a los jugadores.
@JsonSerializable(explicitToJson: true)
class EstadoEjemplarBaseModel {
  @JsonKey(name: "estado_ejemplar_id")
  final int estadoEjemplarId;

  @JsonKey(name: "estado")
  final String estado;

  EstadoEjemplarBaseModel({
    required this.estadoEjemplarId,
    required this.estado,
  });

  factory EstadoEjemplarBaseModel.fromJson(Map<String, dynamic> json) =>
      _$EstadoEjemplarBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EstadoEjemplarBaseModelToJson(this);
}
