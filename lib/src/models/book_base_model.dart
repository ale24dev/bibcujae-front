import 'package:json_annotation/json_annotation.dart';

part 'book_base_model.g.dart';

/// Clase que representa el modelo logico asociado a los jugadores.
@JsonSerializable(explicitToJson: true)
class BookBaseModel {
  @JsonKey(name: "libro_id")
  final int bookId;

  @JsonKey(name: "titulo")
  final String? title;

  @JsonKey(name: "entrada")
  final String? entry;

  @JsonKey(name: "tipoAutor")
  final String? authorType;

  @JsonKey(name: "autor")
  final String? author;

  @JsonKey(name: "otrosAutores")
  final String? otherAuthors;

  @JsonKey(name: "edicion")
  final String? edition;

  @JsonKey(name: "serie")
  final String? series;

  @JsonKey(name: "notas")
  final String? notes;

  @JsonKey(name: "annoPub")
  final String? publicationYear;

  @JsonKey(name: "mencionResp")
  final String? responsibilityMention;

  @JsonKey(name: "codDomicilio")
  final String? addressCode;

  @JsonKey(name: "isbn")
  final String? isbn;

  @JsonKey(name: "dewey")
  final String? dewey;

  @JsonKey(name: "evento")
  final String? event;

  @JsonKey(name: "otrosEventos")
  final String? otherEvents;

  @JsonKey(name: "publicacion")
  final String? publication;

  @JsonKey(name: "colacion")
  final String? collation;

  @JsonKey(name: "otrosTitulos")
  final String? otherTitles;

  @JsonKey(name: "folleto")
  final String? pamphlet;

  @JsonKey(name: "referencia")
  final String? reference;

  @JsonKey(name: "letrasEnt")
  final String? entryLetters;

  @JsonKey(name: "letraTitulo")
  final String? titleLetters;

  @JsonKey(name: "clasif")
  final String? classification;

  @JsonKey(name: "idioma")
  final String? language;

  @JsonKey(name: "pais")
  final String? country;

  BookBaseModel({
    required this.bookId,
    required this.title,
    required this.entry,
    required this.authorType,
    required this.author,
    required this.otherAuthors,
    required this.edition,
    required this.series,
    required this.notes,
    required this.publicationYear,
    required this.responsibilityMention,
    required this.addressCode,
    required this.isbn,
    required this.dewey,
    required this.event,
    required this.otherEvents,
    required this.publication,
    required this.collation,
    required this.otherTitles,
    required this.pamphlet,
    required this.reference,
    required this.entryLetters,
    required this.titleLetters,
    required this.classification,
    required this.language,
    required this.country,
  });

  factory BookBaseModel.fromJson(Map<String, dynamic> json) =>
      _$BookBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookBaseModelToJson(this);
}