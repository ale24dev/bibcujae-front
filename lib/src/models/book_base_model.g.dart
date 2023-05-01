// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookBaseModel _$BookBaseModelFromJson(Map<String, dynamic> json) =>
    BookBaseModel(
      bookId: json['libro_id'] as int?,
      title: json['titulo'] as String?,
      entry: json['entrada'] as String?,
      authorType: json['tipo_autor'] as String?,
      author: json['autor'] as String?,
      otherAuthors: json['otros_autores'] as String?,
      edition: json['edicion'] as String?,
      series: json['serie'] as String?,
      notes: json['notas'] as String?,
      publicationYear: json['anno_pub'] as String?,
      responsibilityMention: json['mencion_resp'] as String?,
      domCode: json['cod_domicilio'] as String?,
      isbn: json['isbn'] as String?,
      dewey: json['dewey'] as String?,
      event: json['evento'] as String?,
      otherEvents: json['otros_eventos'] as String?,
      publication: json['publicacion'] as String?,
      collation: json['colacion'] as String?,
      otherTitles: json['otros_titulos'] as String?,
      pamphlet: json['folleto'] as String?,
      reference: json['referencia'] as String?,
      entryLetters: json['letras_ent'] as String?,
      titleLetters: json['letra_titulo'] as String?,
      classification: json['clasif'] as String?,
      language: json['idioma'] as String?,
      country: json['pais'] as String?,
    );

Map<String, dynamic> _$BookBaseModelToJson(BookBaseModel instance) =>
    <String, dynamic>{
      'libro_id': instance.bookId,
      'titulo': instance.title,
      'entrada': instance.entry,
      'tipo_autor': instance.authorType,
      'autor': instance.author,
      'otros_autores': instance.otherAuthors,
      'edicion': instance.edition,
      'serie': instance.series,
      'notas': instance.notes,
      'anno_pub': instance.publicationYear,
      'mencion_resp': instance.responsibilityMention,
      'cod_domicilio': instance.domCode,
      'isbn': instance.isbn,
      'dewey': instance.dewey,
      'evento': instance.event,
      'otros_eventos': instance.otherEvents,
      'publicacion': instance.publication,
      'colacion': instance.collation,
      'otros_titulos': instance.otherTitles,
      'folleto': instance.pamphlet,
      'referencia': instance.reference,
      'letras_ent': instance.entryLetters,
      'letra_titulo': instance.titleLetters,
      'clasif': instance.classification,
      'idioma': instance.language,
      'pais': instance.country,
    };
