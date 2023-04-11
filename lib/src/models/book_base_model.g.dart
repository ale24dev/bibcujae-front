// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookBaseModel _$BookBaseModelFromJson(Map<String, dynamic> json) =>
    BookBaseModel(
      bookId: json['libro_id'] as int,
      title: json['titulo'] as String?,
      entry: json['entrada'] as String?,
      authorType: json['tipoAutor'] as String?,
      author: json['autor'] as String?,
      otherAuthors: json['otrosAutores'] as String?,
      edition: json['edicion'] as String?,
      series: json['serie'] as String?,
      notes: json['notas'] as String?,
      publicationYear: json['annoPub'] as String?,
      responsibilityMention: json['mencionResp'] as String?,
      addressCode: json['codDomicilio'] as String?,
      isbn: json['isbn'] as String?,
      dewey: json['dewey'] as String?,
      event: json['evento'] as String?,
      otherEvents: json['otrosEventos'] as String?,
      publication: json['publicacion'] as String?,
      collation: json['colacion'] as String?,
      otherTitles: json['otrosTitulos'] as String?,
      pamphlet: json['folleto'] as String?,
      reference: json['referencia'] as String?,
      entryLetters: json['letrasEnt'] as String?,
      titleLetters: json['letraTitulo'] as String?,
      classification: json['clasif'] as String?,
      language: json['idioma'] as String?,
      country: json['pais'] as String?,
    );

Map<String, dynamic> _$BookBaseModelToJson(BookBaseModel instance) =>
    <String, dynamic>{
      'libro_id': instance.bookId,
      'titulo': instance.title,
      'entrada': instance.entry,
      'tipoAutor': instance.authorType,
      'autor': instance.author,
      'otrosAutores': instance.otherAuthors,
      'edicion': instance.edition,
      'serie': instance.series,
      'notas': instance.notes,
      'annoPub': instance.publicationYear,
      'mencionResp': instance.responsibilityMention,
      'codDomicilio': instance.addressCode,
      'isbn': instance.isbn,
      'dewey': instance.dewey,
      'evento': instance.event,
      'otrosEventos': instance.otherEvents,
      'publicacion': instance.publication,
      'colacion': instance.collation,
      'otrosTitulos': instance.otherTitles,
      'folleto': instance.pamphlet,
      'referencia': instance.reference,
      'letrasEnt': instance.entryLetters,
      'letraTitulo': instance.titleLetters,
      'clasif': instance.classification,
      'idioma': instance.language,
      'pais': instance.country,
    };
