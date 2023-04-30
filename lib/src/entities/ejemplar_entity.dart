import '../models/book_base_model.dart';
import '../models/estado_ejemplar_base_model.dart';

class EjemplarEntity {
  final int? ejemplarId;

  final BookBaseModel? book;

  final String? codBarras;

  final String? subdivision1;

  final String? subdivision2;

  final String? noIngreso;

  final String? fechaIngreso;

  final String? ubicacion;

  final String? viasAdq;

  final String? procedencia;

  final double? precio;

  final EstadoEjemplarBaseModel? estadoEjemplar;

  const EjemplarEntity({
    this.ejemplarId,
    this.book,
    this.codBarras,
    this.estadoEjemplar,
    this.fechaIngreso,
    this.noIngreso,
    this.precio,
    this.procedencia,
    this.subdivision1,
    this.subdivision2,
    this.ubicacion,
    this.viasAdq,
  });

  @override
  String toString() {
    return 'EjemplarEntity{'
        ' ejemplarId: $ejemplarId,'
        ' book: $book,'
        ' codBarras: $codBarras,'
        ' subdivision1: $subdivision1,'
        ' subdivision2: $subdivision2,'
        ' noIngreso: $noIngreso,'
        ' fechaIngreso: $fechaIngreso,'
        ' ubicacion: $ubicacion,'
        ' viasAdq: $viasAdq,'
        ' procedencia: $procedencia,'
        ' precio: $precio,'
        ' estadoEjemplar: $estadoEjemplar'
        '}';
  }
}
